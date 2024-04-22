import 'package:diamond_hands_crypto_tracker/data_models/exchanges_model.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/favourites_screen.dart';
import 'package:diamond_hands_crypto_tracker/widgets/exchanges_card_widget.dart';
import 'package:diamond_hands_crypto_tracker/api_functions/get_exchange_data.dart';
import 'package:diamond_hands_crypto_tracker/widgets/api_loading_status.dart';

class CryptoExchanges extends StatefulWidget {
  const CryptoExchanges({super.key});

  @override
  State<CryptoExchanges> createState() => _CryptoExchangesState();
}

class _CryptoExchangesState extends State<CryptoExchanges> {
  @override
  void initState() {
    fetchExchanges();
    setState(() {
      exchangesList;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BuildAppBar(
          title: const Text('Crypto Exchanges'),
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
            future: fetchExchanges(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return buildLoadingDataStatus(context);
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return buildDataErrorStatus(context);
                } else if (snapshot.hasData) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: exchangesList.length,
                      itemBuilder: (context, index) {
                        return ExchangesCard(
                          name: exchangesList[index].name,
                          image: exchangesList[index].image,
                          yearEstablished:
                              exchangesList[index].yearEstablished.toString(),
                          url: exchangesList[index].url,
                        );
                      });
                } else {
                  return buildDataErrorStatus(context);
                }
              }
              return buildDataErrorStatus(context);
            }));
  }
}
