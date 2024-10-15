import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/widgets/coin_card_widget.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/favourites_screen.dart';
import 'package:diamond_hands_crypto_tracker/data_models/coin_model.dart';
import 'package:diamond_hands_crypto_tracker/api_functions/get_and_store_price_data.dart';
import 'package:diamond_hands_crypto_tracker/widgets/status_components.dart';

class LatestCryptoPrices extends StatefulWidget {
  const LatestCryptoPrices({super.key});

  @override
  State<LatestCryptoPrices> createState() => _LatestCryptoPricesState();
}

class _LatestCryptoPricesState extends State<LatestCryptoPrices> {
  @override
  void initState() {
    fetchCoin();
    setState(() {
      coinList;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BuildAppBar(
          title: Text('Latest Crypto Prices', style: Theme.of(context).textTheme.titleLarge),
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
        drawer: const NavigationMenu(),
        body: FutureBuilder(
            future: fetchCoin(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return buildLoadingCoinsStatus(context);
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return buildCoinsErrorStatus(context);
                } else if (snapshot.hasData) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: coinList.length,
                      itemBuilder: (context, index) {
                        return CoinCard(
                          name: coinList[index].name,
                          imageUrl: coinList[index].imageURL,
                          change: coinList[index].change,
                          changePercentage: coinList[index].changePercentage,
                          symbol: coinList[index].symbol,
                          price: coinList[index].price
                        );
                      });
                } else {
                  return buildCoinsErrorStatus(context);
                }
              }
              return buildCoinsErrorStatus(context);
            }
            ));
  }
}
