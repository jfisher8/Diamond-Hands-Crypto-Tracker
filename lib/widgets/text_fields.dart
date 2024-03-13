import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextFormField emailAddressTextField(String text, IconData icon,
    bool isPasswordType, TextEditingController controller) {
  return TextFormField(
    key: const Key("emailAddress"),
    controller: controller,
    //validator: validateEmail, <-- TODO: uncomment when the email validation function is written
    obscureText: isPasswordType,
    cursorColor: Colors.black,
    style: const TextStyle(color: Colors.black, fontSize: 14),
    decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: const Color.fromRGBO(56, 182, 255, 1.0),
        ),
        labelText: text,
        labelStyle: GoogleFonts.mavenPro(
            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.grey[400],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        )),
  );
}

TextFormField usernameTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextFormField(
    controller: controller,
    obscureText: isPasswordType,
    cursorColor: Colors.black,
    style: const TextStyle(color: Colors.black, fontSize: 14),
    decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: const Color.fromRGBO(56, 182, 255, 1.0),
        ),
        labelText: text,
        labelStyle: GoogleFonts.mavenPro(
            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.grey[400],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        )),
  );
}

TextFormField passwordTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextFormField(
    controller: controller,
    //validator: validatePassword, <-- TODO: uncomment when the password validation function is written
    obscureText: isPasswordType,
    cursorColor: Colors.black,
    style: const TextStyle(color: Colors.black, fontSize: 14),
    decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: const Color.fromRGBO(56, 182, 255, 1.0),
        ),
        labelText: text,
        labelStyle: GoogleFonts.mavenPro(
            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.grey[400],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        )),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}
