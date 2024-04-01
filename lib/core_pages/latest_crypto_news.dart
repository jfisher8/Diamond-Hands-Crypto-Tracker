import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/home_screen.dart';

class LatestCryptoNews extends StatefulWidget {
  const LatestCryptoNews({super.key});

  @override
  State<LatestCryptoNews> createState() => _LatestCryptoNewsState();
}

class _LatestCryptoNewsState extends State<LatestCryptoNews> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
        title: const Text('Latest Crypto News'),
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
      drawer: const NavigationMenu(),
      body: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    )),
                style: Theme.of(context).textTheme.bodySmall,
              )),
          Expanded(child: ListView.builder(
            itemBuilder: (context, index) {
              return null;

              //business login for it here, replace with futureBuilder once API is added
            },
          ))
        ],
      ),
    );
  }
}
