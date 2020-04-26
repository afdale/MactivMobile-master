import 'package:Mactiv/common/functions/getUser.dart';
import 'package:flutter/material.dart';
import 'package:Mactiv/common/apifunctions/requestLogoutAPI.dart';
import 'package:Mactiv/model/json/user.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:Mactiv/Widgets/showDialogSingleButton.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final globalPadding = EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 0.0);
  final textStyle = TextStyle(fontFamily:'Proxima_nova',fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w100, );

  ProgressDialog pr;

  User user = User(email: '',name: ''); 

  @override
  void initState(){
    super.initState();

    pr = ProgressDialog(context,type:ProgressDialogType.Normal, isDismissible: false, showLogs: false);

    pr.style(
      message: 'Logout',
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

    getUser().then((res){
        setState(() {
          user = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: globalPadding,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Profile',
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Spacer(
                flex: 1,
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        user.name,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        '\t\t :  ',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        user.email,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(
                flex: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          gradient: LinearGradient(colors: <Color>[
                            Color(0xFF00CABB),
                            Color(0xFF00E28C)
                          ]),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300],
                              offset: Offset(0.0, 2.5),
                              blurRadius: 3.5,
                            ),
                          ]),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {
                              pr.show();
                              requestLogoutAPI().then((res){
                                pr.dismiss();
                                //TODO: confirmation
                                if (res['status']){
                                  Navigator.of(context).pushReplacementNamed('/LoginScreen');
                                }
                                else{
                                  showDialogSingleButton(context, "Unable to Logout", res['msg'], "OK");
                                }
                              });
                            },
                            child: Center(
                              child: Text('Logout',
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
