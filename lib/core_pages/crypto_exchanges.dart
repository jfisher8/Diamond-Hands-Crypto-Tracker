import 'package:diamond_hands_crypto_tracker/data_models/exchanges_model.dart';
import 'package:flutter/material.dart';
import 'package:diamond_hands_crypto_tracker/navigation/navigation_drawer.dart';
import 'package:diamond_hands_crypto_tracker/widgets/appbar.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/favourites_screen.dart';
import 'package:diamond_hands_crypto_tracker/core_pages/crypto_exchanges_details.dart';
import 'package:diamond_hands_crypto_tracker/api_functions/get_exchange_data.dart';
import 'package:diamond_hands_crypto_tracker/widgets/status_components.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
          title: Text('Crypto Exchanges',
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
        drawer: const NavigationMenu(),
        body: FutureBuilder(
            future: fetchExchanges(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return buildExchangesLoadingStatus(context);
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return buildExchangesErrorStatus(context);
                } else if (snapshot.hasData) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: exchangesList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 10, right: 10),
                            child: Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CryptoExchangesDetails(
                                                exchanges: snapshot.data[index],
                                              )));
                                },
                                trailing:
                                    const Icon(Icons.arrow_forward_rounded),
                                leading: ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxHeight: 100),
                                    child: CachedNetworkImage(
                                        imageUrl: snapshot.data[index].imageURL,
                                        placeholder: (context, url) =>
                                            buildLoadingIcon(context),
                                        errorWidget:
                                            (context, imageUrl, error) =>
                                                buildErrorIcon(context))),
                                title: Text(snapshot.data[index].name),
                                subtitle:
                                    snapshot.data[index].yearEstablished == null
                                        ? const Text("")
                                        : Text(snapshot
                                            .data[index].yearEstablished
                                            .toString()),
                              ),
                            ));
                      });
                } else {
                  return buildExchangesErrorStatus(context);
                }
              }
              return buildExchangesErrorStatus(context);
            }));
  }
}
