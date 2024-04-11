import 'package:diamond_hands_crypto_tracker/api_functions/get_article_data.dart';
import 'package:diamond_hands_crypto_tracker/data_models/article_model.dart';
import 'package:flutter/material.dart';

Widget buildCryptoNews(BuildContext context) {
  late Future<List<Article>> futureArticle;

  void initState() {
    futureArticle = getArticleData();
  }
  return (
    Column(children: [
      FutureBuilder<List<Article>>(
        future: futureArticle,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null || snapshot.hasError) {
            return const Column(
              children: [
                CircularProgressIndicator(),
                Center(child: Text('Error loading News...'))
              ],
            );
          } else {
            return Padding(padding: const EdgeInsets.all(10),
            child: InkWell(
              child: SizedBox(
                height: 320,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(width: 10),
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 100,
                      height: 100,
                      child: Column(children: [
                        const SizedBox(height: 5),
                        Expanded(child: Card(
                          child: ListTile(onTap: () {
                            //logic here for ontap
                          },
                          title: snapshot.data[index].title,
                          subtitle: snapshot.data[index].source.name,
                          ),
                        ))
                      ],),
                    );
                  },
                  ),
              ),
            ));
          }
        }
        ),
      //add futurebuilder business logic here
      Padding(padding: const EdgeInsets.all(10),
      child: InkWell(
        child: SizedBox(
          height: 230,
          child: ListView.separated(separatorBuilder: (context, index) => const SizedBox(width: 10),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            //TODO replace container with snapshot data
            return Container(
              child: const Placeholder(),
            );
          },
          itemCount: 15,
          )
        ),
      ),)
    ],)
  );
}