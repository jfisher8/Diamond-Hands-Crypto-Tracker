import 'package:cached_network_image/cached_network_image.dart';
import 'package:diamond_hands_crypto_tracker/widgets/status_components.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/saved_articles_screen.dart';
import 'package:diamond_hands_crypto_tracker/data_models/article_model.dart';
import 'package:diamond_hands_crypto_tracker/widgets/external_link_button_widgets.dart';
import 'package:diamond_hands_crypto_tracker/widgets/save_for_later_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';

class ReadNewsArticle extends StatelessWidget {
  ReadNewsArticle({super.key, required this.article});
  final Article? article;

Future<void> saveArticle(Article article) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) throw Exception("User not logged in");

  final firestore = FirebaseFirestore.instance;
  final savedArticlesReference = firestore.collection('users').doc(uid).collection('saved_articles');

  final querySnapshot = await savedArticlesReference.where('url', isEqualTo: article.url).get();

  if (querySnapshot.docs.isEmpty) {
    final docRef = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('saved_articles')
      .doc();

    await docRef.set({
      'articleTitle': article.title,
    
      'url': article.url,
      'imageUrl': article.imageURL,
      //'email': FirebaseAuth.instance.currentUser?.email,
      'savedAt': FieldValue.serverTimestamp(),
      'source': article.source.name,
      'author': article.author,
      'publishedAt': article.publishedAt,
      'content': article.content,
      'description': article.description
    }, SetOptions(merge: true));
    developer.log('Article saved to Firestore successfully');
  } else {
    developer.log('Article has already been saved');
  }
}

  final String? currentSession = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    final articleSavedConfirmation = SnackBar(
      content: const Text('Article Saved'),
      duration: const Duration(seconds: 4),
      backgroundColor: Colors.green[600],
      action: SnackBarAction(
        label: 'See Saved',
        textColor: Colors.blue[900],
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FavouritesScreen()));
        },
      ),
    );

    return Scaffold(
        appBar: BuildAppBar(
          title: Text('Diamond Hands Crypto Tracker',
              style: Theme.of(context).textTheme.titleLarge),
          appBar: AppBar(automaticallyImplyLeading: true),
          widgets: [
            FirebaseAuth.instance.currentUser != null
                ? IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FavouritesScreen()),
                      );
                    },
                    icon:
                        const Icon(Icons.bookmark_outline_rounded, color: Colors.black))
                : IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    icon: const Icon(Icons.login_rounded, color: Colors.black)),
          ],
        ),
        body: SafeArea(
          child: Center(
              child: Column(children: [
            SizedBox(
              height: 200,
              child: article?.imageURL == null
                  ? Column(children: [
                      const SizedBox(height: 40),
                      Center(
                          child: Image.asset('assets/diamond_hands_logo.png',
                              height: 100, width: 100)),
                      const SizedBox(height: 10),
                      const Text(
                        "Article image placeholder",
                        style:
                            TextStyle(color: Color.fromRGBO(56, 182, 255, 1.0)),
                      )
                    ])
                  : CachedNetworkImage(
                      imageUrl: article!.imageURL.toString(),
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          Center(child: buildLoadingIcon(context)),
                      errorWidget: (context, url, error) => const Center(
                          child: Icon(
                        Icons.error_rounded,
                        size: 75,
                        color: Colors.red,
                      )),
                    ),
            ),
            Text(
              article!.title,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(article!.source.name.toString()),
            const SizedBox(height: 10),
            article?.description == null
                ? Container()
                : Text(article!.description.toString(),
                    textAlign: TextAlign.center),
            const SizedBox(height: 20),
            newsArticleReadMoreButton(
                context, () => launchUrl(Uri.parse(article!.url))),
            //const SizedBox(height: 20),
            const Text("or, if you're short on time..."),
            currentSession != null
                ? saveForLaterButton(context, () {
                    saveArticle(article!);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(articleSavedConfirmation);
                  })
                : loginAndSaveButton(context, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  })
          ])),
        ));
  }
}