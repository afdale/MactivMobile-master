
import 'package:Mactiv/model/json/masjid.dart';
import 'package:Mactiv/ui/updateMasjidSreen.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class MasjidScreen extends StatefulWidget{
  MasjidScreen({Key key,@required this.masjid}): super(key:key);
  final Masjid masjid;

  @override
  MasjidScreenState createState() => MasjidScreenState();
}

class MasjidScreenState extends State<MasjidScreen>{
  final textStyle = TextStyle(fontFamily:'Proxima_nova',fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w100, );
  final globalPadding = EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 0.0);

  Container field(String title, dynamic text){
    text ??= '';
    return Container(
      alignment: Alignment.centerLeft,
      padding: globalPadding,
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          children:[
            TextSpan(text: '$title: $text', style: textStyle),
          ],
        ),
      ),
    ); 
  }

  @override
  void initState() {  
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: GradientAppBar(
        title: Text('${widget.masjid.masjidType==1?"Majid":"Mushola"} ${widget.masjid.name}',style: TextStyle
          (fontFamily:'Proxima_nova', fontSize: 20.0,
            color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColorStart: Color(0xFF00CABB),
        backgroundColorEnd: Color (0xFF00E28C),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          field('Nomor Telepon',widget.masjid.phone),
          field('Alamat',widget.masjid.address),
          field('Lokasi',''),
          field('Latitude',widget.masjid.latitude),
          field('Longitude',widget.masjid.longitude),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UpdateMasjidScreen(masjid:widget.masjid,))),
        child: Icon(Icons.edit),
        backgroundColor: Color(0xFF00E28C),
      ),
    );
  }
}