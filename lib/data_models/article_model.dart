import 'source_model.dart';

class Article {
  Source source;
  String? author;
  String title;
  String url;
  String? imageURL;
  String? publishedAt;
  String? description;
  String content;

  Article(
      {required this.source,
      required this.author,
      required this.title,
      required this.url,
      required this.imageURL,
      required this.publishedAt,
      required this.content,
      required this.description
      });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        source: Source.fromJson(json['source']),
        author: json['author'],
        content: json['content'],
        description: json['description'],
        title: json['title'],
        url: json['url'],
        imageURL: json['urlToImage'],
        publishedAt: json['publishedAt']
      );
  }

  toLowerCase() {}
}
