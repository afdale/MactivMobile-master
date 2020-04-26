import 'package:shared_preferences/shared_preferences.dart';
import 'package:Mactiv/model/json/user.dart';
import 'dart:convert';

void saveCurrentLogin(User user, String token) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  preferences.setString('userData', json.encode(user.toJson()));
  preferences.setString('token', token);
}