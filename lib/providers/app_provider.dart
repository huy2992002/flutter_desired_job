import 'package:flutter/material.dart';
import 'package:flutter_desired_job/services/local/shared_prefs/shared_prefs.dart';

class AppProvider with ChangeNotifier {
  Locale _locale = Locale(SharedPrefs.language);

  Locale get locale => _locale;

  set locale(Locale locate) {
    _locale = locate;
    notifyListeners();
  }

  void changedLocaleVi() {
    _locale = const Locale('vi');
    notifyListeners();
  }

  void changedLocaleEn() {
    _locale = const Locale('en');
    notifyListeners();
  }
}
