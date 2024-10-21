import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diamond_hands_crypto_tracker/api_functions/get_and_store_price_data.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/latest_crypto_news.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/latest_crypto_prices.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/read_news_article.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:diamond_hands_crypto_tracker/data_models/article_model.dart';
import 'package:diamond_hands_crypto_tracker/data_models/coin_model.dart';
import 'package:diamond_hands_crypto_tracker/api_functions/get_article_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/favourites_screen.dart';
import 'package:diamond_hands_crypto_tracker/widgets/status_components.dart';
import 'dart:developer' as developer;

  Widget buildList(QuerySnapshot snapshot) {
    return ListView.builder( //returns a list view builder
        itemCount: snapshot.docs.length, //sets the item count to the length of the snapshot doc
        itemBuilder: (context, index) {
          //variable doc initialised with the value of the doc snapshot index, allowing properties to be accessed
          final doc = snapshot.docs[index];
          String docName = doc["name"];
          String docImage = doc["image"];
          String docPrice = doc["price"];
          return Container( //return a container widget
              key: Key(doc.id), //assign the key doc.id to the container
              child: Card( //return a Card child widget
                  child: ListTile( //return a ListTile as the child widget
                key: Key(doc.id),
                //set the title of the list tile to the movieName document,
                //pulls the saved movie titles from the Firestore cloud database
                title: Text(doc["name"],
                    style: Theme.of(context).textTheme.bodyLarge), //assigns bodyLarge text theme to the retrieved movie title
                trailing: const Icon(Icons.delete_forever, color: Colors.red), //adds a trailing delete forever icon in colour red
                onTap: () => showDialog( //when the delete forever icon is tapped, show a dialog
                    context: context,
                    barrierDismissible: false, //disable the user's ability to tap off the dialog to dismiss it, forcing them to choose an action
                    builder: (BuildContext context) => AlertDialog( //builds an AlertBox that the user must interact with
                          title: Text('Remove $docName from Watchlist?', //sets the title of such to the subject of the AlertBox - asking if the user wants to remove the movie
                              style: Theme.of(context).textTheme.titleSmall), //styling set to titleSmall text theme
                          content: Text( //content text widget set to provide more detail to the user about their pending action
                            'Are you sure you want to remove $docName from your Watchlist? This cannot be undone.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          actions: <Widget>[ //action options of the alert box set up so that multiple widgets options can be shown
                            TextButton( //first text button set as a Cancel option - allowing the user to go back to their Watchlist without deleting the movie
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: Text('Cancel', style: GoogleFonts.questrial(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold)),
                            ),
                            TextButton( //second text button set as the confirm option
                              key: Key(doc.id),
                              onPressed: () { //when the text button is pressed
                                Navigator.pop(context, 'Delete Movie');
                                FirebaseFirestore.instance
                                    .collection("coins") //get an instance of the movieWatchlist collection in Firestore
                                    .doc(doc.id) //pass in the specific document ID of the targetted movie title in Firestore
                                    .delete(); //and delete it from the cloud database
                              },
                              child: Text('Delete Movie', style: GoogleFonts.questrial(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        )),
              )));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Your Movie Watchlist",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          elevation: 0.0,
          backgroundColor: const Color(0xff191826),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            StreamBuilder<QuerySnapshot>( //builds a stream that listens to what the Firestore database has stored in it
                stream: FirebaseFirestore.instance //the stream is defined as an instance of the movieWatchlist collection
                    .collection("movieWatchlist")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) { //if the snapshot does not have data
                    return Column(children: const <Widget>[ //return a column with multiple widget children
                      CircularProgressIndicator(), //display circular progress indicator
                      SizedBox(height: 5), //with a sized box with a height of 5 to add separation
                      Center(child: Text("Loading...")) //add a central text widget underneath stating that the data is loading
                    ]);
                  } else { //else, if the snapshot has data
                    //returned the buildList widget as defined above and pass the snapshot data into it
                    //so that the movie's title can be displayed from Firestore
                    return Expanded(child: buildList(snapshot.data!));
                  }
                })
          ]),
        ));
  }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Article>> futureArticle;
  late Future<List<Coin>> futureCoin;

  @override
  void initState() {
    super.initState();
    futureArticle = getArticleData();
    futureCoin = fetchCoin();
    //FirestoreService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: BuildAppBar(
          title: Text('Diamond Hands Crypto Tracker',
              style: Theme.of(context).textTheme.titleLarge),
          appBar: AppBar(),
          widgets: [
            FirebaseAuth.instance.currentUser != null
                ? IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FavouritesScreen()),
                      );
                    },
                    icon:
                        const Icon(Icons.bookmark_rounded, color: Colors.black))
                : IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    icon: const Icon(Icons.login_rounded, color: Colors.black)),
          ],
        ),
        drawer: const NavigationMenu(),
        body: SingleChildScrollView(
                child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Latest Crypto Prices",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LatestCryptoPrices()));
                    },
                    child: Text(
                      "View more",
                      style: Theme.of(context).textTheme.titleSmall,
                    ))
              ],
            ),
          ),
          Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore
                    .instance
                    .collection("coins")
                    .snapshots(),
                //stream: FirebaseFirestore.instance.collection("coins").snapshots(),
                builder: (context, snapshot) {
                  developer.log("it gets past stream of streambuilder");
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    developer.log("snapshot connection state is waiting");
                    return buildLoadingCoinsStatus(context);
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    developer.log("Connection state is done");
                    if (snapshot.hasData) {
                      developer.log("the snapshot does have data");
                      //final doc = snapshot.data;
                      //String coinName = "test";
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          child: SizedBox(
                              height: 230,
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 10),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final doc = snapshot.data!.docs[index];
                                  String price = doc["price"];
                                  String image = doc["image"];
                                  String name = doc["name"];
                                  developer.log(
                                      " Doc image link is: ${snapshot.data!.docs[index]['image']}");
                                  developer.log(
                                      " Doc price data is: ${snapshot.data!.docs[index]['price']}");
                                  //Map<String, dynamic> documentData = documents[index].data() as Map<String, dynamic>;
                                  //developer.log(documents.length.toString());
                                  //String documentID = documents[index].id;
                                  return SizedBox(
                                    width: 150,
                                    height: 150,
                                    child: Column(
                                      children: [
                                        CachedNetworkImage(
                                            imageUrl: image,
                                            placeholder: (url, error) =>
                                                buildLoadingIcon(context),
                                            errorWidget:
                                                (context, url, error) =>
                                                    buildErrorIcon(context)),
                                        const SizedBox(height: 5),
                                        Text(name,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge),
                                        Text("£${price.toString}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge)
                                      ],
                                    ),
                                  );
                                },
                                itemCount: 4,
                              )),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      developer.log("snapshot DOES have an error");
                      return buildCoinsErrorStatus(context);
                    }
                  }
                  developer.log("for some reason there's an error");
                  developer.log(snapshot.error.toString());
                  return buildCoinsErrorStatus(context);
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Latest Crypto News",
                    style: Theme.of(context).textTheme.titleMedium),
                TextButton(
                    onPressed: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  const LatestCryptoNews())));
                    }),
                    child: Text("View more",
                        style: Theme.of(context).textTheme.titleSmall)),
              ],
            ),
          ),
          Column(children: [
            FutureBuilder<List<Article>>(
                future: futureArticle,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == null || snapshot.hasError) {
                      return buildNewsErrorStatus(context);
                    } else {
                      return Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            child: SizedBox(
                              height: 320,
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 10),
                                itemCount: snapshot.data.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: 200,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 5),
                                        Card(
                                          child: ListTile(
                                            trailing: IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ReadNewsArticle(
                                                                  article: snapshot
                                                                          .data[
                                                                      index])));
                                                },
                                                icon: const Icon(Icons
                                                    .arrow_forward_rounded)),
                                            title: Text(snapshot
                                                .data[index].title
                                                .toString()),
                                            subtitle: Text(snapshot
                                                .data[index].source.name),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ));
                    }
                  } else {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return buildLoadingNewsStatus(context);
                    }
                  }
                  return buildNewsErrorStatus(context);
                }),
          ]),
        ])));
  }
}
