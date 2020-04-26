import 'package:Mactiv/ui/home.dart';
// import 'package:Mactiv/ui/keuangan.dart';
import 'package:Mactiv/ui/mactivBox.dart';
import 'package:Mactiv/ui/jadwal.dart';
import 'package:Mactiv/ui/profile.dart';

import 'package:flutter/material.dart';

class MainPages extends StatefulWidget {
  MainPages({Key key,this.index}) : super(key: key);
  final int index;

  @override
  MainPagesState createState() => MainPagesState();
}

class MainPagesState extends State<MainPages> {
  final _pageOptions = [
    HomePage(),
    JadwalSholatPage(),
    // KeuanganPage(),
    MactivBoxPage(),
    ProfilePage(),
  ];

  
  bool isVis = false;

  int _selectedPage;

  @override
  void initState() {
    _selectedPage = widget.index ?? 0;
    isVis = widget.index == 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/icon_mactiv.png"),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              // Expanded(
              //   child: Column(
              //     children: <Widget>[
              //       Text('Mactiv',
              //           style: TextStyle(
              //               fontFamily: 'Proxima_nova',
              //               fontSize: 30.0,
              //               color: Color(0xFF00CABB),
              //               fontWeight: FontWeight.bold)),
              //     ],
              //     mainAxisAlignment: MainAxisAlignment.center,
              //   ),
              // ),
              // Icon(Icons.settings, color: Color(0xFF00CABB)),
            ],
          ),
        ),
      ),
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
            isVis = index == 2;
          });
        },
        backgroundColor: Colors.white,
        elevation: 100.0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Color(0xFF00CABB)),
              title: Text('Home',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFF00CABB),
                      fontWeight: FontWeight.bold))),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time, color: Color(0xFF00CABB)),
              title: Text('Jadwal Sholat',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFF00CABB),
                      fontWeight: FontWeight.bold))),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.attach_money, color: Color(0xFF00CABB)),
          //     title: Text('Keuangan',
          //         style: TextStyle(
          //             fontSize: 15.0,
          //             color: Color(0xFF00CABB),
          //             fontWeight: FontWeight.bold))),
          BottomNavigationBarItem(
              icon: Icon(Icons.phonelink, color: Color(0xFF00CABB)),
              title: Text('MactivBox',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFF00CABB),
                      fontWeight: FontWeight.bold))),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: Color(0xFF00CABB)),
              title: Text('Profile',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFF00CABB),
                      fontWeight: FontWeight.bold))),
        ],
      ),
      floatingActionButton: Visibility(
        visible: isVis,
        child: FloatingActionButton(
          onPressed: ()=>Navigator.of(context).pushNamed('/ActivateBoxScreen'),
          child: Icon(Icons.add),
          backgroundColor: Color(0xFF00E28C),
        ),
      ),
    );
  }
}
