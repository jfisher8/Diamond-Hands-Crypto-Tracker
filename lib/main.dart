import 'package:diamond_hands_crypto_tracker/core_pages/home_screen.dart';
import 'package:diamond_hands_crypto_tracker/new_user_onboarding/new_user_onboarding.dart';
import 'package:diamond_hands_crypto_tracker/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer' as developer;
import 'package:provider/provider.dart';

bool onboarded = true;

Future<void> main() async {
  await dotenv.load(fileName: "lib/.env");
  String firebaseKey = dotenv.env['FIREBASE_KEY'] as String;
  String appId = dotenv.env['APP_ID'] as String;
  String messagingSenderId = dotenv.env['MESSAGING_SENDER_ID'] as String;
  String projectId = dotenv.env['PROJECT_ID'] as String;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
        options: FirebaseOptions(  
          apiKey: firebaseKey,
          appId: appId,
          messagingSenderId: messagingSenderId,
          projectId: projectId
  ));
  SharedPreferences preferences = await SharedPreferences.getInstance(); //gets an instance of Local storage
  String? email = preferences.getString('emailAddress');
  bool? isDarkMode = preferences.getBool('darkMode');
  SharedPreferences onboarding = await SharedPreferences.getInstance();
  bool showOnboarding = onboarding.getBool('onboarding') ?? true;
  //if email variable is null, state there is no current session, else, state last logged in email
  email == null ? developer.log('SharedPrefs: No current session') : 
  developer.log('Last logged in session: ' "$email");
  developer.log('Should onboarding be shown? ' "$showOnboarding");
  developer.log('Should app be in dark mode? ' "$isDarkMode");

  runApp(ChangeNotifierProvider(create: (context) => ThemeProvider(),
    child: const MainApp(
    )));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: onboarded == true ? NewUserOnboarding() : HomeScreen(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}