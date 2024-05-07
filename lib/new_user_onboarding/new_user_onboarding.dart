import 'package:diamond_hands_crypto_tracker/core_pages/home_screen.dart';
import 'package:diamond_hands_crypto_tracker/new_user_onboarding/sign_up_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer' as developer;
//import 'package:diamond_hands_crypto_tracker/core_pages/latest_crypto_prices.dart';

class NewUserOnboarding extends StatelessWidget {
  NewUserOnboarding({super.key});

  final List<PageViewModel> onboardingScreens = [
    PageViewModel(
        image: Center(
          child: Card(
              elevation: 30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90)),
              child: Image.asset('assets/diamond_hands_logo.png')),
        ),
        title: 'Welcome to \n The Diamond Hands Crypto Tracker',
        body:
            'The all-in-one crypto-tracking application for new and existing cryprocurrency investors',
        footer: const SizedBox(
          height: 40,
          width: 300,
        ),
        decoration: PageDecoration(
          titleTextStyle:
              GoogleFonts.mavenPro(fontSize: 14, fontWeight: FontWeight.bold),
          bodyTextStyle: GoogleFonts.mavenPro(fontSize: 12),
        )),
    PageViewModel(
        image: Center(
          child: Image.asset('assets/material_upwards_trend_arrow_black.png'),
        ),
        title: 'Track the prices of your favourite crypto',
        body:
            'Track the prices of your favourite cryptocurrencies from the moment you load into the app.',
        footer: const SizedBox(
          height: 40,
          width: 300,
        ),
        decoration: PageDecoration(
          titleTextStyle:
              GoogleFonts.mavenPro(fontSize: 14, fontWeight: FontWeight.bold),
          bodyTextStyle: GoogleFonts.mavenPro(fontSize: 12),
        )),
    PageViewModel(
        image: Center(
          child: Image.asset('assets/material_exchanges_black.png'),
        ),
        title: 'Research the best crypto exchanges',
        body:
            "View the latest info about the market's crypto exchanges to choose which may be best for you.",
        footer: const SizedBox(
          height: 40,
          width: 300,
        ),
        decoration: PageDecoration(
          titleTextStyle:
              GoogleFonts.mavenPro(fontSize: 14, fontWeight: FontWeight.bold),
          bodyTextStyle: GoogleFonts.mavenPro(fontSize: 12),
        )),
    PageViewModel(
        image: Center(
          child: Image.asset('assets/material_newspaper_black.png'),
        ),
        title: "All the latest news",
        body: "Read the latest news on all things cryptocurrency",
        footer: const SizedBox(
          height: 40,
          width: 300,
        ),
        decoration: PageDecoration(
          titleTextStyle:
              GoogleFonts.mavenPro(fontSize: 14, fontWeight: FontWeight.bold),
          bodyTextStyle: GoogleFonts.mavenPro(fontSize: 12),
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 150, 8, 40),
        child: IntroductionScreen(
          pages: onboardingScreens,
          dotsDecorator: const DotsDecorator(
            size: Size(15, 15),
            color: Colors.blue,
            activeSize: Size.square(15),
            activeColor: Colors.red,
          ),
          showDoneButton: true,
          done: ElevatedButton(
            child: Text('Next',
                style: GoogleFonts.mavenPro(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold)),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SignUpOnboardingScreen()),
            ),
          ),
          showSkipButton: true,
          onSkip: () => onDone(context),
          skip: ElevatedButton(
              onPressed: () {
                onDone(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              child: Text('Skip',
                  style: GoogleFonts.mavenPro(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue))),
          showNextButton: true,
          next: const Icon(
            Icons.arrow_forward,
            size: 40,
            color: Colors.blue,
          ),
          onDone: () => onDone(context),
          curve: Curves.bounceOut,
        ),
      ),
    );
  }

  void onDone(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding', false);
    developer.log("onboarding status set FALSE");
  }
}
