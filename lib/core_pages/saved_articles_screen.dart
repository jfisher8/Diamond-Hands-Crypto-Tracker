import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/read_news_article.dart';
import 'package:diamond_hands_crypto_tracker/data_models/article_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'dart:developer' as developer;

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
Stream<List<Article>> userSavedArticlesStream() {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return const Stream.empty();

  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('saved_articles')
      .orderBy('savedAt', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) {
            return Article.fromFirestore(doc.data());
          }).toList());
}


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: BuildAppBar(
      title: Text(
        'Your Saved Articles',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      appBar: AppBar(),
      widgets: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.delete_rounded, color: Colors.black),
        )
      ],
    ),
    body: StreamBuilder<List<Article>>(
      stream: userSavedArticlesStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final articles = snapshot.data ?? [];

        if (articles.isEmpty) {
          return const Center(child: Text("No saved articles yet."));
        }

        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];

            return Card(
              child: ListTile(
                leading: article.imageURL.isNotEmpty
                    ? CachedNetworkImage(
                      imageUrl: article.imageURL,
                        width: 60,
                        fit: BoxFit.cover,
                      )
                    : const SizedBox(width: 60),
                title: Text(article.title),
                subtitle: Text(article.source.name ?? ''),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ReadNewsArticle(article: article),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    ),
  );
}
}