import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CoinCard extends StatelessWidget {
  CoinCard({
    super.key,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.change,
    required this.changePercentage,
  });

  String? name;
  String? symbol;
  String? imageUrl;
  String? price;
  num? change;
  num? changePercentage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade100,
              offset: const Offset(1, 1),
              blurRadius: 5,
            ),
          ],
        ),
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
                          const CircularProgressIndicator(),
                      errorWidget: (context, imageUrl, error) =>
                          const Icon(Icons.error)),
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
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    symbol!.toUpperCase(),
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 14,
                    ),
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
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    change!.toDouble() < 0
                        ? change!.toDouble().toStringAsFixed(2)
                        : '+${change!.toDouble().toStringAsFixed(2)}',
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
      ),
    );
  }
}