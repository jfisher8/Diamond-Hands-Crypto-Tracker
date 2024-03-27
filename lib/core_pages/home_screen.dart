import 'package:diamond_hands_crypto_tracker/core_pages/latest_crypto_news.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/latest_crypto_prices.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/home_screen_carousels/crypto_news_carousel.dart';
import 'package:diamond_hands_crypto_tracker/home_screen_carousels/crypto_prices_carousel.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:diamond_hands_crypto_tracker/main.dart';
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
      appBar: BuildAppBar(
        title: const Text('Diamond Hands Crypto Tracker'),
        appBar: AppBar(),
        widgets: [
          IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen())),
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
                            builder: ((context) => const LatestCryptoNews())));
                  }),
                  child: Text("View more",
                      style: Theme.of(context).textTheme.titleSmall)),
            ],
          ),
        ),
        buildCryptoNews(context),
      ])),
    );
  }
}
