import 'package:cached_network_image/cached_network_image.dart';
import 'package:diamond_hands_crypto_tracker/widgets/api_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/favourites_screen.dart';
import 'dart:developer' as developer;
import 'package:diamond_hands_crypto_tracker/data_models/article_model.dart';
import 'package:diamond_hands_crypto_tracker/api_functions/get_article_data.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/read_news_article.dart';

class LatestCryptoNews extends StatefulWidget {
  const LatestCryptoNews({super.key});

  @override
  State<LatestCryptoNews> createState() => _LatestCryptoNewsState();
}

class _LatestCryptoNewsState extends State<LatestCryptoNews> {
  TextEditingController searchController = TextEditingController();
  late Future<List<Article>> futureArticle;
  List<String> newsListOnSearch = [];
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
        title: Text('Latest Crypto News', style: Theme.of(context).textTheme.titleLarge),
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
                  labelText: 'Search articles by publisher...',
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  )),
              style: Theme.of(context).textTheme.bodySmall,
              onChanged: (value) {
                setState(() {
                  searchString = value;
                });
              },
            )),
        Expanded(
          child: FutureBuilder(
              future: futureArticle,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    List<Article> articles = snapshot.data;
                    searchController.text.isNotEmpty&&articles.isEmpty ? const Text('No results found') : ListView.builder(
                        itemCount: searchController.text.isNotEmpty ? newsListOnSearch.length : articles.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return articles[index]
                                  .source
                                  .name
                                  .toLowerCase()
                                  .contains(searchString)
                              ? Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(children: [
                                    Card(
                                        elevation: 30,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 200,
                                              child: CachedNetworkImage(
                                                imageUrl: snapshot
                                                    .data[index].imageURL,
                                                fit: BoxFit.fill,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Center(
                                                            child: Icon(
                                                  Icons.error_rounded,
                                                  color: Colors.red,
                                                )),
                                              ),
                                            ),
                                            ListTile(
                                              title: Text(
                                                  snapshot.data[index].title,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium),
                                              subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        snapshot.data[index]
                                                            .source.name,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall),
                                                    // Text(article.publishedAt.toString(),
                                                    //     style: Theme.of(context).textTheme.bodySmall)
                                                  ]),
                                              trailing: const Icon(
                                                  Icons.arrow_forward_rounded),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ReadNewsArticle(
                                                                article: snapshot
                                                                        .data[
                                                                    index])));
                                              },
                                            )
                                          ],
                                        ))
                                  ])) : const Text('test');
                        });
                  } else if (snapshot.hasError || snapshot.data == null) {
                    developer.log('no data in snapshot');
                    developer.log(snapshot.error.toString());
                    buildNewsErrorStatus(context);
                  } else {
                    return buildLoadingNewsStatus(context);
                  }
                }
                else if (snapshot.connectionState == ConnectionState.waiting) {
                  return buildLoadingNewsStatus(context);
                }
                return buildNewsErrorStatus(context);
              }),
        )
      ]),
    );
  }
}
