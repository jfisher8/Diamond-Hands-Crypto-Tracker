import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/data_models/article_model.dart';
import 'package:intl/intl.dart';

Widget newsListTile(Article article, BuildContext context) {
  return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(children: [
        Card(
            elevation: 30,
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: CachedNetworkImage(
                    imageUrl: article.imageURL.toString(),
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) => const Center(
                        child: Icon(
                      Icons.error_rounded,
                      color: Colors.red,
                    )),
                  ),
                ),
                ListTile(
                  title: Text(article.title.toString(),
                      style: Theme.of(context).textTheme.bodyMedium),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(article.source.name.toString(),
                            style: Theme.of(context).textTheme.bodySmall),
                        Text(article.publishedAt.toString(),
                            style: Theme.of(context).textTheme.bodySmall)
                      ]),
                  trailing: const Icon(Icons.arrow_forward_rounded),
                  onTap: () {},
                )
              ],
            ))
      ]));
}
