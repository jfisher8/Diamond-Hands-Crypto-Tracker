import 'package:flutter/material.dart';

Container saveForLaterButton(BuildContext context, Function onTap) {
  return Container(
    width: 250,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return const Color.fromRGBO(56, 182, 255, 1.0);
            }
            return const Color.fromRGBO(56, 182, 255, 1.0);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          )),
      child: Text('Save for Later', style: Theme.of(context).textTheme.bodyLarge),
    ),
  );
}