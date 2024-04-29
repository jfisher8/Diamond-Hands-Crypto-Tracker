import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/favourites_screen.dart';
import 'package:diamond_hands_crypto_tracker/data_models/article_model.dart';

class ReadNewsArticle extends StatelessWidget {
  const ReadNewsArticle({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        title: Text(article.title),
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
      body: Center(child: Text('text'),)
    );
  }
}
