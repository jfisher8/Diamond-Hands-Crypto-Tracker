import 'package:cached_network_image/cached_network_image.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExchangesCard extends StatelessWidget {
  const ExchangesCard(
      {super.key,
      required this.name,
      required this.yearEstablished,
      required this.url,
      required this.image});

  final String name;
  final String yearEstablished;
  final String url;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        child: Card(
          child: ListTile(
            onTap: () {
              //TODO: replace with route to exchange description screen when it's built
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            trailing: const Icon(Icons.open_in_new_rounded),
            leading: ConstrainedBox(
              constraints: const BoxConstraints(
                  minWidth: 66, minHeight: 66, maxWidth: 66, maxHeight: 100),
              child: CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (imageUrl, error) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, imageUrl, error) => const Icon(
                      Icons.error_outline_rounded,
                      color: Colors.red)),
            ),
            title: Text(name),
            subtitle: Text(yearEstablished),
          ),
        ));
  }
}
