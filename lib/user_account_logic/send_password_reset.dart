import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;

Future<void> resetPassword(String email) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  await auth.sendPasswordResetEmail(email: email);
  developer.log('Password reset email sent to $email');
}