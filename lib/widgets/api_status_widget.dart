import 'package:flutter/material.dart';

Widget buildLoadingCoinsStatus(BuildContext context) {
  return const Center(
    child: Column(
      children: [
        SizedBox(height: 40),
        CircularProgressIndicator(),
        SizedBox(height: 40),
        Text('Loading Coin data...'),
      ],
    ),
  );
}

Widget buildCoinsErrorStatus(BuildContext context) {
  return const Center(
    child: Column(
      children: [
        SizedBox(height: 40),
        CircularProgressIndicator(),
        SizedBox(height: 40),
        Text('Error loading Coin data. Please try again later.'),
      ],
    ),
  );
}

Widget buildDataErrorStatus(BuildContext context) {
  return const Center(
    child: Column(
      children: [
        SizedBox(height: 40),
        CircularProgressIndicator(),
        SizedBox(height: 40),
        Text('Error loading data. Please refresh and try again.'),
      ],
    ),
  );
}

Widget buildPricesErrorStatus(BuildContext context) {
  return const Center(
    child: Column(
      children: [
        SizedBox(height: 40),
        CircularProgressIndicator(),
        SizedBox(height: 40),
        Text('Error loading prices. Please refresh and try again.'),
      ],
    ),
  );
}