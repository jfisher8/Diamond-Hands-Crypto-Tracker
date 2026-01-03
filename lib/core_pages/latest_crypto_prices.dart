import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:diamond_hands_crypto_tracker/widgets/coin_card_widget.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/saved_articles_screen.dart';
import 'package:diamond_hands_crypto_tracker/data_models/coin_model.dart';
import 'package:diamond_hands_crypto_tracker/widgets/status_components.dart';

class LatestCryptoPrices extends StatefulWidget {
  const LatestCryptoPrices({super.key});

  @override
  State<LatestCryptoPrices> createState() => _LatestCryptoPricesState();
}

class _LatestCryptoPricesState extends State<LatestCryptoPrices> {
  @override
  void initState() {
    //fetchCoin();
    setState(() {
      coinList;
    });
    super.initState();
  }

  Stream<List<Coin>> _coinStream() {
    return FirebaseFirestore.instance.collection('coins').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Coin.fromFirestore(doc.data()))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BuildAppBar(
          title: Text('Latest Crypto Prices',
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
                        const Icon(Icons.bookmark_outline_rounded, color: Colors.black))
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
        body: StreamBuilder<List<Coin>>(
                stream: _coinStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    developer.log('_coinStream Firestore stream connection state is waiting');
                    return Center(child: buildLoadingCoinsStatus(context));
                  }
                  if (snapshot.connectionState == ConnectionState.active) {
                    developer.log('_coinStream Firestore stream Connection state is ACTIVE');
                    //developer.log('Snapshot data connection is done: ${snapshot.data.toString()}');
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    developer.log('No data in _coinStream Firestore stream. Snapshot data: ${snapshot.data}');
                    return Center(child: buildCoinsErrorStatus(context));
                  }
                  final coins = snapshot.data!;
                  return ListView.separated(
                    separatorBuilder:(context, index) => const SizedBox(width: 10),
                    shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: coins.length,
                      itemBuilder: (context, index) {
                        final coin = coins[index];
                        developer.log('Coins: $coins');
                        return CoinCard(
                            name: coin.name,
                            imageUrl: coin.imageURL,
                            change: coin.change,
                            changePercentage: coin.changePercentage,
                            symbol: coin.symbol.toString(),
                            price: coin.price);
                      });
                }));
  }
}
