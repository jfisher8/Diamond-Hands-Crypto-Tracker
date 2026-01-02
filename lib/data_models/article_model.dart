import 'package:diamond_hands_crypto_tracker/data_models/source_model.dart';

class Article {
  String? firestoreId;
  Source source;
  String? author;
  String title;
  String url;
  String imageURL;
  String? publishedAt;
  String? description;
  String content;

  Article({
    this.firestoreId,
    required this.source,
    required this.author,
    required this.title,
    required this.url,
    required this.imageURL,
    required this.publishedAt,
    required this.content,
    required this.description,
  });

  factory Article.fromJson(Map<String, dynamic> map) {
    return Article(
      source: Source.fromJson(map['source']),
      author: map['author'],
      title: map['title'] ?? '',
      url: map['url'] ?? '',
      imageURL: map['urlToImage'] ?? '',
      publishedAt: map['publishedAt'],
      description: map['description'],
      content: map['content'] ?? '',
    );
  }

  factory Article.fromFirestore(Map<String, dynamic> map, String docId) {
    return Article(
      source: map['source'] is String
          ? Source(name: map['source'], id: map['id'])
          : Source.fromJson(map['source']),
      author: map['author'],
      firestoreId: docId,
      title: map['articleTitle'] ?? map['title'] ?? '',
      url: map['url'] ?? '',
      imageURL: map['imageUrl'] ?? map['urlToImage'] ?? '',
      publishedAt: map['publishedAt'],
      description: map['description'],
      content: map['content'] ?? '',
    );
  }
}



// import 'package:diamond_hands_crypto_tracker/data_models/source_model.dart';

// class Article {
//   //String id;
//   //String name;
//   Source source;
//   String? author;
//   String title;
//   String url;
//   String imageURL;
//   String? publishedAt;
//   String? description;
//   String content;

//   Article(
//       {
//       //required this.id,
//       //required this.name,
//       required this.source,
//       required this.author,
//       required this.title,
//       required this.url,
//       required this.imageURL,
//       required this.publishedAt,
//       required this.content,
//       required this.description
//       });

//   factory Article.fromJson(Map<String, dynamic> map) {
//     return Article(
//       source: Source.fromJson(map['source']),
//       author: map['author'],
//       title: map['title'] ?? '',
//       url: map['url'] ?? '',
//       imageURL: map['urlToImage'] ?? '',
//       publishedAt: map['publishedAt'],
//       description: map['description'],
//       content: map['content'] ?? '',
//     );
//   }

//     factory Article.fromFirestore(Map<String, dynamic> map) {
//     return Article(
//       source: map['source'] is String
//           ? Source(name: map['source'])
//           : Source.fromJson(map['source']),
//       author: map['author'],
//       title: map['articleTitle'] ?? map['title'] ?? '',
//       url: map['url'] ?? '',
//       imageURL: map['imageUrl'] ?? map['urlToImage'] ?? '',
//       publishedAt: map['publishedAt'],
//       description: map['description'],
//       content: map['content'] ?? '',
//     );
//   }
// }
  
//   factory Article.fromJson(Map<String, dynamic> map) {
//     return Article(
//       source: Source.fromJson(map['source']),
//         //id: map['id'] ?? '',
//         //name: map['name'] ?? '',
//         author: map['author'],
//         content: map['content'],
//         description: map['description'],
//         title: map['title'],
//         url: map['url'],
//         imageURL: map['urlToImage'],
//         publishedAt: map['publishedAt']
//       );
//   }

//   factory Article.fromFirestore(Map<String, dynamic> map) {
//   return Article(
//     source: Source(
//       id: null,
//       name: map['source'] is String
//           ? map['source']
//           : map['source']?['name'],
//     ),
//     author: map['author'],
//     title: map['articleTitle'] ?? map['title'] ?? '',
//     url: map['url'] ?? '',
//     imageURL: map['imageUrl'] ?? map['urlToImage'] ?? '',
//     publishedAt: map['publishedAt'],
//     description: map['description'],
//     content: map['content'] ?? '',
//   );
// }

//   toLowerCase() {}
// }
