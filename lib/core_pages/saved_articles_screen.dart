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
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return Article(
                title: data['articleTitle'] ?? '',
                url: data['url'] ?? '',
                imageURL: data['imageUrl'] ?? '',
                source: data['source'] ?? '',
                author: '',
                publishedAt: '',
                content: '',
                description: '',
              );
            }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BuildAppBar(
            title: Text('Your Saved Articles',
                style: Theme.of(context).textTheme.titleLarge),
            appBar: AppBar(),
            widgets: [
              IconButton(
                  onPressed: () {
                    //add onPressed logic here to delete a saved article when user selects such
                  },
                  icon: const Icon(Icons.delete_rounded, color: Colors.black))
            ]),
        body: Column(
          children: [
            StreamBuilder<List<Article>>(
              stream: userSavedArticlesStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  developer.log('Either no snapshot data or no saved articles');
                  return const Center(child: Text("No saved articles yet."));
                }
                final articles = snapshot.data!;
                return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return Card(
                      child: ListTile(
                        leading: Image.network(article.imageURL.toString(),
                            width: 60, fit: BoxFit.cover),
                        title: Text(article.title),
                        subtitle: Text(article.source.toString()),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ReadNewsArticle(article: article),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            )
          ],
        ));
  }
}
