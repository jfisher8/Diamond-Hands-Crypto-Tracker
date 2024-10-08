import 'package:flutter/material.dart';

Widget buildLoadingCoinsStatus(BuildContext context) {
  return const Center(
    child: Column(
      children: [
        SizedBox(height: 40),
        CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
        SizedBox(height: 40),
        Text(
          'Loading Coin data...',
          style: TextStyle(fontSize: 18, color: Colors.blue),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget buildCoinsErrorStatus(BuildContext context) {
  return const Center(
    child: Column(
      children: [
        SizedBox(height: 40),
        Icon(Icons.error_rounded, size: 75, color: Colors.red),
        SizedBox(height: 40),
        Text('Error loading Coin data. \n Please try again later.',
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
        CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
        SizedBox(height: 40),
        Text(
          'Loading News data...',
          style: TextStyle(fontSize: 18, color: Colors.blue),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget buildNewsErrorStatus(BuildContext context) {
  return const Center(
    child: Column(
      children: [
        SizedBox(height: 40),
        Icon(Icons.error_rounded, size: 75, color: Colors.red),
        SizedBox(height: 40),
        Text('Error loading News. \n Please refresh and try again.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.red)),
      ],
    ),
  );
}

Widget buildExchangesErrorStatus(BuildContext context) {
  return const Center(
    child: Column(
      children: [
        SizedBox(height: 40),
        Icon(Icons.error_rounded, size: 75, color: Colors.red),
        SizedBox(height: 40),
        Text('Error loading Exchanges data.\n Please refresh and try again.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.red)),
      ],
    ),
  );
}

Widget buildExchangesLoadingStatus(BuildContext context) {
  return const Center(
    child: Column(
      children: [
        SizedBox(height: 40),
        CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
        SizedBox(height: 40),
        Text(
          'Loading Exchanges data...',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.blue),
        ),
      ],
    ),
  );
}

Widget buildLoadingIcon(BuildContext context) {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(56, 182, 255, 1.0)),
  );
}

Widget buildErrorIcon(BuildContext context) {
  return const Icon(
   Icons.error_outline_rounded,
   color: Colors.red
  );
}