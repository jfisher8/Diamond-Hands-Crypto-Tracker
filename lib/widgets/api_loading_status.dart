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