import 'dart:async';
import 'package:diamond_hands_crypto_tracker/data_models/exchanges_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

class ExchangesService {
  static Timer? _pollingTimer;

  static void startPolling() {
    if (_pollingTimer == null) {
      fetchAndUpdateExchanges();
      _pollingTimer = Timer.periodic(const Duration(minutes: 2), (_) async {
        await fetchAndUpdateExchanges();
        developer.log('fetchAndUpdateExchanges has been called');
      });
    }
  }

  static Future<void> fetchAndUpdateExchanges() async {
    final response =
        await http.get(Uri.parse('https://api.coingecko.com/api/v3/exchanges'));

    int newExchangeDataRecordsCreated = 0;
    int recentlyUpdatedExchangeDataRecords = 0;

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      for (var exchangeData in data) {
        //TODO: change 'Coin' below so that it's linked to the Exchanges model
        //TODO: Exchanges model likely needs changing so it reflects the same as coin_model
        Exchanges exchange = Exchanges.fromJson(exchangeData);
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('exchanges')
            .where('name', isEqualTo: exchange.name)
            .get();
        //developer.log('Exchanges Firestore querySnapshot runs');
        if (snapshot.docs.isEmpty) {
          await FirebaseFirestore.instance
              .collection('exchanges')
              .add(exchangeData);
          newExchangeDataRecordsCreated++;
          //developer.log('New Exchange data Firestore entry added');
        } else {
          String id = snapshot.docs.first.id;
          await FirebaseFirestore.instance
              .collection('exchanges')
              .doc(id)
              .update(exchangeData);
          recentlyUpdatedExchangeDataRecords++;
          //developer.log('Existing Exchange data updated in Firestore');
        }
      }
      developer.log('Firestore Exchanges data operations complete:');
      developer.log(
          '$newExchangeDataRecordsCreated new records created, $recentlyUpdatedExchangeDataRecords existing records updated');
    } else {
      throw Exception('Failed to load coins');
    }
  }
}
