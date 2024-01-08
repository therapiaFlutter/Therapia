class FormValidation {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return null; 
    }

    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (!emailValid) {
      return 'Please enter a valid email';
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return null; 
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    return null;
  }
}
