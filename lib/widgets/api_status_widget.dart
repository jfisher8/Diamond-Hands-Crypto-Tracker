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
        Text('Error loading News. Please refresh and try again.'),
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
        Text('Error loading Exchanges data. Please refresh and try again.'),
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
        Text('Error Exchanges data...'),
      ],
    ),
  );
}