import 'package:flutter/material.dart';

Widget buildLoadingDataStatus(BuildContext context) {
  return const Center(
    child: Column(
      children: [
        SizedBox(height: 40),
        CircularProgressIndicator(),
        SizedBox(height: 40),
        Text('Loading data...'),
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