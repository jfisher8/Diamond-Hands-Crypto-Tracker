import 'package:cached_network_image/cached_network_image.dart';
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
        title: const Text('Diamond Hands Crypto Tracker'), appBar: AppBar(), widgets: [],
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: CachedNetworkImage(imageUrl: exchanges.imageURL)),
                    Text(exchanges.name),
                  ],
                )
            ],
          ),
        )
    );
  }
}