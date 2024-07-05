import 'dart:convert';

import 'package:make_appointment_app/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final _tokenKey = 'token';
  final _userKey = 'user';
  final _localeKey = 'locale';
  final SharedPreferences sharedPreferences;

  SharedPreferencesService({
    required this.sharedPreferences,
  });

  void setToken(String token) async {
    await sharedPreferences.setString(_tokenKey, token);
  }

  String getToken() {
    return sharedPreferences.getString(_tokenKey) ?? '';
  }

  void removeToken() async {
    await sharedPreferences.remove(_tokenKey);
  }

  Future<void> setUser(User user) async {
    await sharedPreferences.setString(_userKey, jsonEncode(user.toJson()));
  }

  User? getUser() {
    final userData = sharedPreferences.getString(_userKey);
    if ((userData ?? '').isEmpty) return null;
    return User.fromJson(jsonDecode(userData!));
  }

  void removeUser() async {
    await sharedPreferences.remove(_userKey);
  }

  Future<void> setLocale(String locate) async {
    await sharedPreferences.setString(_localeKey, locate);
  }

  String getLocale() {
    return sharedPreferences.getString(_localeKey) ?? 'en';
  }
}
