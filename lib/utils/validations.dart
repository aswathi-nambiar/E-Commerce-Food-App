/// This class all the static functions for validation check for
/// each email id, mobile number and pincode field
class Validations {
  static const String _emailPattern = "[#a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+";
  static const String _mobileNumberPattern =
      "^[\+]?[(]?[0-9]{3}[)]?[-\s\]?[0-9]{3}[-\s\]?[0-9]{4,6}\$";
  static const String _pinCodePattern = "^[0-9]{6}\$";

  /// Validations for email
  static bool validateEmail(String value) {
    RegExp regExp = RegExp(_emailPattern);
    if (!regExp.hasMatch(value.trim())) {
      return false;
    }
    return true;
  }

  /// Validations for Mobile Number
  static bool isValidMobileNumber(String number) {
    RegExp regExp = RegExp(_mobileNumberPattern);
    if (!regExp.hasMatch(number.trim())) {
      return false;
    }
    return true;
  }

  /// Validations for Pincode
  static bool isValidPinCode(String number) {
    RegExp regExp = RegExp(_pinCodePattern);
    if (!regExp.hasMatch(number.trim())) {
      return false;
    }
    return true;
  }
}
