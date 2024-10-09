import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      child: Text('Save for Later', style: GoogleFonts.mavenPro(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
    ),
  );
}

Container loginAndSaveButton(BuildContext context, Function onTap) {
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
      child: Text('Login and save for later', style: Theme.of(context).textTheme.bodyLarge),
    ),
  );
}