import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';

class CryptoExchanges extends StatefulWidget {
  const CryptoExchanges({super.key});

  @override
  State<CryptoExchanges> createState() => _CryptoExchangesState();
}

class _CryptoExchangesState extends State<CryptoExchanges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Crypto Exchanges', style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
        actions: const [Icon(Icons.login_rounded, color: Colors.black), Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0))],
      ),
      body: ListView.builder(
        itemBuilder:(context, index) {
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