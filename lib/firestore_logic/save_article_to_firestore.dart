import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diamond_hands_crypto_tracker/data_models/article_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> saveArticle(Article article) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) throw Exception("User not logged in");

  final docRef = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('saved_articles')
      .doc(article.url.hashCode.toString());

  await docRef.set({
    'articleTitle': article.title,
    'url': article.url,
    'imageUrl': article.imageURL,
    'source': article.source.name,
    'savedAt': FieldValue.serverTimestamp(),
  }, SetOptions(merge: true));
}
