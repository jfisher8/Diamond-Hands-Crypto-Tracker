String? validatePassword (String? formPassword) {
  if (formPassword == null) {
    return 'Password cannot be empty';
  }
  return null;
}