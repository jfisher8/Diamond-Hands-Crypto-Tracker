import 'package:diamond_hands_crypto_tracker/widgets/news_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/home_screen.dart';
import 'dart:developer' as developer;
import 'package:diamond_hands_crypto_tracker/data_models/article_model.dart';
import 'package:diamond_hands_crypto_tracker/api_functions/get_article_data.dart';

class LatestCryptoNews extends StatefulWidget {
  const LatestCryptoNews({super.key});

  @override
  State<LatestCryptoNews> createState() => _LatestCryptoNewsState();
}

class _LatestCryptoNewsState extends State<LatestCryptoNews> {
  TextEditingController searchController = TextEditingController();
  late Future<List<Article>> futureArticle;
  String searchString = "";

  @override
  void initState() {
    futureArticle = getArticleData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        title: const Text('Latest Crypto News'),
        appBar: AppBar(),
        widgets: [
          FirebaseAuth.instance.currentUser != null
              ? IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.remove('emailAddress');
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                  icon: const Icon(Icons.logout_rounded, color: Colors.black))
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
      body: Column(children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(5),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  )),
              style: Theme.of(context).textTheme.bodySmall,
            )),
            Expanded(
            child: FutureBuilder(
              future: futureArticle,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<Article> articles = snapshot.data!;
                  developer.log(snapshot.data);
                  return ListView.builder(
                      itemCount: articles.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return articles[index]
                                .source
                                .name
                                .contains(searchString)
                            ? newsListTile(articles[index], context)
                            : Container();
                      });
                }
                if (snapshot.hasError) {
                    developer.log('snapshot has an error');
                  }
                else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              };
              return const Center(child: CircularProgressIndicator());
              }
            ),
      )]),
    );
  }
}
