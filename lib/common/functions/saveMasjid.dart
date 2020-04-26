import 'dart:convert';

import 'package:Mactiv/model/json/masjid.dart';
import 'package:shared_preferences/shared_preferences.dart';

void saveMasjid(List<Masjid> masjid) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  List<String> masjidStrings = List<String>();
  masjid.forEach((f){
    masjidStrings.add(json.encode(f.toJson()));
  });

  preferences.setStringList('masjidData', masjidStrings);
}