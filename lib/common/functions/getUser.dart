import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:Mactiv/model/json/user.dart';
import 'dart:convert';

Future<User> getUser() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  String userData = preferences.getString("userData");
  User user = User.fromJson(json.decode(userData));
  return user;
}
