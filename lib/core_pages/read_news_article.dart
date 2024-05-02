import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/favourites_screen.dart';
import 'package:diamond_hands_crypto_tracker/data_models/article_model.dart';
import 'package:diamond_hands_crypto_tracker/widgets/read_more_widget.dart';
import 'package:diamond_hands_crypto_tracker/widgets/save_for_later_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadNewsArticle extends StatelessWidget {
  const ReadNewsArticle({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        title: const Text('Diamond Hands Crypto Tracker'),
        appBar: AppBar(),
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
      drawer: const NavigationMenu(),
      body: Center(
          child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            child: CachedNetworkImage(imageUrl: article.imageURL.toString()),
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
          newsArticleReadMoreButton(context, () => launchUrl(Uri.parse(article.url))),
          saveForLaterButton(context, () {
            //ontap logic here, should save article to list
          })
        ],
      )),
    );
  }
}
