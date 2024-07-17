import 'package:flutter/material.dart';

Widget buildLoadingCoinsStatus(BuildContext context) {
  return const Center(
    child: Column(
      children: [
        SizedBox(height: 40),
        CircularProgressIndicator(),
        SizedBox(height: 40),
        Text('Loading Coin data...', style: TextStyle(fontSize: 18, color: Colors.red)),
      ],
    ),
  );
}

Widget buildCoinsErrorStatus(BuildContext context) {
  return const Center(
    child: Column(
      children: [
        SizedBox(height: 40),
        Icon(Icons.error_rounded, size: 75),
        SizedBox(height: 40),
        Text('Error loading Coin data. Please try again later.',
            style: TextStyle(fontSize: 18, color: Colors.red),
            textAlign: TextAlign.center),
        SizedBox(height: 80)
      ],
    ),
  );
}

Widget buildLoadingNewsStatus(BuildContext context) {
  return const Center(
    child: Column(
      children: [
        SizedBox(height: 40),
        CircularProgressIndicator(),
        SizedBox(height: 40),
        Text('Loading News data...'),
      ],
    ),
  );
}

Widget buildNewsErrorStatus(BuildContext context) {
  return const Center(
    child: Column(
      children: [
        SizedBox(height: 40),
        Icon((Icons.error)),
        SizedBox(height: 40),
        Text('Error loading News. Please refresh and try again.',
            textAlign: TextAlign.center),
      ],
    ),
  );
}

Widget buildExchangesErrorStatus(BuildContext context) {
  return const Center(
    child: Column(
      children: [
        SizedBox(height: 40),
        Icon((Icons.error)),
        SizedBox(height: 40),
        Text('Error loading Exchanges data. Please refresh and try again.',
            textAlign: TextAlign.center),
      ],
    ),
  );
}

Widget buildExchangesLoadingStatus(BuildContext context) {
  return const Center(
    child: Column(
      children: [
        SizedBox(height: 40),
        CircularProgressIndicator(),
        SizedBox(height: 40),
        Text('Loading Exchanges data...', textAlign: TextAlign.center),
      ],
    ),
  );
}
