import 'package:diamond_hands_crypto_tracker/data_models/exchanges_model.dart';
import 'package:flutter/material.dart';
//TODO add cached network image package
//TODO add url launcher package if needed

class ExchangesCard extends StatelessWidget {
  ExchangesCard({
    super.key,
    required this.name,
    required this.yearEstablished,
    required this.url,
    required this.image
  });

  String name;
  String yearEstablished;
  String url;
  String image;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
    child: Card(
      child: ListTile(),
    ));
  }
}