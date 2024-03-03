import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:flutter/material.dart';
//import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(56, 182, 255, 1.0),
        centerTitle: true,
        title: const Text('Diamond Hands Crypto Tracker'),
        actions: const <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Icon(
                Icons.login,
                color: Colors.black,
              )),
        ],
      ),
      drawer: const NavigationMenu(),
    );
  }
}
