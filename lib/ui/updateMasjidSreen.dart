import 'package:Mactiv/Widgets/showDialogSingleButton.dart';
import 'package:Mactiv/Widgets/showDialogSingleButtonWithAction.dart';
import 'package:Mactiv/common/apifunctions/requestUpdateMasjid.dart';
import 'package:Mactiv/model/json/masjid.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:location/location.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'mainPages.dart';

class UpdateMasjidScreen extends StatefulWidget{
  UpdateMasjidScreen({Key key, @required this.masjid}) : super(key: key);
  final Masjid masjid;

  @override
  UpdateMasjidScreenState createState() => UpdateMasjidScreenState();
}

class UpdateMasjidScreenState extends State<UpdateMasjidScreen>{
  final TextEditingController _nameController = TextEditingController();
  String _tipeController;
  String _lokasiController = 'Lokasi saat ini';
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final btnTextStyle = TextStyle(fontFamily:'Proxima_nova', fontSize: 24.0, color: Colors.white, fontWeight: FontWeight.bold);

  final globalPadding = EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 0.0);
  ProgressDialog pr;

  Container formField(TextEditingController controller, String hintText){
    return Container(
      alignment: Alignment.centerLeft,
      padding: globalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children :[
          Text(hintText,style: TextStyle(fontFamily:'Proxima_nova',fontSize: 20.0,
              color: Colors.black, fontWeight: FontWeight.w200),),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
            ),
            style: TextStyle(fontFamily:'Proxima_nova', fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.bold, ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    pr = ProgressDialog(context,type:ProgressDialogType.Normal, isDismissible: false, showLogs: false);

    pr.style(
      message: 'Memperbarui data masjid',
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

    _nameController.text = widget.masjid.name ?? '';
    _phoneController.text = widget.masjid.phone ?? '';
    _addressController.text = widget.masjid.address ?? '';
    _tipeController = widget.masjid.masjidType==null?'Masjid':(widget.masjid.masjidType==1?'Masjid':'Mushola');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: GradientAppBar(
        title: Text('Data masjid',style: TextStyle
          (fontFamily:'Proxima_nova', fontSize: 30.0,
            color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColorStart: new Color(0xFF00CABB),
        backgroundColorEnd: new Color (0xFF00E28C),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [

          Container(
            padding: globalPadding,
            child: RichText(
              text: TextSpan(
                children:[
                  TextSpan(text: 'Masukkan data masjid', style: TextStyle(fontFamily:'Proxima_nova',fontSize: 20.0,
                    color: Colors.black, fontWeight: FontWeight.w200)),
                ],
              ),
            ),
          ),

          formField(_nameController, 'Nama Masjid'),
          Container(
            alignment: Alignment.centerLeft,
            padding: globalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children :[
                Text('Masjid/Mushola',style: TextStyle(fontFamily:'Proxima_nova',fontSize: 20.0,
                    color: Colors.black, fontWeight: FontWeight.w200),),
                DropdownButton(
                  items: ['Masjid','Mushola'].map((type)=>DropdownMenuItem(value: type, child: Text(type),)).toList(),
                  value: _tipeController,
                  onChanged: (value){setState(() {
                    _tipeController = value; 
                  });},
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: globalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children :[
                Text('Lokasi',style: TextStyle(fontFamily:'Proxima_nova',fontSize: 20.0,
                    color: Colors.black, fontWeight: FontWeight.w200),),
                DropdownButton(
                  items: ['Lokasi saat ini','Pilih dari maps'].map((type)=>DropdownMenuItem(value: type, child: Text(type),)).toList(),
                  value: _lokasiController,
                  onChanged: (value){setState(() {
                    _lokasiController = value; 
                  });},
                ),
              ],
            ),
          ),
          formField(_phoneController, 'Nomor Telepon'),
          formField(_addressController, 'Alamat'),


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
                  onTap: ()async{
                    pr.show();
                    var location = Location();
                    if (!await location.serviceEnabled()) if (!await location.requestService()){
                      pr.dismiss();
                      showDialogSingleButton(context, "Unable to get location", 'Please allow location','Ok');
                    }
                    else{
                      try {
                        LocationData current = await location.getLocation();
                        var masjid = Masjid(
                          masjidId: widget.masjid.masjidId,
                          name: _nameController.text,
                          masjidType: _tipeController == 'Masjid'?1:2,
                          phone: _phoneController.text,
                          address: _addressController.text,
                          longitude: current.longitude,
                          latitude: current.latitude
                        );
                        requestUpdateMasjid(context, masjid).then((res){
                          pr.dismiss();
                          if (res['status']){
                            showDialogSingleButtonWithAction(context, 'Berhasil disimpan', 'Data masjid berhasil disimpan', 'OK', (){
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MainPages(index:2)), (Route<dynamic> route)=>false);
                            });
                          }
                          else{
                            showDialogSingleButton(context, "Unable to save", res['msg'], "OK");
                          }
                        });
                      } catch (e){
                        pr.dismiss();
                        showDialogSingleButton(context, "Unable to get location", '${e.code}','Ok');
                      }
                    }
                  },
                  child: Center(
                    child: Text('Simpan', style: btnTextStyle,),
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