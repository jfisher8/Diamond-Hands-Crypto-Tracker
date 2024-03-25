class TextfieldValidation {
  bool checkTextField(String textToCheck, String type) {
    bool textFieldCheck = false;
    if (textToCheck.isNotEmpty) {
      if (type == "email") {
        textFieldCheck = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(textToCheck);
      }
    } else {
      textFieldCheck = false;
    }
    return textFieldCheck;
  }
}