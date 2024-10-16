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
import 'dart:developer' as developer;

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
          //developer.log(value.toString());
          developer.log("json values added to coinList");

          Map<String, dynamic> filteredData = {
            "price": value["current_price"],
            "image": value["image"],
            "name": value["name"],
            "id": value["id"]
          };
          developer.log("code gets past filtered data function");

          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection("coins")
              .where("id", isEqualTo: value["id"])
              .get();
              developer.log("querySnapshot function works");

          if (querySnapshot.docs.isNotEmpty) {
            developer.log("querySnapshot isn't empty");
            developer.log("found ${querySnapshot.docs.length}");
            //Get the existing document's ID
            String existingDocumentID = querySnapshot.docs.first.id;
            developer.log("code is past docs.isNotEmpty");

            //Get the current document's data
            DocumentSnapshot existingDocument = querySnapshot.docs.first;
            Map<String, dynamic> existingData =
                existingDocument.data() as Map<String, dynamic>;

            //Initialise boolean variable to compare fields in filteredData with
            //those in existingData
            bool hasChanged = false;

            //Check if any field in filteredData is different to the value in existingData
            filteredData.forEach((key, value) {
              if (existingData[key] != value) {
                hasChanged = true;
              }
            });

            //Update the document in Firebase, only if there are changes
            if (hasChanged == true) {
              await FirebaseFirestore.instance
                  .collection("coins")
                  .doc(existingDocumentID)
                  .update(filteredData);
              developer.log("Crypto price date updated in Firebase");
            } else if (hasChanged == false) {
              developer.log("No changes found, skipping update");
            } else {
              await FirebaseFirestore.instance
                  .collection("coins")
                  .doc(value["id"])
                  .set(filteredData);
            }
            await FirebaseFirestore.instance
                .collection("coins")
                .add(filteredData);
            developer.log("Filtered data has been set within collection");
          }
          developer.log("The query snapshot IS EMPTY");
        }
      }
      return coinList;
    } else {
      throw Exception('Failed to load coins');
    }
  }
  throw Exception('Failed to load coins');
}