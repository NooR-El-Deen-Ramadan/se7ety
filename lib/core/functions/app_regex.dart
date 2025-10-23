class AppRegex {
  static isEmailValid(String email) => RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  ).hasMatch(email);

  static isPhoneValid(String phone) =>
      RegExp(r"^[010|011|012|015]{8}$").hasMatch(phone);
}
