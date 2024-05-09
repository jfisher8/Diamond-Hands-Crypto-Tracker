import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/data_models/exchanges_model.dart';

class CryptoExchangesDetails extends StatelessWidget {
  const CryptoExchangesDetails({super.key, required this.exchanges});
  final Exchanges exchanges;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        title: Text(exchanges.name), appBar: AppBar(), widgets: [],
        ),
        body: const Placeholder(),
    );
  }
}