import 'package:diamond_hands_crypto_tracker/widgets/login_signup_widgets.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/widgets/text_fields.dart';

final emailController = TextEditingController();
final passwordController = TextEditingController();
String errorMessage = "";

Widget buildLoginScreen(BuildContext context) {
  return Column(children: [
    Card(
        elevation: 30,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
        child: Image.asset('assets/diamond_hands_logo.png',
            height: 140, width: 140)),
    const SizedBox(
      height: 20,
    ),
    const SizedBox(height: 20),
    emailAddressTextField(
        'Enter Email Address', Icons.email_rounded, false, emailController),
    const SizedBox(height: 20),
    passwordTextField(
        "Enter Password", Icons.lock_rounded, true, passwordController),
    const SizedBox(height: 20),
    Center(
        child: Text(errorMessage.toString(),
            style: const TextStyle(
                fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold))),
    loginButton(context, true, () async {
      //business logic for login here, import/call as a function
    }),
    const SizedBox(height: 20),
    const Text("Don't have an account?"),
    signUpButton(context, false, () {
      //page route to sign up screen
    })
  ]);
}
