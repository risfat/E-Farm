
mixin InputValidationMixin {
  bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regx = RegExp(pattern.toString());
    return regx.hasMatch(email);
  }

  bool isLoginPasswordValid(String password) {
    return password.length > 7;
  }

  bool isNameValid(String name) {
    return name.length > 5;
  }

  bool isPhoneValid(String phone) {
    return phone.length >= 10;
  }


  bool isPasswordValid(String password) {
    return password.length > 7;
  }
}
