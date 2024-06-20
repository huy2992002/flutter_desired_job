import 'dart:convert';
import 'package:flutter_desired_job/models/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String accKey = 'accKey';
  static const String languageKey = 'languageKey';

  static late SharedPreferences _prefs;

  static Future<void> initialise() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static AccountModel? get account {
    String? data = _prefs.getString(accKey);
    if (data == null) return null;
    AccountModel account =
        AccountModel.fromJson(jsonDecode(data) as Map<String, dynamic>);
    return account;
  }

  static set account(AccountModel? user) {
    if (user != null) {
      _prefs.setString(accKey, jsonEncode(user.toJsonLocal()));
    }
  }

  static void removeUserLogin() {
    _prefs.remove(accKey);
  }

  static String get language {
    return _prefs.getString(languageKey) ?? 'en';
  }

  static set language(String value) => _prefs.setString(languageKey, value);
}
