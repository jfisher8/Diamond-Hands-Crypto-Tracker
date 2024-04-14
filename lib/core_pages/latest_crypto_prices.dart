import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/widgets/coin_card_widget.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/favourites_screen.dart';
import 'package:diamond_hands_crypto_tracker/data_models/coin_model.dart';
import 'package:diamond_hands_crypto_tracker/api_functions/get_price_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LatestCryptoPrices extends StatefulWidget {
  const LatestCryptoPrices({super.key});

  @override
  State<LatestCryptoPrices> createState() => _LatestCryptoPricesState();
}

class _LatestCryptoPricesState extends State<LatestCryptoPrices> {

      Future<List<Coin>> fetchCoin() async {
    coinList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=gbp&order=market_cap_desc&per_page=50&page=1&sparkline=false'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }
      }
      return coinList;
    } else {
      //return coinList;
      throw Exception('Failed to load coins');
    }
  }

  @override
  void initState() {
    fetchCoin();
    setState(() {
      coinList;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BuildAppBar(
          title: const Text('Latest Crypto Prices'),
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
          itemCount: coinList.length,
          itemBuilder: (context, index) {
            if (coinList.length == 1 || coinList.length > 1) {
            return CoinCard(
                name: coinList[index].name,
                imageUrl: coinList[index].imageURL,
                change: coinList[index].change,
                changePercentage: coinList[index].changePercentage,
                symbol: coinList[index].symbol,
                price: coinList[index].price.toString(),
                );
          }
          else {
            return CircularProgressIndicator();
          }
          },
        ));
  }
}
