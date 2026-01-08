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
        title: Text(
          'Diamond Hands Crypto Tracker',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        appBar: AppBar(),
        widgets: [
          FirebaseAuth.instance.currentUser != null
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavouritesScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.bookmark_outline_rounded,
                    color: Colors.black,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.login_rounded, color: Colors.black),
                ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
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
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  Text(
                    exchanges.name.toString(),
                    style: const TextStyle(fontSize: 28),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              exchanges.yearEstablished == null
                  ? const Text("")
                  : Text(
                      "Established in ${exchanges.yearEstablished}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
              exchanges.description == null || exchanges.description!.isEmpty
                  ? Flexible(
                      child: Column(
                        children: [
                          SizedBox(height: 100),
                          Flexible(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  Card(
                                    color: Color(
                                      const Color.fromARGB(
                                        255,
                                        126,
                                        8,
                                        0,
                                      ).toARGB32(),
                                    ),
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        16.0,
                                        16.0,
                                        16.0,
                                        0.0,
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.error_rounded,
                                            color: Colors.red,
                                          ),
                                          Text(
                                            "No Exchanges description info available",
                                          ),
                                          SizedBox(height: 20),
                                          CryptoExchangesReadMoreButton(
                                            name: exchanges.name.toString(),
                                            url: exchanges.url.toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Card(
                              elevation: 5,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 390),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      exchanges.description!.trim(),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 16),

                            // Grid of 2 square tiles
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Row(
                                children: [
                                  // First tile
                                  Expanded(
                                    child: AspectRatio(
                                      aspectRatio: 1, // Makes it square
                                      child: Card(
                                        elevation: 3,
                                        child: InkWell(
                                          onTap: () {
                                            // Handle tap
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.handshake_rounded,
                                                  size: 40,
                                                  color: Colors.green,
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  'Trust Score',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  exchanges.trustScore
                                                          ?.toString() ??
                                                      'N/A',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Card(
                                        elevation: 3,
                                        child: InkWell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.leaderboard_rounded,
                                                  size: 40,
                                                  color: Colors.blue,
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  'Rank',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  exchanges.trustScoreRank
                                                          ?.toString() ??
                                                      'N/A',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            CryptoExchangesReadMoreButton(
                              name: exchanges.name.toString(),
                              url: exchanges.url.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
