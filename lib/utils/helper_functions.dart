class HelperFunctions {
  static String getValidPhoneNumber(Iterable phoneNumber) {
    if (phoneNumber != null && phoneNumber.toList().isNotEmpty) {
      List phoneNumberList = phoneNumber.toList();
      return phoneNumberList[0].value;
    } else if (phoneNumber != null && phoneNumber.toList().isNotEmpty) {
      List phoneNumberList = phoneNumber.toList();
      return phoneNumberList[1].value;
    }
    return '';
  }

  static String getEmergencyPhoneNumber(String number) {
  if (number != null) {
    number = number.replaceAll(RegExp(r"[^\w]"), "");
    return number;
  }
  return null;
}
}
