import 'package:Mactiv/common/apifunctions/requestGetHijr.dart';
import 'package:Mactiv/common/apifunctions/requestGetJadwalSholat.dart';
import 'package:Mactiv/model/json/jadwal.dart';
import 'package:Mactiv/ui/maps.dart';
import 'package:flutter/material.dart';
import 'package:Mactiv/common/platform/platformScaffold.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _dateString;
  String _hijrDate;
  String _timeString;
  String _meridiem;
  double _latitude;
  double _longitude;
  String _location;
  Future<JadwalSholat> jadwal;

  @override
  void initState() {
    _meridiem = _getMeridiem(DateTime.now());
    _timeString = _formatTime(DateTime.now());
    _dateString = _formatDate(DateTime.now());
    _hijrDate = '';
    _latitude = 0.0;
    _longitude = 0.0;
    _location = '';

    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _updateData());
    checkGps().then((location) {
      setState(() {
        _location = location;
      });
    });

    requestGetHijr().then((hijr) {
      setState(() {
        _hijrDate = hijr;
      });
    });
    jadwal = requestGetJadwalSholat('', '');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pushReplacementNamed('/LoginScreen');
        } else {
          Navigator.of(context).pushReplacementNamed('/SplashScreen');
        }
        return false;
      },
      child: PlatformScaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            //   Padding(
            //     padding: const EdgeInsets.all(20.0),
            //     child: FlatButton(
            //       onPressed: () {
            //         getToken().then((token) {
            //           print(token);
            //         });
            //       },
            //       child: Text("text"),
            //     ),
            //   ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: _timeString,
                      style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: _meridiem,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w100)),
                      ],
                    ),
                  ),
                  new InkWell(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                        new Text(
                          _dateString,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        new Text(
                          _hijrDate,
                          style: TextStyle(
                            fontFamily: 'Proxima_nova',
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ])),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: new BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                        colors: <Color>[Color(0xFF00CDB3), Color(0xFF8BC2FF)]),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        offset: Offset(0.0, 2.5),
                        blurRadius: 3.5,
                      ),
                    ]),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            Text(
                              "NEXT PRAYER:",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 18.0,
                            ),
                            Text(
                              _location,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        FutureBuilder<JadwalSholat>(
                          future: jadwal,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return getTextWidgets(snapshot.data.prayer);
                            } else if (snapshot.hasError) {
                              //return getTextWidgets(_title);
                            }
                            return Center();
                          },
                        )
                      ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                              colors: <Color>[Colors.white, Colors.white]),
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
                              Route route = MaterialPageRoute(
                                  builder: (context) => MapsPage());
                              Navigator.push(context, route);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Row(children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: Color(0xFF00CABB),
                                  size: 18.0,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text('Lihat Lokasi',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black26,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ]),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            //   child: Row(
            //     children: <Widget>[
            //       Expanded(
            //         child: Container(
            //           height: 50.0,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(20.0),
            //               gradient: LinearGradient(
            //                   colors: <Color>[Colors.white, Colors.white]),
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: Colors.grey[300],
            //                   offset: Offset(0.0, 2.5),
            //                   blurRadius: 3.5,
            //                 ),
            //               ]),
            //           child: Material(
            //             color: Colors.transparent,
            //             child: InkWell(
            //                 onTap: () {
            //                   // pr.show();
            //                   // requestLogoutAPI().then((res) {
            //                   //   pr.dismiss();
            //                   //   if (res) {
            //                   //     Navigator.of(context)
            //                   //         .pushReplacementNamed('/LoginScreen');
            //                   //   } else {
            //                   //     // print("Logout Failed");
            //                   //     showDialogSingleButton(
            //                   //         context, "Unable to Logout", '', "OK");
            //                   //   }
            //                   // });
            //                 },
            //                 child: Padding(
            //                   padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            //                   child: Row(children: <Widget>[
            //                     Icon(
            //                       Icons.location_on,
            //                       color: Color(0xFF00CABB),
            //                       size: 18.0,
            //                     ),
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.fromLTRB(10, 0, 0, 0),
            //                       child: Text('Lihat Lokasi',
            //                           style: TextStyle(
            //                               fontSize: 20.0,
            //                               color: Colors.black26,
            //                               fontWeight: FontWeight.bold)),
            //                     ),
            //                   ]),
            //                 )),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget getTextWidgets(List<String> time) {
    var title = ["Shubuh", "Syuruq", "Dzuhur", "Ashar", "Maghrib", "Isya'"];
    var timeInSecond = [];
    var hour = 0;
    var min = 0;
    int index = 0;
    var now = new DateTime.now();
    var nowInSecond = now.hour * 3600 + now.minute * 60 + now.second;

    for (var i = 0; i < time.length; i++) {
      var newtime = checkHour(time[i]);
      hour = (int.parse(newtime[0]) * 10 + int.parse(newtime[1])) * 3600;
      min = (int.parse(newtime[3]) * 10 + int.parse(newtime[4])) * 60;
      timeInSecond.add(hour + min);
      if (hour + min > nowInSecond) {
        index = i;
        break;
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title[index],
          style: TextStyle(
            fontSize: 48.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          checkHour(time[index]),
          style: TextStyle(
            fontSize: 48.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String checkHour(time) {
    if (time.length < 5) {
      return '0' + time;
    }
    return time;
  }

  Future<String> checkGps() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (mounted) {
      setState(() {
        _longitude = position.longitude;
        _latitude = position.latitude;
      });
    }

    List<Placemark> placemark =
        await Geolocator().placemarkFromCoordinates(_latitude, _longitude);

    return placemark.first.subAdministrativeArea.toString();
  }

  void _updateData() {
    final DateTime now = DateTime.now();
    if (mounted) {
      setState(() {
        _dateString = _formatDate(now);
        _timeString = _formatTime(now);
        _meridiem = _getMeridiem(now);
      });
    }
  }

  String _formatDate(DateTime date) {
    var weekday = _formatWeekDay(date.weekday);
    var month = _formatMonth(date.month);

    return weekday + ", ${date.day} " + month + " ${date.year}";
  }

  String _formatTime(DateTime now) {
    String hour = '0';
    int jam = now.hour;
    var minute = now.minute.toString();
    if (jam > 12) {
      jam = jam - 12;
    } else if (jam == 24) {
      jam = 0;
    }

    if (jam < 10) {
      hour = '0' + jam.toString();
    } else {
      hour = jam.toString();
    }
    if (now.minute < 10) minute = '0' + now.minute.toString();

    return hour + '.' + minute;
  }

  String _getMeridiem(DateTime now) {
    var meridiem = '';
    if (now.hour > 12) {
      meridiem = 'PM';
    } else if (now.hour == 24) {
      meridiem = 'AM';
    } else {
      meridiem = 'AM';
    }

    return meridiem;
  }

  String _formatWeekDay(weekday) {
    switch (weekday) {
      case 1:
        return 'Senin';
      case 2:
        return 'Selasa';
      case 3:
        return 'Rabu';
      case 4:
        return 'Kamis';
      case 5:
        return "Jum'at";
      case 6:
        return 'Sabtu';
      case 7:
        return 'Ahad';
      default:
        break;
    }
    return '';
  }

  String _formatMonth(month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        break;
    }
    return '';
  }
}
