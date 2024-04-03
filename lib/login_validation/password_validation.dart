String? validatePassword (String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return 'Password cannot be empty';
  }
  return null;
}