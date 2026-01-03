import 'dart:async';
import 'package:diamond_hands_crypto_tracker/data_models/coin_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

class CoinService {
  static Timer? _pollingTimer;

  static void startPolling() {
    if (_pollingTimer == null) {
      fetchAndUpdateCoins();
      _pollingTimer = Timer.periodic(const Duration(minutes: 2), (_) async {
        await fetchAndUpdateCoins();
        developer.log('fetchAndUpdateCoins has been called');
      });
    }
  }
  static Future<void> fetchAndUpdateCoins() async {
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=gbp&order=market_cap_desc&per_page=20&page=1&sparkline=false'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      for (var coinData in data) {
        Coin coin = Coin.fromJson(coinData);
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('coins')
            .where('name', isEqualTo: coin.name)
            .get();
            developer.log('Coin data Firestore querySnapshot runs');
            //developer.log("Coin name: ${coin.name}");

        if (snapshot.docs.isEmpty) {
          await FirebaseFirestore.instance
              .collection('coins')
              .add(coin.toMap());
        } else {
          String id = snapshot.docs.first.id;
          await FirebaseFirestore.instance
              .collection('coins')
              .doc(id)
              .update(coin.toMap());
        }
      }
    } else {
      throw Exception('Failed to load coins');
    }
  }
}
