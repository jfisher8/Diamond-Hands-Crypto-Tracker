import 'package:diamond_hands_crypto_tracker/core_pages/latest_crypto_prices.dart';
import 'package:diamond_hands_crypto_tracker/home_screen_carousels/crypto_news_carousel.dart';
import 'package:diamond_hands_crypto_tracker/home_screen_carousels/crypto_prices_carousel.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(56, 182, 255, 1.0),
        centerTitle: true,
        title: const Text('Diamond Hands Crypto Tracker'),
        actions: const <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Icon(
                Icons.login,
                color: Colors.black,
              )),
        ],
      ),
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
                            builder: (context) => const LatestCryptoPrices()));
                  },
                  child: Text(
                    "View more",
                    style: Theme.of(context).textTheme.titleSmall,
                  ))
            ],
          ),
        ),
        buildCryptoPrices(context),
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
                            builder: ((context) => const HomeScreen())));
                  }),
                  child: Text("View More News",
                      style: Theme.of(context).textTheme.titleSmall)),
            ],
          ),
        ),
        buildCryptoNews(context),
      ])),
      drawer: const NavigationMenu(),
    );
  }
}
