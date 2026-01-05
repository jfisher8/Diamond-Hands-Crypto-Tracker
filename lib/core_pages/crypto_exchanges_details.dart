import 'package:cached_network_image/cached_network_image.dart';
import 'package:diamond_hands_crypto_tracker/widgets/external_link_button_widgets.dart';
import 'package:diamond_hands_crypto_tracker/widgets/status_components.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/data_models/exchanges_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/saved_articles_screen.dart';
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
                        const Icon(Icons.bookmark_outline_rounded, color: Colors.black))
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
                imageUrl: exchanges.imageURL.toString(),
                placeholder: (context, url) => buildLoadingIcon(context),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: Colors.red, size: 20),
              )),
              const Padding(padding: EdgeInsets.all(5)),
              Text(exchanges.name.toString(), style: const TextStyle(fontSize: 28)),
            ],
          ),
          //const SizedBox(height: 20),
          exchanges.yearEstablished == null
              ? const Text("")
              : Text("Established in ${exchanges.yearEstablished}",
                  style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 20),
          exchanges.description == null || exchanges.description!.isEmpty
              ? const Text("")
              : Card(
                      elevation: 10,
                      child: Column(children: [
                            Text(exchanges.description!.trim().toString(),
                                textAlign: TextAlign.justify),
                          ])),
                          CryptoExchangesReadMoreButton(name: exchanges.name.toString(), url: exchanges.url.toString())])
        )));
  }
}
