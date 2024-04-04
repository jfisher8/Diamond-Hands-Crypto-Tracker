import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/data_models/article_model.dart';

Widget newsListTile (Article article, BuildContext context) {
  return Padding(padding: 
  const EdgeInsets.all(5),
  child: Card(
    child: ListTile(
      onTap: () {
        //add url launcher here if it's needed (or add link to the article detail page when developed)
      },
      title: Text(article.source.name),
      subtitle: Text(article.title),
      trailing: const Icon(Icons.arrow_forward_rounded),
    ),
  ));
}