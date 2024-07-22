import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CoinCard extends StatelessWidget {
  const CoinCard({
    super.key,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.change,
    required this.changePercentage,
  });

  final String? name;
  final String? symbol;
  final String? imageUrl;
  final String? price;
  final num? change;
  final num? changePercentage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Card(
        // height: 110,
        // decoration: BoxDecoration(
        //   //TODO: explore adding dark mode check here to select colour of coin widget
        //   color: Colors.grey[600],
        //   borderRadius: BorderRadius.circular(20),
        // ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 60,
                width: 60,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CachedNetworkImage(
                      imageUrl: imageUrl!,
                      placeholder: (imageUrl, error) =>
                          const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
                      errorWidget: (context, imageUrl, error) =>
                          const Icon(Icons.error, color: Colors.red)),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      name!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    symbol!.toUpperCase(),
                    style: const TextStyle(color: Colors.white)
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "£$price",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    change!.toDouble() < 0
                        ? change!.toDouble().toStringAsFixed(2)
                        : '+£${change!.toDouble().toStringAsFixed(2)}',
                    style: TextStyle(
                      color: change!.toDouble() < 0 ? Colors.red : Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    changePercentage!.toDouble() < 0
                        ? '${changePercentage!.toDouble().toStringAsFixed(2)}%'
                        : '+${changePercentage!.toDouble().toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: changePercentage!.toDouble() < 0
                          ? Colors.red
                          : Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    ));
  }
}
