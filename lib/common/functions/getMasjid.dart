import 'dart:async';
import 'dart:convert';

import 'package:Mactiv/model/json/masjid.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Masjid>> getMasjid() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  List<String> masjidStrings = preferences.getStringList('masjidData');
  List<Masjid> masjid = List<Masjid>();
  if (masjidStrings != null){
    masjidStrings.forEach((f){
      masjid.add(Masjid.fromJson(json.decode(f)));
    });
  }

  return masjid;
}