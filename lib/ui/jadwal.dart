import 'package:Mactiv/common/apifunctions/requestGetJadwalSholat.dart';
import 'package:Mactiv/model/json/jadwal.dart';
import 'package:flutter/material.dart';
import 'package:Mactiv/common/platform/platformScaffold.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

class JadwalSholatPage extends StatefulWidget {
  @override
  _JadwalSholatPageState createState() => _JadwalSholatPageState();
}

class _JadwalSholatPageState extends State<JadwalSholatPage> {
  Future<JadwalSholat> jadwal;
  List<String> _title;
  String _location;
  double _latitude;
  double _longitude;

  @override
  void initState() {
    _title = ["Shubuh", "Syuruq", "Dzuhur", "Ashar", "Maghrib", "Isya'"];
    _location = '';
    checkGps().then((location) {
      setState(() {
        _location = location;
      });
    });

    super.initState();
    jadwal = requestGetJadwalSholat('', '');
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: Colors.white,
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('Jadwal Sholat',
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.location_on,
                color: Colors.black,
                size: 18.0,
              ),
              Text(
                _location,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: FutureBuilder<JadwalSholat>(
              future: jadwal,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return getTextWidgets(snapshot.data.prayer);
                } else if (snapshot.hasError) {
                  return getTextWidgets(_title);
                }
                return Center(child: CircularProgressIndicator());
              },
            ))
      ]),
    );
  }

  Future<String> checkGps() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _longitude = position.longitude;
      _latitude = position.latitude;
    });

    List<Placemark> placemark =
        await Geolocator().placemarkFromCoordinates(_latitude, _longitude);

    return placemark.first.subAdministrativeArea.toString();
  }

  String checkHour(time) {
    if (time.length < 5) {
      return '0' + time;
    }
    return time;
  }

  Widget getTextWidgets(List<String> time) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < _title.length; i++) {
      list.add(Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _title[i],
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
            ),
            Text(
              checkHour(time[i]),
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ));
    }
    return new Column(children: list);
  }
}
