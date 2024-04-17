import 'package:flutter/material.dart';

Widget buildCryptoPrices(BuildContext context) {
  return (
    Column(children: [
      //add futurebuilder business logic here
      Padding(padding: const EdgeInsets.all(10),
      child: InkWell(
        child: SizedBox(
          height: 230,
          child: ListView.separated(separatorBuilder: (context, index) => const SizedBox(width: 10),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return const Placeholder();
          },
          itemCount: 15,
          )
        ),
      ),)
    ],)
  );
}