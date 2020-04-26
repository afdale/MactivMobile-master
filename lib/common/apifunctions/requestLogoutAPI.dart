import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:Mactiv/common/functions/getToken.dart';
import 'package:Mactiv/common/functions/saveLogout.dart';

Future<Map<String,dynamic>>  requestLogoutAPI() async {
  final url = "https://devmactiv.mybluemix.net/api/user/logout";

  final String token = await getToken();

  Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'token': token,
  };

  final response = await http.get(
    url,
    headers: headers,
  );

  final responseJson = json.decode(response.body);

    //if logout success or token already xpired somehow
  if (response.statusCode == 200 || !responseJson['auth']) {
    saveLogout();
    return {'status':true};
  } else {
    return {'status':false, 'msg':responseJson['msg']};
  }
}
