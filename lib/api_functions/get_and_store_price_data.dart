import 'dart:async';
import 'package:diamond_hands_crypto_tracker/data_models/coin_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart' show mapEquals;

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
    final response = await http.get(
      Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=gbp&order=market_cap_desc&per_page=20&page=1&sparkline=false',
      ),
    );

    int newlyCreated = 0;
    int recentlyUpdated = 0;

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      for (var coinData in data) {
        Coin coin = Coin.fromJson(coinData);
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('coins')
            .where('name', isEqualTo: coin.name)
            .get();
        //developer.log('Coin data Firestore querySnapshot runs');
        //developer.log("Coin name: ${coin.name}");

        if (snapshot.docs.isEmpty) {
          // Add new coin if it doesn't exist
          await FirebaseFirestore.instance
              .collection('coins')
              .add(coin.toMap());
          newlyCreated++;
          //developer.log('New Coin data added to Firestore');
        } else {
          // Update existing coin only if data has changed
          String id = snapshot.docs.first.id;
          Map<String, dynamic> existingData =
              snapshot.docs.first.data() as Map<String, dynamic>;
          Map<String, dynamic> newData = coin.toMap();

          if (!mapEquals(existingData, newData)) {
            await FirebaseFirestore.instance
                .collection('coins')
                .doc(id)
                .update(newData);
            recentlyUpdated++;
            //developer.log('Existing Coin data updated in Firestore');
          } else {
            //developer.log('No changes detected for ${coin.name}, skipping update');
          }
        }
      }
      developer.log('Firestore Coin data operations completed:');
      developer.log(
        '$newlyCreated Coin data entries added, $recentlyUpdated existing entries updated',
      );
    } else {
      throw Exception('Failed to load coins');
    }
  }
}
