import 'package:diamond_hands_crypto_tracker/api_functions/get_exchange_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
  void initState() {
    fetchExchanges();
    setState(() {
      exchangesList;
    });
  }

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
                    icon:
                        const Icon(Icons.bookmark_rounded, color: Colors.black))
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
              name: exchangesList[index].name,
              yearEstablished: exchangesList[index].yearEstablished.toString(),
              url: exchangesList[index].url,
              image: exchangesList[index].image,
            );
          },
        ));
  }
}

  Future<List<Exchanges>> fetchExchanges() async {
    exchangesList = [];
    final response =
        await http.get(Uri.parse('https://api.coingecko.com/api/v3/exchanges'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            exchangesList.add(Exchanges.fromJson(map));
          }
        }
      }
      return exchangesList;
    } else {
      throw Exception('Failed to load coins');
    }
  }