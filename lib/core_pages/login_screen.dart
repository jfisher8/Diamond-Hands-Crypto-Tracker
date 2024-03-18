import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:diamond_hands_crypto_tracker/widgets/login_screen_layout.dart';
import 'package:flutter/material.dart';
//import 'package:diamond_hands_crypto_tracker/widgets/text_fields.dart';
//import 'package:diamond_hands_crypto_tracker/login_validation/email_validation.dart';

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
  final passwordController = TextEditingController();
  //final emailValidator = validateEmail();
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Account Login',
            style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
        centerTitle: true,
      ),
      drawer: const NavigationMenu(),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: buildLoginScreen(context),
          ),
        ),
      ),
    );
  }
}
