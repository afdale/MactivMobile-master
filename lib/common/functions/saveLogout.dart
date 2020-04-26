
import 'package:shared_preferences/shared_preferences.dart';

void saveLogout() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  preferences.clear();
}

