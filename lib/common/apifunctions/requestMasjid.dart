import 'dart:async';
import 'dart:convert';
import 'package:Mactiv/common/functions/saveLogout.dart';
import 'package:Mactiv/common/functions/saveMasjid.dart';
import 'package:Mactiv/model/json/masjid.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Mactiv/common/functions/getToken.dart';

Future<Map<String,dynamic>> requestMasjid(BuildContext context) async {
  final url = "https://devmactiv.mybluemix.net/api/masjid/getByAdmin";

  final String token = await getToken();

  Map<String, String> headers = {
    'token': token,
  };

  final response = await http.get(
    url,
    headers: headers
  );

  final responseJson = json.decode(response.body);

  if (response.statusCode==200){
    List<dynamic> masjidJson = responseJson['masjid'];
    var masjid = List<Masjid>();
    masjidJson.forEach((f){
      masjid.add(Masjid.fromJson(f));
    });
    saveMasjid(masjid);
    return {'status':true, 'masjid':masjid};
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