import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diamond_hands_crypto_tracker/login_validation/email_validation.dart';
import 'package:diamond_hands_crypto_tracker/login_validation/password_validation.dart';

TextFormField resetPasswordTextField(
    String text, bool isPasswordType, TextEditingController controller) {
  return TextFormField(
      key: const Key("emailAddress"),
      controller: controller,
      validator: validateEmail,
      obscureText: isPasswordType,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black, fontSize: 14),
      decoration: InputDecoration(
          labelText: text,
          labelStyle: GoogleFonts.mavenPro(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Colors.grey[300],
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
          )));
}

TextFormField emailAddressTextField(String text, IconData icon,
    bool isPasswordType, TextEditingController controller) {
  return TextFormField(
      key: const Key("emailAddress"),
      controller: controller,
      validator: validateEmail,
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
          fillColor: Colors.grey[300],
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
          )));
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
    validator: validatePassword,
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
        fillColor: Colors.grey[300],
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        )),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}
