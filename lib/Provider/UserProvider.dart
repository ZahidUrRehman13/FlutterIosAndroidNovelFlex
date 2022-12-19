import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  late SharedPreferences _sharedPreferences;

  UserProvider(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
  }


  String? get UserEmail => _sharedPreferences.getString("emailu");
  String? get SelectedLanguage =>
      _sharedPreferences.getString("lngu");

  String? get UserName => _sharedPreferences.getString("nameu");

  String? get UserToken => _sharedPreferences.getString("tok");

  String? get UserImage => _sharedPreferences.getString("img");

  String? get UserID => _sharedPreferences.getString("user_id");

  void setUserEmail(String email) async {
    _sharedPreferences.setString("emailu", email);
    notifyListeners();
  }

  void setLanguage(String lang) async {
    _sharedPreferences.setString("lngu", lang);
    notifyListeners();
  }

  void setUserName(String name) async {
    _sharedPreferences.setString("nameu", name);
    notifyListeners();
  }

  void setUserToken(String token) async {
    _sharedPreferences.setString("tok", token);
    notifyListeners();
  }

  void setUserImage(String token) async {
    _sharedPreferences.setString("img", token);
    notifyListeners();
  }

  void setUserID(String id) async {
    _sharedPreferences.setString("user_id", id);
    notifyListeners();
  }
}
