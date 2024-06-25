import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;

Future<void> resetPassword() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  await auth.sendPasswordResetEmail;
  developer.log('Password reset email sent');
}