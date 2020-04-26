import 'package:Mactiv/Widgets/showDialogSingleButton.dart';
import 'package:Mactiv/Widgets/showDialogSingleButtonWithAction.dart';
import 'package:Mactiv/common/apifunctions/requestActivateBox.dart';
import 'package:Mactiv/model/json/masjid.dart';
import 'package:Mactiv/ui/updateMasjidSreen.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ActivateBoxScreen extends StatefulWidget{
  @override
  ActivateBoxScreenState createState() => ActivateBoxScreenState();
}

class ActivateBoxScreenState extends State<ActivateBoxScreen>{
  final TextEditingController _keyController = TextEditingController();
  final btnTextStyle = TextStyle(fontFamily:'Proxima_nova', fontSize: 24.0, color: Colors.white, fontWeight: FontWeight.bold);

  final globalPadding = EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 0.0);
  ProgressDialog pr;

  @override
  void initState() {  
    super.initState();
    pr = ProgressDialog(context,type:ProgressDialogType.Normal, isDismissible: false, showLogs: false);

    pr.style(
      message: 'Mengaktifkan',
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
      appBar: GradientAppBar(
        title: Text('Aktifkan Masjid Box',style: TextStyle
          (fontFamily:'Proxima_nova', fontSize: 20.0,
            color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColorStart: new Color(0xFF00CABB),
        backgroundColorEnd: new Color (0xFF00E28C),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: globalPadding,
            child: RichText(
              text: TextSpan(
                children:[
                  TextSpan(text: 'Masukkan kode aktivasi', style: TextStyle(fontFamily:'Proxima_nova',fontSize: 20.0,
                    color: Colors.black, fontWeight: FontWeight.w200)),
                ],
              ),
            ),
          ),

          Container(
            padding: globalPadding,
            child: TextField(
              controller: _keyController,
              decoration: InputDecoration(
                hintText: "Kode Aktivasi",
              ),
              style: TextStyle(fontFamily:'Proxima_nova', fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.bold, ),
            ),
          ),

          Container(
            padding: globalPadding,
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                gradient: LinearGradient(
                  colors: [Color(0xFF00CABB),Color(0xFF00E28C)]
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300],
                    offset: Offset(0.0, 2.5),
                    blurRadius: 30.5,
                  ),
                ]
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: (){
                    pr.show();
                    requestActivateBox(context, _keyController.text).then((res){
                      pr.dismiss();
                      if (res['status']){
                        showDialogSingleButtonWithAction(context, 'Aktivasi berhasil', 'Silahkan lanjutkan dengan melengkapi informasi masjid', 'OK', (){
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>UpdateMasjidScreen(masjid:Masjid(masjidId:res['masjidId']),)), (Route<dynamic> route)=>false);
                        });
                      }
                      else{
                        showDialogSingleButton(context, "Unable to Activate", res['msg'], "OK");
                      }
                    });
                  },
                  child: Center(
                    child: Text('Aktifkan', style: btnTextStyle,),
                  )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}