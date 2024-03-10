import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/widgets/coin_card_widget.dart';

class LatestCryptoPrices extends StatefulWidget {
  const LatestCryptoPrices({super.key});

  @override
  State<LatestCryptoPrices> createState() => _LatestCryptoPricesState();
}

class _LatestCryptoPricesState extends State<LatestCryptoPrices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      centerTitle: true,
      backgroundColor: const Color.fromRGBO(56, 182, 255, 1.0),
      title: Text('Latest Crypto Prices', style: Theme.of(context).textTheme.titleLarge),
      elevation: 0.0,
      actions: const [Icon(Icons.login_rounded, color: Colors.black), Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0))],
    ),
    drawer: const NavigationMenu(),
    body: 
    ListView.builder(
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