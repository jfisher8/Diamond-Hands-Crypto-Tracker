import 'source_model.dart';

class Article {
  Source source;
  String? author;
  String title;
  String url;
  String? imageURL;
  String? publishedAt;

  Article(
      {required this.source,
      required this.author,
      required this.title,
      required this.url,
      required this.imageURL,
      required this.publishedAt
      });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        source: Source.fromJson(json['source']),
        author: json['author'],
        title: json['title'],
        url: json['url'],
        imageURL: json['urlToImage'],
        publishedAt: json['publishedAt']
      );
  }
}
