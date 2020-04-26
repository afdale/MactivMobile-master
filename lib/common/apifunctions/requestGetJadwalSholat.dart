import 'dart:async';

import 'package:Mactiv/model/json/jadwal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//TODO: jadwal sholat api for locationn
Future<JadwalSholat> requestGetJadwalSholat(
    String serialNumber, String date) async {
  final url = "https://devmactiv.mybluemix.net/api/user/getPrayerTime";

  var serial = 'CSyn5tSKH5HMLH8bQ0FS';

  Map<String, String> body = {
    'serialNumber': serial,
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
  print(responseJson);

  if (response.statusCode == 200) {
    return JadwalSholat.fromJson(responseJson);
  }
  return null;
}
