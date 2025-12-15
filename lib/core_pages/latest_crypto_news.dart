import 'package:cached_network_image/cached_network_image.dart';
import 'package:diamond_hands_crypto_tracker/widgets/status_components.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/saved_articles_screen.dart';
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
        title: Text('Latest Crypto News',
            style: Theme.of(context).textTheme.titleLarge),
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
                  icon: const Icon(Icons.bookmark_outline_rounded,
                      color: Colors.black))
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
                  prefixIcon: const Icon(Icons.search_rounded),
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
                setState(() {});
              },
            )),
        Expanded(
            child: FutureBuilder(
                future: futureArticle,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    developer.log('snapshot connection done');
                    if (snapshot.hasData) {
                      developer.log(snapshot.data.toString());
                      List<Article> articles = snapshot.data;
                      final filteredArticles = articles.where((article) {
                        return article.source.name?.toLowerCase().contains(searchController.text.toLowerCase()) ?? false;
                      }).toList();
                      return filteredArticles.isEmpty
                          ? const Center(
                              child: Text(
                                "No results found",
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredArticles.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Column(children: [
                                          Card(
                                              child: Column(
                                            children: [
                                              SizedBox(
                                                height: 200,
                                                child: filteredArticles[index]
                                                            // ignore: unnecessary_null_comparison
                                                            .imageURL ==
                                                        null
                                                    ? Column(children: [
                                                        const SizedBox(
                                                            height: 40),
                                                        Center(
                                                            child: Image.asset(
                                                                'assets/diamond_hands_logo.png',
                                                                height: 100,
                                                                width: 100)),
                                                        const SizedBox(
                                                            height: 10),
                                                        const Text(
                                                          "Article image placeholder",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      56,
                                                                      182,
                                                                      255,
                                                                      1.0)),
                                                        )
                                                      ])
                                                    : CachedNetworkImage(
                                                        imageUrl: filteredArticles[index]
                                                            .imageURL,
                                                        fit: BoxFit.fill,
                                                        placeholder: (context,
                                                                url) =>
                                                            Center(
                                                                child:
                                                                    buildLoadingIcon(
                                                                        context)),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Center(
                                                                child: Icon(
                                                          Icons.error_rounded,
                                                          size: 75,
                                                          color: Colors.red,
                                                        )),
                                                      ),
                                              ),
                                              ListTile(
                                                title: Text(
                                                    filteredArticles[index].title,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium),
                                                subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          filteredArticles[index]
                                                              .source.name ?? 'Unknown',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall),
                                                    ]),
                                                trailing: const Icon(Icons
                                                    .arrow_forward_rounded),
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ReadNewsArticle(
                                                                  article: filteredArticles[
                                                                      index])));
                                                },
                                              )
                                            ],
                                          ))
                                        ]));
                              });
                    } else if (snapshot.hasError || snapshot.data == null) {
                      developer.log('no data in snapshot');
                      developer.log(snapshot.error.toString());
                      return buildNewsErrorStatus(context);
                    }
                  }
                  return buildLoadingNewsStatus(context);
                }))
      ]),
    );
  }
}
