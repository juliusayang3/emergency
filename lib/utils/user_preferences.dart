import 'dart:convert';

import 'package:emergency/model/phone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:emergency/model/user.dart';

class UserSimplePreferences {
  static SharedPreferences _preferences;

  static const _keyPhoneNumber = 'phoneNumber';
  

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setPhoneNumber(String phoneNumber) async {
    await _preferences.setString(
      _keyPhoneNumber,
      phoneNumber,
    );
  }

  static String getPhoneNumber() => _preferences.getString(_keyPhoneNumber);

  
  static const _keyUser = 'user';
  static const myUser = User(
    firstName: 'julius',
    lastName: 'ayang',
  );

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(
      _keyUser,
      json,
    );
  }

  static User getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }

  static const _keyPhone = 'phone';
  static const myPhone = Phone(
    phoneNumber: '09027520630',
    
  );

  static Future setPhone(Phone phone) async {
    final json = jsonEncode(phone.toJson());

    await _preferences.setString(
      _keyPhone,
      json,
    );
  }

  static Phone getPhone() {
    final json = _preferences.getString(_keyPhone);

    return json == null ? myPhone : Phone.fromJson(jsonDecode(json));

  }
}
