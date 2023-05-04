import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class DataSaver {
  Future<bool> saveUserData(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("user", jsonEncode(user.toJson()));

    return true;
  }

  Future<User?> loadUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? u = sharedPreferences.getString("user");

    if (u == null) {
      return null;
    } else {
      User user = User.fromJson(jsonDecode(u));
      return user;
    }
  }
}