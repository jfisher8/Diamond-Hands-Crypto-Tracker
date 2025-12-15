import 'dart:convert';
import 'package:diamond_hands_crypto_tracker/data_models/article_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
//import 'dart:developer' as developer;

Future<List<Article>> getArticleData() async {
  await dotenv.load(fileName: "lib/.env");
  String newsAPIKey = dotenv.env['NEWS_API_KEY'] as String;

  final url = 'https://newsapi.org/v2/everything?q=cryptocurrency&apiKey=$newsAPIKey';
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);

    List<dynamic> body = json['articles'];

    // Use the Article.fromJson method to parse each item in the response
    List<Article> articles = body.map((dynamic item) {
      // Convert source as a string directly
      if (item['source'] is String) {
        item['source'] = {'name': item['source']};
      }
      return Article.fromJson(item);
    }).toList();

    // developer.log(response.body);
    return articles;
  } else {
    throw ('Error loading articles');
  }
}