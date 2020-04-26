import 'dart:async';
import 'package:flutter/material.dart';
import 'package:Mactiv/common/functions/getToken.dart';

class SplashScreen extends StatelessWidget {
  final int splashDuration = 1;

  Timer startTime(BuildContext context){
    return Timer(
        Duration(seconds: splashDuration), (){
          getToken().then((token){
            if (token==''){
              Navigator.of(context).pushReplacementNamed('/LoginScreen');
            }
            else {
              Navigator.of(context).pushReplacementNamed('/MainPages');
            }
          });
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    startTime(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF00CABB),
                gradient: LinearGradient(
                  colors: [Color(0xFF00CABB), Color (0xFF00E28C)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
              )
            )
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: GestureDetector(
                  child: Container(
                    height: 120,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image:AssetImage("assets/splashscreen.png"),
                          fit:BoxFit.fill
                      ),
                    )
                  ),
                )
              ),
            ],
          )
        ]
      )
    );
  }
}