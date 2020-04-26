import 'package:Mactiv/ui/activateBoxScreen.dart';
import 'package:Mactiv/ui/locationScreen.dart';
import 'package:Mactiv/ui/masjidScreen.dart';
import 'package:Mactiv/ui/updateMasjidSreen.dart';
import 'package:flutter/material.dart';
import 'package:Mactiv/ui/loginScreen.dart';
import 'package:Mactiv/ui/signupScreen.dart';
import 'package:Mactiv/ui/splashScreen.dart';
import 'package:Mactiv/ui/mainPages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Mactiv App",
        theme:
            ThemeData(primarySwatch: Colors.teal, fontFamily: 'Proxima_nova'),
        routes: <String, WidgetBuilder>{
        "/MainPages": (BuildContext context) => MainPages(),
        "/LoginScreen": (BuildContext context) => LoginScreen(),
        "/SignUpScreen": (BuildContext context) => SignUpScreen(),
        "/SplashScreen": (BuildContext context) => SplashScreen(),
        "/ActivateBoxScreen": (BuildContext context) => ActivateBoxScreen(),
        "/UpdateMasjidScreen": (BuildContext context) => UpdateMasjidScreen(masjid: null,),
        "/MasjidScreen": (BuildContext context) => MasjidScreen(masjid: null,),
        "/LocationScreen": (BuildContext context) => LocationScreen(),
      },
      home: MainPages()
    );
  }
}
