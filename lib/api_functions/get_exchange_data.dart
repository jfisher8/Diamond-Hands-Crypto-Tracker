import 'package:diamond_hands_crypto_tracker/data_models/exchanges_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

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