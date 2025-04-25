import 'package:diamond_hands_crypto_tracker/core_pages/home_screen.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //initialise void initState() and add google sign in listener
  //set the state so currentUser = account
  //googleSignIn.signInSilently();
  //super.initState();

  final emailController = TextEditingController();
  var emailResetController = TextEditingController();
  final passwordController = TextEditingController();
  final String emailWord = "email";
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailResetKey = GlobalKey<FormState>();
  late var message = "";
  //String errorMessage = "";
  FirebaseAuth auth = FirebaseAuth.instance;

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
                      Text(message, style: const TextStyle(color: Colors.red)),
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
                            if (error.code == 'invalid-credential') {
                              message =
                                  'Incorrect credentials, please try again';
                            }
                          }
                        }
                      }),
                      TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) => AlertDialog(
                                      actions: [
                                        SingleChildScrollView(
                                          child: Form(
                                              key: _emailResetKey,
                                              child: ListBody(
                                                children: [
                                                  resetPasswordTextField(
                                                      'Enter your email address',
                                                      false,
                                                      emailResetController)
                                                ],
                                              )),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel',
                                                style: GoogleFonts.questrial(
                                                    color: Colors.red))),
                                        TextButton(
                                            onPressed: () async {
                                              if (_emailResetKey.currentState!
                                                  .validate()) {
                                                try {
                                                  validateEmail(
                                                      emailResetController
                                                          .text);
                                                  developer.log(
                                                      emailResetController
                                                          .text);
                                                  await FirebaseAuth.instance
                                                      .sendPasswordResetEmail(
                                                          email:
                                                              emailResetController
                                                                  .text)
                                                      .then((value) {
                                                    emailResetController
                                                        .clear();
                                                    developer.log(
                                                        'Password reset email sent');
                                                    Navigator.pop(context);
                                                    showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            false,
                                                        builder: (BuildContext
                                                                context) =>
                                                            AlertDialog(
                                                              actions: [
                                                                const SingleChildScrollView(
                                                                  child:
                                                                      ListBody(
                                                                    children: [
                                                                      Text(
                                                                          'Check your inbox! Password reset sent')
                                                                    ],
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                        'Done', style: GoogleFonts.questrial(color: Colors.green)))
                                                              ],
                                                              content: const SizedBox(height: 5)
                                                            ));
                                                  });
                                                } on FirebaseAuthException catch (error) {
                                                  developer.log(error.code);
                                                  const Text(
                                                      'Error occured with reset, try again');
                                                }
                                              }
                                            },
                                            child: Text(
                                                'Send password reset email',
                                                style: GoogleFonts.questrial(
                                                    color: Colors.green)))
                                      ],
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
