import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/widgets/coin_card_widget.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/home_screen.dart';

class LatestCryptoPrices extends StatefulWidget {
  const LatestCryptoPrices({super.key});

  @override
  State<LatestCryptoPrices> createState() => _LatestCryptoPricesState();
}

class _LatestCryptoPricesState extends State<LatestCryptoPrices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BuildAppBar(
          title: const Text('Diamond Hands Crypto Tracker'),
          appBar: AppBar(),
          widgets: [
            FirebaseAuth.instance.currentUser != null
                ? IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.remove('emailAddress');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );
                      });
                    },
                    icon: const Icon(Icons.logout_rounded, color: Colors.black))
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
          itemCount: 30,
          itemBuilder: (context, index) {
            return const CoidCard(
                //add business logic and data here
                );
          },
        ));
  }
}
