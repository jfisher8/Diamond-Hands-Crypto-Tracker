// import 'package:diamond_hands_crypto_tracker/data_models/coin_model.dart';
//     import 'dart:convert';
//     import 'package:http/http.dart' as http;
//     import 'package:cloud_firestore/cloud_firestore.dart';

//     Future<List<Coin>> fetchCoin() async {
//     coinList = [];
//     final response = await http.get(Uri.parse(
//         'https://api.coingecko.com/api/v3/coins/markets?vs_currency=gbp&order=market_cap_desc&per_page=50&page=1&sparkline=false'));

//     if (response.statusCode == 200) {
//       List<dynamic> values = [];
//       values = json.decode(response.body);
//       if (values.isNotEmpty) {
//         for (int i = 0; i < values.length; i++) {
//           if (values[i] != null) {
//             Map<String, dynamic> map = values[i];
//             coinList.add(Coin.fromJson(map));
//             FirebaseFirestore.instance.collection("coins").add(({"coins": values}));
//           }
//         }
//       }
//       return coinList;
//     } else {
//       //return coinList;
//       throw Exception('Failed to load coins');
//     }
//   }

import 'package:diamond_hands_crypto_tracker/data_models/coin_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Coin>> fetchCoin() async {
  List<Coin> coinList = [];
  final response = await http.get(Uri.parse(
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=gbp&order=market_cap_desc&per_page=50&page=1&sparkline=false'));

  if (response.statusCode == 200) {
    List<dynamic> values = json.decode(response.body);

    if (values.isNotEmpty) {
      for (var value in values) {
        if (value != null) {
          coinList.add(Coin.fromJson(value));

          Map<String, dynamic> filteredData = {
            "price": value["current_price"],
            "image": value["image"],
          };

          await FirebaseFirestore.instance
              .collection("coins")
              .doc(value["id"])
              .set(filteredData);
        }
      }
    }
    return coinList;
  } else {
    throw Exception('Failed to load coins');
  }
}
