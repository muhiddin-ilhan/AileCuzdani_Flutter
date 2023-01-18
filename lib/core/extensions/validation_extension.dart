extension ValidationExtension on String {
  bool emailValidation() {
    RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (emailRegex.hasMatch(this)) return true;

    return false;
  }

  bool passwordValidation() {
    RegExp passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,16}$');
    if (passwordRegex.hasMatch(this)) return true;

    return false;
  }

  bool alphabeticValidation() {
    RegExp alphabeticRegex = RegExp(r'^[a-zA-Z İÖĞÜŞÇığüşöç]{2,30}$');
    if (alphabeticRegex.hasMatch(this)) return true;

    return false;
  }

  bool alphanumericValidation() {
    RegExp alphanumericRegex = RegExp(r'^[a-zA-Z0-9 İÖĞÜŞÇığüşöç]{2,30}$');
    if (alphanumericRegex.hasMatch(this)) return true;

    return false;
  }

  bool phoneNumberValidation() {
    RegExp digitRegex = RegExp(r'^[0-9]{11}$');
    if (digitRegex.hasMatch(this)) return true;

    return false;
  }

  bool confirmationCodeValidation() {
    RegExp alphanumericRegex = RegExp(r'^[a-zA-Z0-9İÖĞÜŞÇığüşöç]{6}$');
    if (alphanumericRegex.hasMatch(this)) return true;

    return false;
  }
}
