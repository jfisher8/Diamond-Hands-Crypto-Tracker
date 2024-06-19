import 'package:diamond_hands_crypto_tracker/core_pages/home_screen.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:diamond_hands_crypto_tracker/login_validation/text_field_valdiation.dart';
import 'package:diamond_hands_crypto_tracker/widgets/login_signup_widgets.dart';
import 'package:diamond_hands_crypto_tracker/widgets/text_fields.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/signup_screen.dart';
import 'dart:developer' as developer;
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/login_validation/email_validation.dart';
import 'package:diamond_hands_crypto_tracker/login_validation/password_validation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diamond_hands_crypto_tracker/user_account_logic/send_password_reset.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //TODO: add googleSignIn logic here in the future

  //initialise void initState() and add google sign in listener
  //set the state so currentUser = account
  //googleSignIn.signInSilently();
  //super.initState();

  final emailController = TextEditingController();
  final emailResetController = TextEditingController();
  final passwordController = TextEditingController();
  final String emailWord = "email";
  final emailValidator = TextfieldValidation();
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
          title: Text('Account Login',
              style: Theme.of(context).textTheme.titleLarge),
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
                      emailAddressTextField('Enter Email Address',
                          Icons.email_rounded, false, emailController),
                      const SizedBox(height: 20),
                      passwordTextField("Enter Password", Icons.lock_rounded,
                          true, passwordController),
                      const SizedBox(height: 20),
                      Center(
                          child: Text(errorMessage.toString(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold))),
                      primaryLoginButton(context, true, () async {
                        if (_key.currentState!.validate()) {
                          try {
                            validateEmail(emailController.text);
                            validatePassword(passwordController.text);
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            preferences.setString(
                                'emailAddress', emailController.text);
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text)
                                .then((value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen())));
                            developer.log('Logged in successfully');
                          } on FirebaseAuthException catch (error) {
                            developer.log(error.code);
                            var message = 'An error occured';
                            if (error.code == 'invalid-credential') {
                              message = 'Incorrect credentials, try again';
                            }
                          }
                        }
                      }),
                      // Text(
                      //     message), //TODO: explore alertDialog method of showing error message
                      TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text(
                                          'Enter your email address to reset your password',
                                          style: GoogleFonts.questrial(
                                              decorationColor:
                                                  const Color.fromRGBO(
                                                      56, 182, 255, 1.0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: const Color.fromRGBO(
                                                  56, 182, 255, 1.0))),
                                      content: TextField(
                                          controller: emailResetController,
                                          decoration: const InputDecoration(
                                              hintText:
                                                  'Enter your email address...',
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromRGBO(
                                                          56, 182, 255, 1.0))),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromRGBO(56,
                                                          182, 255, 1.0))))),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel',
                                                style: GoogleFonts.questrial(
                                                    color: Colors.red))),
                                        TextButton(
                                            onPressed: () {
                                              if (emailResetController
                                                  .text.isNotEmpty) {
                                                // resetPassword(
                                                //     emailResetController.text);
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                          title: Text(
                                                              'Check your inbox! Reset email sent',
                                                              style: GoogleFonts.questrial(
                                                                  decorationColor:
                                                                      const Color
                                                                          .fromRGBO(
                                                                          56,
                                                                          182,
                                                                          255,
                                                                          1.0),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16,
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      56,
                                                                      182,
                                                                      255,
                                                                      1.0))),
                                                        ));
                                              }
                                              else if (emailResetController.text.isEmpty) {
                                                
                                              }
                                              //TODO: add password reset functionality (should trigger Firebase password reset email)
                                            },
                                            child: Text(
                                                'Send password reset email',
                                                style: GoogleFonts.questrial(
                                                    color: Colors.green)))
                                      ],
                                    ));
                          },
                          child: Text('Forgotten Password?',
                              style: GoogleFonts.questrial(
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      const Color.fromRGBO(56, 182, 255, 1.0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: const Color.fromRGBO(
                                      56, 182, 255, 1.0)))),
                      const Divider(),
                      const SizedBox(height: 10),
                      const Text("Don't have an account?"),
                      secondarySignUpButton(context, false, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen()));
                      })
                    ])))));
  }
}
