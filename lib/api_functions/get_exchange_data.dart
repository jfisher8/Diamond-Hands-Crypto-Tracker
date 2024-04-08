import 'package:diamond_hands_crypto_tracker/data_models/exchanges_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

Future<List<Exchanges>> getExchangeData() async {
  exchangesList = [];
  final response =
      await http.get(Uri.parse('https://api.coingecko.com/api/v3/exchanges'));

  if (response.statusCode == 200) {
    List<dynamic> exchanges = [];
    exchanges = json.decode(response.body);
    developer.log(response.body);
    if (exchanges.isNotEmpty) {
      developer.log(exchanges.toString());
      for (int i = 0; i < exchanges.length; i++) {
        if (exchanges[i] != null) {
          Map<String, dynamic> map = exchanges[i];
          exchangesList.add(Exchanges.fromJson(map));
        }
      }
      return exchangesList;
    } else {
      throw Exception('Failed to load coins');
    }
  }
  return exchangesList;
}