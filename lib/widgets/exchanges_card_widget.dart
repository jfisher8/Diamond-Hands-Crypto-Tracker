import 'package:cached_network_image/cached_network_image.dart';
//import 'package:diamond_hands_crypto_tracker/core_pages/crypto_exchanges.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/crypto_exchanges_details.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/widgets/status_components.dart';
import 'package:diamond_hands_crypto_tracker/data_models/exchanges_model.dart';

class ExchangesCard extends StatelessWidget {
  final Exchanges exchange;
  const ExchangesCard({
    super.key,
    required this.exchange,
    required this.name,
    required this.country,
    required this.description,
    required this.hasTradingIncentive,
    required this.id,
    required this.btc24HRtradeVolume,
    required this.trustScore,
    required this.trustScoreRank,
    required this.yearEstablished,
    required this.url,
    required this.image,
  });

  final String name;
  final String? country;
  final String? description;
  final bool? hasTradingIncentive;
  final String? id;
  final int? btc24HRtradeVolume;
  final int? trustScore;
  final int? trustScoreRank;
  final int? yearEstablished;
  final String url;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Card(
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CryptoExchangesDetails(exchanges: exchange),
              ),
            );
          },
          trailing: const Icon(Icons.arrow_forward_rounded),
          title: Text(name.toString()),
          subtitle: Text(yearEstablished.toString()),
          leading: SizedBox(
            height: 50,
            width: 50,
            child: CachedNetworkImage(
              imageUrl: image,
              placeholder: (imageUrl, error) => buildLoadingIcon(context),
              errorWidget: (context, imageUrl, error) =>
                  buildErrorIcon(context),
            ),
          ),
        ),
      ),
    );
  }
}
