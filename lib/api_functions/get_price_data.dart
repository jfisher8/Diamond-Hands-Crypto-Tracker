    import 'package:diamond_hands_crypto_tracker/data_models/coin_model.dart';
    import 'dart:convert';
    import 'package:http/http.dart' as http;
    import 'package:cloud_firestore/cloud_firestore.dart';
    import 'package:diamond_hands_crypto_tracker/firestore_logic/firestore_class.dart';
    
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
                final collection =
            FirebaseFirestore.instance.collection("coins");
            collection.add(Coin.toJson());
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