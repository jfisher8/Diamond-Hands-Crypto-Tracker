import 'package:diamond_hands_crypto_tracker/api_functions/get_price_data.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/latest_crypto_news.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/latest_crypto_prices.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:diamond_hands_crypto_tracker/data_models/article_model.dart';
import 'package:diamond_hands_crypto_tracker/data_models/coin_model.dart';
import 'package:diamond_hands_crypto_tracker/api_functions/get_article_data.dart';
import 'package:diamond_hands_crypto_tracker/widgets/coin_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/favourites_screen.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: BuildAppBar(
          title: const Text('Diamond Hands Crypto Tracker'),
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
              FutureBuilder<List<Coin>>(
                future: futureCoin,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: Column(
                      children: [
                        SizedBox(height: 40),
                        CircularProgressIndicator(),
                        SizedBox(height: 40),
                        Text('Waiting for data...'),
                      ],
                    ));
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
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
                                  return CoinCard(
                                    name: coinList[index].name,
                                    symbol: coinList[index].symbol,
                                    imageUrl: coinList[index].imageURL,
                                    price: coinList[index].price.toString(),
                                    change: coinList[index].change,
                                    changePercentage: coinList[index].changePercentage);
                                },
                                itemCount: coinList.length,
                              )),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            CircularProgressIndicator(),
                            SizedBox(height: 40),
                            Text('Error loading data...')
                          ],
                        ),
                      );
                    }
                  }
                  return const Center(
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        CircularProgressIndicator(),
                        SizedBox(height: 40),
                        Text('Error loading data...')
                      ],
                    ),
                  );
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
                      return const Column(
                        children: [
                          CircularProgressIndicator(),
                          Center(child: Text('Error loading News...'))
                        ],
                      );
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
                                                  //logic here
                                                },
                                                icon: const Icon(Icons
                                                    .open_in_new_outlined)),
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
                      return const Column(
                        children: [
                          SizedBox(height: 40),
                          CircularProgressIndicator(),
                          SizedBox(height: 40),
                          Text('Loading news...'),
                        ],
                      );
                    }
                  }
                  return const CircularProgressIndicator();
                }),
          ]),
        ])));
  }
}