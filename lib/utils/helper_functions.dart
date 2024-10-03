class HelperFunctions {
  static String getValidPhoneNumber(Iterable phoneNumber) {
    if (phoneNumber.toList().isNotEmpty) {
      List phoneNumberList = phoneNumber.toList();

      return phoneNumberList[0].value;
    } else if (phoneNumber.toList().isNotEmpty) {
      List phoneNumberList = phoneNumber.toList();
      return phoneNumberList[1].value;
    }
    return '';
  }

  static String? getEmergencyPhoneNumber(String number) {
    number = number.replaceAll(RegExp(r"[^\w]"), "");
    return number;
  }
}
