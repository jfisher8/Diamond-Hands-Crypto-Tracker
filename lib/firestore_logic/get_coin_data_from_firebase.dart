import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getDocumentFieldsById(String collectionName, String documentId) async {
    try {
      DocumentReference documentRef = _firestore.collection(collectionName).doc(documentId);

      DocumentSnapshot documentSnapshot = await documentRef.get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> documentData = documentSnapshot.data() as Map<String, dynamic>;

        Map<String, dynamic> selectedFields = {
          "price": documentData["price"],
          "image": documentData["image"],
          "name" : documentData["name"]
        };
        developer.log(selectedFields.toString());
        return selectedFields;
      } else {
        developer.log("Document with ID $documentId not found in collection $collectionName.");
        return null;
      }
    } catch (e) {
      developer.log("Error retrieving document fields: $e");
      return null;
    }
  }
}
