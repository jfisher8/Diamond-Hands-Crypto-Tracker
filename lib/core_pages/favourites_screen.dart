import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BuildAppBar(
            title: const Text('Your Favourites'),
            appBar: AppBar(),
            widgets: [
          IconButton(
              onPressed: () {
                //add onPressed logic here to delete a favourite when user selects such
              },
              icon: const Icon(Icons.delete_rounded, color: Colors.black))
        ]));
  }
}
