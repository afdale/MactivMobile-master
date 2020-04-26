import 'package:Mactiv/common/apifunctions/requestMasjid.dart';
import 'package:Mactiv/common/functions/getMasjid.dart';
import 'package:Mactiv/model/json/masjid.dart';
import 'package:Mactiv/ui/masjidScreen.dart';
import 'package:flutter/material.dart';

class MactivBoxPage extends StatefulWidget{
  @override
  MactivBoxPageState createState() => MactivBoxPageState();
}

class MactivBoxPageState extends State<MactivBoxPage>{
  final globalPadding = EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 0.0);

  var masjid = List<Masjid>();

  ListTile listItem(BuildContext context, int index){
    return ListTile(
      title: Text('${masjid[index].name}'),
      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MasjidScreen(masjid:masjid[index],))),
    );
  }

  @override
  void initState() {
    super.initState();
    getMasjid().then((savedMasjid){
      if (savedMasjid.length>0){
        setState(() {
          masjid.addAll(savedMasjid);
        });
      }
      requestMasjid(context).then((res){
        if (res['status']){
          setState(() {
            masjid.clear();
            masjid.addAll(res['masjid']);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: globalPadding,
          child: Text('Mactivbox',
            style: TextStyle(
              fontFamily: 'Proxima_nova',
              fontSize: 24.0,
              color: Colors.black,
              fontWeight: FontWeight.bold
            )
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: masjid.length,
            itemBuilder: (context,index)=>listItem(context,index),
          ),
        ),
      ],
    );
  }
}
