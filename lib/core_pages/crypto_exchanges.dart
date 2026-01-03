import 'package:diamond_hands_crypto_tracker/data_models/exchanges_model.dart';
import 'package:diamond_hands_crypto_tracker/widgets/exchanges_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/saved_articles_screen.dart';
import 'package:diamond_hands_crypto_tracker/widgets/status_components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

class CryptoExchanges extends StatefulWidget {
  const CryptoExchanges({super.key});

  @override
  State<CryptoExchanges> createState() => _CryptoExchangesState();
}

class _CryptoExchangesState extends State<CryptoExchanges> {
  @override
  void initState() {
    //fetchExchanges();
    setState(() {
      exchangesList;
    });
    super.initState();
  }

  Stream<List<Exchanges>> _exchangesStream() {
    return FirebaseFirestore.instance.collection('exchanges').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Exchanges.fromFirestore(doc.data()))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BuildAppBar(
          title: Text('Crypto Exchanges',
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
                    icon: const Icon(Icons.bookmark_outline_rounded,
                        color: Colors.black))
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
        body: StreamBuilder<List<Exchanges>>(
            stream: _exchangesStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return buildExchangesErrorStatus(context);
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return buildExchangesLoadingStatus(context);
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return buildExchangesErrorStatus(context);
              }
              final exchanges = snapshot.data!;
              developer.log(snapshot.data.toString());
              return ListView.separated(
                itemCount: exchanges.length,
                separatorBuilder:(context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final exchange = exchanges[index];
                  return ExchangesCard(
                    name: exchange.name,
                    country: exchange.country,
                    description: exchange.description,
                    hasTradingIncentive: exchange.hasTradingIncentive,
                    id: exchange.id,
                    btc24HRtradeVolume: exchange.btc24HRtradeVolume,
                    trustScore: exchange.trustScore,
                    trustScoreRank: exchange.trustScoreRank,
                    yearEstablished: exchange.yearEstablished,
                    url: exchange.url,
                    image: exchange.imageURL,
                  );
                },
              );
            }));
  }
}
