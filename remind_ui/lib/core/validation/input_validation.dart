class Valid {
  static bool isEmail(String email) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  static bool isPassword(String password) {
    if (password.length < 8) {
      return false;
    }

    return true;
  }

  static bool isName(String name) {
    if (name.length < 3) {
      return false;
    }
    return true;
  }

  static bool ismatch(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return false;
    }
    return true;
  }
}
