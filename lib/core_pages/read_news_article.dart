import 'package:cached_network_image/cached_network_image.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/home_screen.dart';
import 'package:diamond_hands_crypto_tracker/widgets/status_components.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/favourites_screen.dart';
import 'package:diamond_hands_crypto_tracker/data_models/article_model.dart';
import 'package:diamond_hands_crypto_tracker/widgets/read_more_widget.dart';
import 'package:diamond_hands_crypto_tracker/widgets/save_for_later_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadNewsArticle extends StatelessWidget {
  ReadNewsArticle({super.key, required this.article});
  final Article article;

  final String? currentSession = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    final articleSavedConfirmation = SnackBar(
      content: const Text('Article saved!'),
      backgroundColor: Color.fromRGBO(56, 182, 255, 1.0),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
          label: 'View Saved Articles',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => const HomeScreen())));
          }),
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
                  icon: const Icon(Icons.bookmark_rounded, color: Colors.black))
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
      body: Center(
          child: Column(children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: CachedNetworkImage(
              imageUrl: article.imageURL.toString(),
              placeholder: (context, url) => buildLoadingIcon(context),
              errorWidget: (context, url, error) => buildErrorIcon(context)),
        ),
        Text(
          article.title,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(article.source.name.toString()),
        const SizedBox(height: 10),
        Text(article.description.toString(), textAlign: TextAlign.center),
        const SizedBox(height: 40),
        newsArticleReadMoreButton(
            context, () => launchUrl(Uri.parse(article.url))),
        const SizedBox(height: 20),
        const Text("or, if you're short on time..."),
        currentSession != null
            ? saveForLaterButton(context, () {
                //ontap logic here, should save article to list
                ScaffoldMessenger.of(context)
                    .showSnackBar(articleSavedConfirmation);
              })
            : loginAndSaveButton(context, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              })
      ])),
    );
  }
}
