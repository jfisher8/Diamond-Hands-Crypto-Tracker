import 'package:diamond_hands_crypto_tracker/core_pages/home_screen.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/latest_crypto_prices.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/latest_crypto_news.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/crypto_exchanges.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:flutter/material.dart';

Widget buildMenuItems(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      runSpacing: 20,
      children: [
        const Divider(color: Colors.black),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.money_rounded),
          title: const Text('Latest Crypto Prices'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LatestCryptoPrices()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.newspaper_rounded),
          title: const Text('Latest Crypto News'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LatestCryptoNews()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.currency_exchange_rounded),
          title: const Text('Crypto Exchanges'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CryptoExchanges()));
          },
        ),
        const Divider(color: Colors.black),
        ListTile(
          leading: const Icon(Icons.login_rounded),
          title: const Text('Login'),
          onTap: () {
            Navigator.push(context,
            //TODO: Change the following link to logout/logout screen when it's built
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
        ),
      ],
    ),
  );
}