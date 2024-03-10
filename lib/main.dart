import 'package:diamond_hands_crypto_tracker/core_pages/home_screen.dart';
import 'package:diamond_hands_crypto_tracker/new_user_onboarding/new_user_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

bool onboarded = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
        options: const FirebaseOptions(  
          apiKey: "AIzaSyA0Orx2bv5G6Jk5x_HyBLWoFhEOhohLvXA",
          appId: "1:157892586995:android:9b652a9fd3bf7418fe3686",
          messagingSenderId: "157892586995",
          projectId: "co2404-flutter-project"
  ));
  SharedPreferences preferences = await SharedPreferences.getInstance(); //gets an instance of Local storage
  String? email = preferences.getString('emailAddress');
  SharedPreferences onboarding = await SharedPreferences.getInstance();
  bool showOnboarding = onboarding.getBool('onboarding') ?? true;
  //if email variable is null, state there is no current session, else, state last logged in email
  email == null ? developer.log('SharedPrefs: No current session') : 
  developer.log('Last logged in session: ' "$email");
  developer.log('Should onboarding be shown? ' "$showOnboarding");

  runApp(MaterialApp(
    //home page of the app is determined by if onboarded bool equals true
    home: onboarded == true ? const HomeScreen() : NewUserOnboarding(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      appBarTheme: const AppBarTheme(
         backgroundColor: Color.fromRGBO(56, 182, 255, 1.0),
         ),
      textTheme: TextTheme(
        titleSmall: GoogleFonts.questrial(fontWeight: FontWeight.bold, fontSize: 16, color: const Color.fromRGBO(56, 182, 255, 1.0),),
        titleMedium: GoogleFonts.questrial(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        titleLarge: GoogleFonts.anton(fontSize: 20, color: Colors.black),
        bodySmall: GoogleFonts.mavenPro(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
        bodyMedium: GoogleFonts.mavenPro(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
        bodyLarge: GoogleFonts.mavenPro(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      )
      )
    ),
  );
}