import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:Mactiv/common/apifunctions/requestLoginAPI.dart';
import 'package:Mactiv/Widgets/showDialogSingleButton.dart';

class LoginScreen extends StatefulWidget {

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final globalPadding = EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 0.0);

  ProgressDialog pr;

  @override
  void initState() {
    super.initState();
    
    pr = ProgressDialog(context,type:ProgressDialogType.Normal, isDismissible: false, showLogs: false);

    pr.style(
      message: 'Login',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
        color: Colors.green, fontFamily:'Proxima_nova', fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
        color: Colors.green, fontFamily:'Proxima_nova', fontSize: 19.0, fontWeight: FontWeight.w600)
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                padding: globalPadding,
                height: 70,
                child: FittedBox(
                  child: Image.asset("assets/icon_mactiv.png"),
                  fit: BoxFit.fill,
                )),
            Container(
              padding: globalPadding,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Selamat datang di',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w200)),
                    TextSpan(
                        text: ' MactivBox, ',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: 'Silahkan Login',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w200)),
                  ],
                ),
              ),
            ),
            Container(
              padding: globalPadding,
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                ),
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: globalPadding,
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: globalPadding,
              child: Text(
                "Lupa Password?",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.green,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            Container(
              padding: globalPadding,
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    gradient: LinearGradient(
                        colors: <Color>[Color(0xFF00CABB), Color(0xFF00E28C)]),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        offset: Offset(0.0, 2.5),
                        blurRadius: 30.5,
                      ),
                    ]),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        pr.show();
                        requestLoginAPI(
                                _emailController.text, _passwordController.text)
                            .then((res) {
                          pr.dismiss();
                          if (res['status']) {
                            Navigator.of(context)
                                .pushReplacementNamed('/MainPages');
                          } else {
                            showDialogSingleButton(
                                context, "Unable to Login", res['msg'], "OK");
                          }
                        });
                      },
                      child: Center(
                        child: Text('Login',
                            style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      )),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: globalPadding,
              child: Text(
                "Login menggunakan",
                style: TextStyle(
                  fontFamily: 'Proxima_nova',
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            Container(
              padding: globalPadding,
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: GestureDetector(
                          child: Image.asset("assets/btn_googlelogin.png"),
                          onTap: () {
                            print("google");
                          })),
                  Expanded(
                      child: GestureDetector(
                          child: Image.asset("assets/btn_fblogin.png"),
                          onTap: () {
                            print("fb");
                          })),
                ],
              ),
            ),
            Container(
              padding: globalPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Belum punya akun? ",
                    style: TextStyle(
                      fontFamily: 'Proxima_nova',
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/SignUpScreen');
                    },
                    child: Text(
                      "Daftar",
                      style: TextStyle(
                        fontFamily: 'Proxima_nova',
                        fontSize: 18.0,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
