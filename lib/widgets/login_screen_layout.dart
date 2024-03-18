import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/widgets/text_fields.dart';

final emailController = TextEditingController();
final passwordController = TextEditingController();

Widget buildLoginScreen(BuildContext context) {
  return Column(
    children: [
      const SizedBox(height: 40),
      Card(
          elevation: 30,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
          child: Image.asset('assets/diamond_hands_logo.png',
              height: 140, width: 140)),
      const SizedBox(
        height: 20,
      ),
      const SizedBox(height: 20),
      emailAddressTextField('Enter Email Address', Icons.email_rounded, false, emailController),
      const SizedBox(height: 20),
      passwordTextField("Enter Password", Icons.lock_outline_rounded, true, passwordController),
      const SizedBox(height: 20),
    ],
  );
}