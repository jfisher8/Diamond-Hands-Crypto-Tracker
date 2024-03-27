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
          apiKey: "AIzaSyABkZc2EC8iY2vshGnv2U_NSYwz6-o-XrE",
          appId: "1:319458704280:android:6954fb2edb0cb9f06609ed",
          messagingSenderId: "319458704280",
          projectId: "diamond-hands-crypto-tracker"
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
    home: onboarded == true ? NewUserOnboarding() : const HomeScreen(), //swap the screen routing after testing
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      textTheme: TextTheme(
        titleSmall: GoogleFonts.questrial(fontWeight: FontWeight.bold, fontSize: 16, color: const Color.fromRGBO(56, 182, 255, 1.0),),
        titleLarge: GoogleFonts.anton(fontSize: 20, color: Colors.black),
        bodySmall: GoogleFonts.mavenPro(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
        bodyMedium: GoogleFonts.mavenPro(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
        bodyLarge: GoogleFonts.mavenPro(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      )
      )
    ),
  );
}