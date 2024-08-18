import 'package:diamond_hands_crypto_tracker/core_pages/home_screen.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/latest_crypto_prices.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/latest_crypto_news.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/crypto_exchanges.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

Widget buildMenuItems(BuildContext context) {
  
  final String? currentEmail = FirebaseAuth.instance.currentUser?.email;
  return Container(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      runSpacing: 20,
      children: [
        SizedBox(
            height: 20,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: [
                Column(
                  children: [
                    currentEmail != null
                        ? Text("You're logged in as $currentEmail")
                        : const Text('Welcome to the app',
                            textAlign: TextAlign.center),
                  ],
                ),
              ],
            )
          ),
        const Divider(),
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LatestCryptoPrices()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.newspaper_rounded),
          title: const Text('Latest Crypto News'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LatestCryptoNews()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.currency_exchange_rounded),
          title: const Text('Crypto Exchanges'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CryptoExchanges()));
          },
        ),
        const Divider(),
        currentEmail != null
            ? //if someone's LOGGED IN
            ListTile(
                leading: const Icon(Icons.logout_rounded),
                title: const Text('Logout'),
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.remove('emailAddress');
                    developer.log('signed out of account;');
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
              )
            : //if nobody is logged in, show default list tile
            ListTile(
                leading: const Icon(Icons.login_rounded),
                title: const Text('Login'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
              ),
      ],
    ),
  );
}
