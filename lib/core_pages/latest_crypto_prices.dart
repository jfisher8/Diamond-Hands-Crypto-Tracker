import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/widgets/coin_card_widget.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';

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
            IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen())),
                icon: const Icon(Icons.login_rounded, color: Colors.black))
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
