import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data_models/coin_model.dart';
import 'dart:async';
import 'package:diamond_hands_crypto_tracker/core_pages/latest_crypto_news.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/latest_crypto_prices.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:diamond_hands_crypto_tracker/data_models/article_model.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/read_news_article.dart';
import 'package:diamond_hands_crypto_tracker/api_functions/get_article_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/favourites_screen.dart';
import 'package:diamond_hands_crypto_tracker/widgets/status_components.dart';
import 'dart:developer' as developer;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Article>> futureArticle;

  @override
  void initState() {
    super.initState();
    futureArticle = getArticleData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Stream<List<Coin>> _coinStream() {
    return FirebaseFirestore.instance
        .collection('coins')
        .snapshots()
        .map((snapshot) {
      for (var doc in snapshot.docs) {
        //developer.log("Firestore doc data: ${doc.data()}");
        //developer.log('_coinStream running as intended');
      }
      return snapshot.docs
          .map((doc) => Coin.fromFirestore(doc.data()))
          .toList();
    });
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
            Column(children: [
              StreamBuilder<List<Coin>>(
                stream: _coinStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    developer.log(snapshot.data.toString());
                    return Center(child: buildCoinsErrorStatus(context));
                  }
                  final coins = snapshot.data!;
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
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  final coin = coins[index];
                                  return SizedBox(
                                      width: 150,
                                      height: 150,
                                      child: Column(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: coin.imageURL.toString(),
                                            placeholder: (url, error) =>
                                                buildLoadingIcon(context),
                                            errorWidget:
                                                (context, url, error) =>
                                                    buildErrorIcon(context),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(coin.name.toString(),
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge),
                                          Text(
                                              "£${coin.price.toStringAsFixed(2)}")
                                        ],
                                      ));
                                },
                              ))));
                },
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return buildLoadingNewsStatus(context);
                        }
                      }
                      return buildNewsErrorStatus(context);
                    }),
              ]),
            ])
          ]),
        ));
  }
}
