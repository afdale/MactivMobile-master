import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  @override
  MapsPageState createState() => MapsPageState();
}

class MapsPageState extends State<MapsPage> {
  double _latitude;
  double _longitude;
  // String _location;
  bool mapToggle = false;
  var currentLocation;
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    _latitude = 0.0;
    _longitude = 0.0;
    // _location = '';

    super.initState();

    Geolocator().getCurrentPosition().then((current) {
      setState(() {
        currentLocation = current;
        mapToggle = true;
        _latitude = current.latitude;
        _longitude = current.longitude;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);

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
            color: Colors.green, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.green, fontSize: 19.0, fontWeight: FontWeight.w600));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF00CABB),
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Lokasi Saat Ini',
                      style: TextStyle(
                          fontFamily: 'Proxima_nova',
                          fontSize: 24.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height - 80.0,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(3.595196, 98.672226), zoom: 12.0),
                      onMapCreated: _onMapCreated,
                    ))
              ],
            )
          ],
        ));
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller.complete(controller);
    });
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
}
