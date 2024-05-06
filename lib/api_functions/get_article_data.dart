import 'dart:convert';
import 'package:diamond_hands_crypto_tracker/data_models/article_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
//import 'dart:developer' as developer;

Future<List<Article>> getArticleData () async {
  await dotenv.load(fileName: "lib/.env");
  String newsAPIKey = dotenv.env['NEWS_API_KEY'] as String;

  // ignore: non_constant_identifier_names
  final URL = 'https://newsapi.org/v2/everything?q=cryptocurrency&apiKey=$newsAPIKey';
  var response = await http.get((Uri.parse(URL)));
  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);

    List<dynamic> body = json['articles'];

    List<Article> articles = body.map((dynamic item) => Article.fromJson(item)).toList();
    //developer.log(response.body);
    return articles;
  }
  else {
    throw ('Error loading articles');
  }
}