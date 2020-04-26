import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String,dynamic>> requestRegisterAPI(String fullname, String email, String password) async {
  final url = "https://devmactiv.mybluemix.net/api/user/register";

  Map<String, String> body = {
    'name': fullname,
    'email': email,
    'password': password,
  };

  Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  final response = await http.post(
    url,
    headers: headers,
    body: body,
  );

  final responseJson = json.decode(response.body);

  if (response.statusCode == 201) {

    return {'status':true};

  } else {
    //showDialogSingleButton(context, "Unable to Register", responseJson['msg'], "OK");
    //showDialogSingleButton(context, "Unable to Login", "You may have supplied an invalid 'Username' /
    // 'Password' combination. Please try again or contact your support representative.", "OK");
    return {'status':false, 'msg':responseJson['msg']};
  }
}

