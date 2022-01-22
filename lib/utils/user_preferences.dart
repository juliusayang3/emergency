import 'dart:convert';

import 'package:emergency/model/phone.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:emergency/model/user.dart';

class UserSimplePreferences extends ChangeNotifier {
  static SharedPreferences _preferences;
  String offlineNumber;
  static const _keyPhoneNumber = 'phoneNumber';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future setPhoneNumber(String phoneNumber) async {
    try {
      await _preferences.setString(
        _keyPhoneNumber,
        phoneNumber,
      );
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  String get number {
    return offlineNumber;
  }

  numberOffline(String number) {
    offlineNumber = number;
    notifyListeners();
  }

  String get getPhoneNumber {
    return _preferences.getString(_keyPhoneNumber);
  }

  static const _keyUser = 'user';
  static const myUser = User(
    firstName: '',
    lastName: '',
  );

  Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(
      _keyUser,
      json,
    );
    notifyListeners();
  }

  User getUser() {
    final json = _preferences.getString(_keyUser);
    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}
