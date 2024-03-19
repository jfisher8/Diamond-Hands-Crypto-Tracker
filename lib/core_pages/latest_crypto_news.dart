import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';

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
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(56, 182, 255, 1.0,),
        elevation: 0.0,
        actions: const [Icon(Icons.login_rounded, color: Colors.black), Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0))],
        centerTitle: true,
        title: Text('Latest Crypto News', style: Theme.of(context).textTheme.titleLarge),
      ),
      drawer: const NavigationMenu(),
      body: Column(
        children: <Widget>[
          Padding(padding: 
          const EdgeInsets.all(5),
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2),
              )
            ),
            style: Theme.of(context).textTheme.bodySmall,
          )),
          Expanded(child:
          ListView.builder(itemBuilder:(context, index) {
            return null;
          
            //business login for it here, replace with futureBuilder once API is added
          },
          ))
        ],
      ),
    );
  }
}