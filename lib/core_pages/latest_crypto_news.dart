import 'package:diamond_hands_crypto_tracker/widgets/news_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/favourites_screen.dart';
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
      body: Column(children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(5),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search articles...', labelStyle: Theme.of(context).textTheme.bodyLarge,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  )),
              style: Theme.of(context).textTheme.bodySmall,
            )),
        Expanded(
          child: FutureBuilder(
              future: futureArticle,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    List<Article> articles = snapshot.data;
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
                  } else if (snapshot.hasError || snapshot.data == null) {
                    developer.log('no data in snapshot');
                    developer.log(snapshot.error.toString());
                    const Center(
                        child: Column(
                      children: [
                        SizedBox(height: 40),
                        CircularProgressIndicator(),
                        SizedBox(height: 40),
                        Text('Error loading News.'),
                        Text('Please refresh and try again later.')
                      ],
                    ));
                  } else {
                    return const Center(
                        child: Column(
                      children: [
                        SizedBox(height: 40),
                        CircularProgressIndicator(),
                        SizedBox(height: 40),
                        Text('Loading news...')
                      ],
                    ));
                  }
                }
                return const Center(
                    child: Column(
                  children: [
                    SizedBox(height: 40),
                    CircularProgressIndicator(),
                    SizedBox(height: 40),
                    Text('Loading News...'),
                  ],
                ));
              }),
        )
      ]),
    );
  }
}
