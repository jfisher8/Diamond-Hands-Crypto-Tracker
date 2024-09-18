import 'package:cached_network_image/cached_network_image.dart';
import 'package:diamond_hands_crypto_tracker/widgets/status_components.dart';
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
          title: Text('Diamond Hands Crypto Tracker',
              style: Theme.of(context).textTheme.titleLarge),
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
        body: SafeArea(
            child: Center(
                child: Column(children: [
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: CachedNetworkImage(
                imageUrl: exchanges.imageURL,
                placeholder: (context, url) => buildLoadingIcon(context),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: Colors.red, size: 20),
              )),
              const Padding(padding: EdgeInsets.all(5)),
              Text(exchanges.name, style: const TextStyle(fontSize: 28)),
            ],
          ),
          const SizedBox(height: 20),
          exchanges.yearEstablished == null
              ? const Text("")
              : Text("Established in ${exchanges.yearEstablished}",
                  style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 20),
          exchanges.description == null
              ? Container()
              : Card(
                elevation: 10,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: Text(exchanges.description.toString(),
                          textAlign: TextAlign.justify))),
        ]))));
  }
}
