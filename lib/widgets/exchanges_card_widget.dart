import 'package:cached_network_image/cached_network_image.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/crypto_exchanges.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/widgets/status_components.dart';

class ExchangesCard extends StatelessWidget {
  const ExchangesCard(
      {super.key,
      required this.name,
      required this.yearEstablished,
      required this.url,
      required this.image});

  final String name;
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CryptoExchanges()));
            },
            trailing: const Icon(Icons.arrow_forward_rounded),
            title: yearEstablished != null ? Text(name) : Text("\n$name"),
            subtitle: yearEstablished != null ? Text(yearEstablished.toString()) : const Text(""),
            leading: SizedBox(
              height: 50,
              width: 50,
              child: CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (imageUrl, error) => buildLoadingIcon(context),
                  errorWidget: (context, imageUrl, error) => buildErrorIcon(context)
            ),
          ),
        )));
  }
}
