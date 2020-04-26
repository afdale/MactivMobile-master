import 'dart:async' show Future;

import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  String getToken = preferences.getString("token");
  getToken ??= '';
  return getToken;
}
