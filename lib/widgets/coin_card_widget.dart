import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CoidCard extends StatelessWidget {
  const CoidCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
    child: Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(1, 1),
            blurRadius: 5,
          ),
        ]
      ),
    )
    );
  }
}