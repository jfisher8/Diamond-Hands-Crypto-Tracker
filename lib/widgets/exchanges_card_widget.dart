import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
//TODO add url launcher package if needed

class ExchangesCard extends StatelessWidget {
  ExchangesCard(
      {super.key,
      required this.name,
      required this.yearEstablished,
      required this.url,
      required this.image});

  String name;
  String yearEstablished;
  String url;
  String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        child: Card(
          child: ListTile(
            onTap: () {
              //add logic to open url to the exchange's website here
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
