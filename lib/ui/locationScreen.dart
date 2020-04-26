
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class LocationScreen extends StatefulWidget{
  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen>{
  final btnTextStyle = TextStyle(fontFamily:'Proxima_nova', fontSize: 24.0, color: Colors.white, fontWeight: FontWeight.bold);

  final globalPadding = EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 0.0);

  @override
  void initState() {  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: GradientAppBar(
        title: Text('Lokasi',style: TextStyle
          (fontFamily:'Proxima_nova', fontSize: 20.0,
            color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColorStart: new Color(0xFF00CABB),
        backgroundColorEnd: new Color (0xFF00E28C),
      ),
      backgroundColor: Colors.white,
      body: null,
    );
  }
}