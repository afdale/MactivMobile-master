import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> requestGetHijr() async {
  final now = DateTime.now();
  final date = now.day.toString() +
      '-' +
      now.month.toString() +
      '-' +
      now.year.toString();
  final url = "http://api.aladhan.com/v1/gToH?date=" + date;

  final response = await http.get(url);

  final responseJson = json.decode(response.body);
  if (response.statusCode == 200) {
    var hijr = responseJson['data']['hijri'];
    String hijrDate =
        hijr['day'] + ' ' + hijr['month']['en'] + ' ' + hijr['year'];
    return hijrDate.toString();
  }
  return '';
}
