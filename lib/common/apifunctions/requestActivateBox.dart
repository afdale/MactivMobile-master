import 'dart:async';
import 'dart:convert';
import 'package:Mactiv/common/functions/saveLogout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Mactiv/common/functions/getToken.dart';

Future<Map<String,dynamic>> requestActivateBox(BuildContext context, String key) async {
  final url = "https://devmactiv.mybluemix.net/api/masjidBox/activateBox";

  final String token = await getToken();

  Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'token': token,
  };

  Map<String, String> body = {
    'key': key,
  };

  final response = await http.post(
    url,
    headers: headers,
    body: body
  );

  final responseJson = json.decode(response.body);

  if (response.statusCode==200){
    return {'status':true, 'masjidId':responseJson['masjidId']};
  }
  else{
    if (!responseJson['auth']){
      saveLogout();
      Navigator.of(context).pushNamedAndRemoveUntil('/LoginScreen', (Route<dynamic> route)=>false);
      return null;
    }
    else{
      return {'status':false, 'msg':responseJson['msg']};
    }
  }
}