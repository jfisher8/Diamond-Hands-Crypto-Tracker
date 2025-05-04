// import 'package:diamond_hands_crypto_tracker/data_models/coin_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirebaseDB {
//   static Future<Future<DocumentReference<Map<String, dynamic>>>> addCoin() async {
//     final collection =
//     FirebaseFirestore.instance.collection("coins");
//     return collection.add(Coin.toJson());
//   }

//   static Future<List<Coin>> getCoinPrices() async {
//     Query collection =
//     FirebaseFirestore.instance.collection("coins");
//     QuerySnapshot snapshot = await collection.get();

//     return snapshot.docs.map((DocumentSnapshot doc) {
//       return Coin.fromSnapshot(doc);
//     }).toList();
//   }
// }