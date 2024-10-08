import 'package:diamond_hands_crypto_tracker/core_pages/home_screen.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:diamond_hands_crypto_tracker/widgets/login_signup_widgets.dart';
import 'package:diamond_hands_crypto_tracker/widgets/text_fields.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'dart:developer' as developer;
import 'package:diamond_hands_crypto_tracker/login_validation/email_validation.dart';
import 'package:diamond_hands_crypto_tracker/login_validation/password_validation.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  //TODO: add googleSignIn logic here in the future

  //initialise void initState() and add google sign in listener
  //set the state so currentUser = account
  //googleSignIn.signInSilently();
  //super.initState();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = "";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        title: Text('Account Signup', style: Theme.of(context).textTheme.titleLarge),
        appBar: AppBar(),
        widgets: const [],
      ),
      drawer: const NavigationMenu(),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(children: [
              Card(
                  elevation: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(90)),
                  child: Image.asset('assets/diamond_hands_logo.png',
                      height: 140, width: 140)),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(height: 20),
              emailAddressTextField('Enter Email Address', Icons.email_rounded,
                  false, emailController),
              const SizedBox(height: 20),
              passwordTextField("Enter Password", Icons.lock_rounded, true,
                  passwordController),
              const SizedBox(height: 20),
              Center(
                  child: Text(errorMessage.toString(),
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold))),
              primarySignUpButton(context, true, () async {
                if (_key.currentState!.validate()) {
                  try {
                    validateEmail(emailController.text);
                    validatePassword(passwordController.text);
                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((value) => developer.log('New account created'));
                        await Future.delayed(const Duration(seconds: 0));
                        if (!context.mounted) return;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const HomeScreen(collectionName: 'coins', documentId: 'id'))));
                  } on FirebaseAuthException catch (error) {
                    errorMessage = error.message!;
                  }
                }
              }),
              const SizedBox(height: 20),
              const Text("Already have an account?"),
              secondaryLoginButton(context, false, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              })
            ]),
          ),
        ),
      ),
    );
  }
}