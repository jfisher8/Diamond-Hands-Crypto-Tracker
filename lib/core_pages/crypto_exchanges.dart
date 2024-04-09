import 'package:diamond_hands_crypto_tracker/data_models/exchanges_model.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/favourites_screen.dart';
import 'package:diamond_hands_crypto_tracker/widgets/exchanges_card_widget.dart';

class CryptoExchanges extends StatefulWidget {
  const CryptoExchanges({super.key});

  @override
  State<CryptoExchanges> createState() => _CryptoExchangesState();
}

class _CryptoExchangesState extends State<CryptoExchanges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        title: const Text('Crypto Exchanges'),
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
                  icon: const Icon(Icons.bookmark_rounded, color: Colors.black))
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
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: exchangesList.length,
          itemBuilder: (context, index) {
            return ExchangesCard(
              name: exchangesList[index].name.toString(),
              yearEstablished: exchangesList[index].yearEstablished.toString(),
              url: exchangesList[index].url.toString(),
              image: exchangesList[index].image.toString(),
            );
          },
        ));
  }
}