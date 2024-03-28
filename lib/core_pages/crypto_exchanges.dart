import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/home_screen.dart';

class CryptoExchanges extends StatefulWidget {
  const CryptoExchanges({super.key});

  @override
  State<CryptoExchanges> createState() => _CryptoExchangesState();
}

class _CryptoExchangesState extends State<CryptoExchanges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        title: const Text('Diamond Hands Crypto Tracker'),
        appBar: AppBar(),
        widgets: [
          FirebaseAuth.instance.currentUser != null
              ? IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.remove('emailAddress');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    });
                  },
                  icon: const Icon(Icons.logout_rounded, color: Colors.black))
              : IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  icon: const Icon(Icons.login_rounded, color: Colors.black)),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return const ListTile(
            title: Text('Test title'),
          );
          //business logic here once API is added
        },
        itemCount: 20,
        //TODO: return exchangesCard widget here once it
      ),
      drawer: const NavigationMenu(),
    );
  }
}
