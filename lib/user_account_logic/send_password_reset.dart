import 'package:firebase_auth/firebase_auth.dart';

Future<void> resetPassword(String email) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  await auth.sendPasswordResetEmail(email: email);
}