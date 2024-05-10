import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/data_models/exchanges_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/favourites_screen.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';

class CryptoExchangesDetails extends StatelessWidget {
  const CryptoExchangesDetails({super.key, required this.exchanges});
  final Exchanges exchanges;

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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FavouritesScreen()),
                      );
                    },
                    icon:
                        const Icon(Icons.bookmark_rounded, color: Colors.black))
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
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: CachedNetworkImage(imageUrl: exchanges.imageURL)),
                  const Padding(padding: EdgeInsets.all(5)),
                  Text(exchanges.name,
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              )
            ],
          ),
        ));
  }
}
