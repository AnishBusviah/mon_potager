import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mon_potager/search.dart';
import 'package:mon_potager/ui/reminder_screen.dart';
import 'package:mon_potager/widgets/WeatherWidget2.dart';
import 'package:mon_potager/widgets/WhatCanIGrow.dart';
import 'dart:ui';

import 'Screens/ForYou.dart';
import 'Screens/GardenScreen.dart';
import 'Screens/Recommendations.dart';
import 'Screens/logInScreen.dart';
import 'WeatherWidget.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mon_potager/utils.dart';
import './utils.dart';
import 'Navigation.dart';
import 'bottomNavBar.dart';
import 'models/Colours.dart';
import 'models/DrawerWidget.dart';

class Scene extends StatefulWidget {
  @override
  State<Scene> createState() => _SceneState();
}

class _SceneState extends State<Scene> {
  int _currentScreen = 0;
  Color _unselected = iconColour2;
  Color _selected = Color.fromRGBO(212, 233, 214, 1);

  // Color.fromRGBO(64, 97, 80, 1);
  List<Color> _icon = [
    iconColour2,
    iconColour2,
    iconColour2,
    iconColour2,
  ];

  static List<Widget> _screenOptions = <Widget>[
    Home(),
    ForYou(),
    // MyGarden(),
    ReminderScreen(),
    logInScreen(),
  ];

  void _changeScreen(int index) {
    setState(() {
      _currentScreen = index;
      _icon = [_unselected, _unselected, _unselected, _unselected];
      _icon[index] = _selected;
    });
  }

  @override
  void initState() {
    _icon[0] = _selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    Color fabColor = Color.fromRGBO(183, 204, 173, 1);
    Color bottomNavColor = Color.fromRGBO(255, 255, 255, 1);

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: _currentScreen == 0
          ? AppBar(
              iconTheme: IconThemeData(
                  color: Colors.black, size: 32, opticalSize: 100),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: Search());
                  },
                  icon: Icon(
                    CupertinoIcons.search,
                  ),
                ),
              ],

              // leading: Icon(
              //   opticalSize: 15,
              //   weight: 100,
              //   Icons.menu,
              //   size: 32,
              //   color: Colors.black,
              // ),
            )
          : null,

      drawer: DrawerWidget(),

      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(260),
      //   child: Stack(
      //     children: [
      //       AppBar(
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.only(
      //             bottomLeft: Radius.circular(50),
      //             bottomRight: Radius.circular(50),
      //           ),
      //         ),
      //         elevation: 5,
      //         backgroundColor: Colors.transparent,
      //         flexibleSpace: Container(
      //           height: 300,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(50),
      //             image: DecorationImage(
      //               opacity: 0.6,
      //               image: AssetImage('assets/appBar_Image.jpg'),
      //               fit: BoxFit.fill,
      //             ),
      //           ),
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.only(top: 260),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             InkWell(
      //
      //               child: IconButton(
      //                 onPressed: () {},
      //                 icon: Icon(Icons.thumb_up_alt_outlined),
      //               ),
      //             ),
      //             Container(
      //               color: Colors.green,
      //               child: IconButton(
      //                 onPressed: () {},
      //                 icon: Icon(Icons.thumb_up_alt_outlined),
      //               ),
      //             ),
      //             Container(
      //               color: Colors.green,
      //               child: IconButton(
      //                 onPressed: () {},
      //                 icon: Icon(Icons.thumb_up_alt_outlined),
      //               ),
      //             ),
      //             Container(
      //               color: Colors.green,
      //               child: IconButton(
      //                 onPressed: () {},
      //                 icon: Icon(Icons.thumb_up_alt_outlined),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: _screenOptions[_currentScreen],
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     CupertinoIcons.plus,
      //     color: Colors.black,
      //     size: 40,
      //   ),
      //   backgroundColor: fabColor,
      //   onPressed: () {},
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color.fromRGBO(129, 164, 131, 1),
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        height: 60,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                  // color: Colors.blue,
                  minWidth: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: _icon[0],
                      ),
                      Text(
                        "Home",
                        style: TextStyle(color: _icon[0]),
                      )
                    ],
                  ),
                  onPressed: () {
                    setState(
                      () {
                        _changeScreen(0);
                      },
                    );
                  }),
              // MaterialButton(
              //   minWidth: 10,
              //   // color: Colors.green,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [Icon(CupertinoIcons.search), Text("Search")],
              //   ),
              //   onPressed: () {
              //     showSearch(context: context, delegate: Search());
              //   },
              // ),
              MaterialButton(
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ImageIcon(
                    //   AssetImage('assets/icons/icons8-garden-50.png'),
                    //   color: _icon[1],
                    // ),
                    Icon(
                      Icons.lightbulb,
                      color: _icon[1],
                    ),
                    Text(
                      "Tips",
                      style: TextStyle(color: _icon[1]),
                    )
                  ],
                ),
                onPressed: () {
                  setState(
                    () {
                      _changeScreen(1);
                    },
                  );
                },
              ),
              MaterialButton(
                minWidth: 10,
                // color: Colors.yellowAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                        AssetImage('assets/icons/icons8-reminders-50.png'),
                        color: _icon[2]),
                    Text(
                      "Tasks",
                      style: TextStyle(color: _icon[2]),
                    )
                  ],
                ),
                onPressed: () {
                  setState(
                    () {
                      _changeScreen(2);
                    },
                  );
                },
              ),
              // MaterialButton(
              //   // color: Colors.blue,
              //   minWidth: 10,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Icon(
              //         Icons.person,
              //         color: _icon[3],
              //       ),
              //       Text("Profile")
              //     ],
              //   ),
              //   onPressed: () {
              //     setState(
              //       () {
              //         _changeScreen(3);
              //       },
              //     );
              //   },
              // ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: <Widget>[
          //     MaterialButton(
          //       minWidth: 10,
          //       onPressed: () {},
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(
          //             Icons.home,
          //             color: _icon[0],
          //           ),
          //           Text(
          //             "Home",
          //             style: TextStyle(color: _icon[0]),
          //           )
          //         ],
          //       ),
          //     ),
          //     MaterialButton(
          //       minWidth: 20,
          //       onPressed: () {},
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           ImageIcon(
          //             AssetImage('assets/icons/icons8-garden-50.png'),
          //             color: _icon[1],
          //           ),
          //           Text("My Garden",
          //               style: TextStyle(
          //                 color: _icon[1],
          //               )),
          //         ],
          //       ),
          //     ),
          //     MaterialButton(
          //       minWidth: 20,
          //       onPressed: () {},
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(
          //             Icons.search,
          //             color: _icon[1],
          //           ),
          //           Text(
          //             "Search",
          //             style: TextStyle(color: _icon[1]),
          //           )
          //         ],
          //       ),
          //     ),
          //     MaterialButton(
          //       minWidth: 20,
          //       onPressed: () {},
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           ImageIcon(
          //               AssetImage('assets/icons/icons8-reminders-50.png'),
          //               color: _icon[1]),
          //           Text("Reminders",
          //               style: TextStyle(
          //                 color: _icon[1],
          //               )),
          //         ],
          //       ),
          //     ),
          //     MaterialButton(
          //       minWidth: 25,
          //       onPressed: () {},
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(
          //             Icons.person,
          //             color: _icon[2],
          //           ),
          //           Text(
          //             "Profile",
          //             style: TextStyle(
          //               color: _icon[2],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     // Row(
          //     //   mainAxisAlignment: MainAxisAlignment.center,
          //     //   children: <Widget>[
          //     //     MaterialButton(
          //     //       minWidth: 60,
          //     //       onPressed: () {
          //     //         setState(() {
          //     //           _changeScreen(0);
          //     //         });
          //     //       },
          //     //       child: Column(
          //     //         mainAxisAlignment: MainAxisAlignment.center,
          //     //         children: <Widget>[
          //     //           Icon(Icons.home, color: _icon[0]),
          //     //           Text("Home", style: TextStyle(color: _icon[0])),
          //     //         ],
          //     //       ),
          //     //     ),
          //     //     MaterialButton(
          //     //       minWidth: 40,
          //     //       onPressed: () {
          //     //         setState(() {
          //     //           _changeScreen(1);
          //     //         });
          //     //       },
          //     //       child: Column(
          //     //         mainAxisAlignment: MainAxisAlignment.center,
          //     //         children: <Widget>[
          //     //           ImageIcon(
          //     //             AssetImage('assets/icons/icons8-garden-50.png'),
          //     //           color: _icon[1],),
          //     //           Text("My Garden", style: TextStyle(color: _icon[1],)),
          //     //         ],
          //     //       ),
          //     //     ),
          //     //   ],
          //     // ),
          //     // Column(
          //     //   mainAxisAlignment: MainAxisAlignment.center,
          //     //   children: <Widget>[
          //     //     Icon(Icons.search, color: _icon[1],),
          //     //     Text("Search", style: TextStyle(color: _icon[1]),)
          //     //   ],
          //     // ),
          //     // Row(
          //     //   children: <Widget>[
          //     //     MaterialButton(
          //     //       minWidth: 40,
          //     //       onPressed: () {
          //     //         setState(() {
          //     //           _changeScreen(2);
          //     //         });
          //     //       },
          //     //       child: Column(
          //     //         mainAxisAlignment: MainAxisAlignment.center,
          //     //         children: <Widget>[
          //     //           ImageIcon(
          //     //             AssetImage('assets/icons/icons8-reminders-50.png'),
          //     //           color: _icon[1]),
          //     //           Text("Reminders", style: TextStyle(color: _icon[1],)),
          //     //         ],
          //     //       ),
          //     //     ),
          //     //     MaterialButton(
          //     //       minWidth: 70,
          //     //       onPressed: () {
          //     //         setState(() {
          //     //           _changeScreen(3);
          //     //         });
          //     //       },
          //     //       child: Column(
          //     //         mainAxisAlignment: MainAxisAlignment.center,
          //     //         children: <Widget>[
          //     //           Icon(Icons.person, color: _icon[2],),
          //     //           Text("Profile", style: TextStyle(color: _icon[2],),),
          //     //         ],
          //     //       ),
          //     //     ),
          //     //   ],
          //     // )
          //   ],
          // ),
        ),
      ),
    );

    // return Container(
    //   width: double.infinity,
    //   child: Container(
    //     // iphone142Jf2 (1:2)
    //     width: double.infinity,
    //     height: 844*fem,
    //     decoration: BoxDecoration (
    //       color: Color(0xffffffff),
    //       borderRadius: BorderRadius.circular(25*fem),
    //     ),
    //     child: Stack(
    //       children: [
    //         Positioned(
    //           // autogroup5t9af1i (6pdFQdbKMQ9S8RS2s85T9a)
    //           left: 0*fem,
    //           top: 0*fem,
    //           child: Container(
    //             width: 390*fem,
    //             height: 299*fem,
    //             child: Stack(
    //               children: [
    //                 Positioned(
    //                   // rectangle1Xpc (1:3)
    //                   left: 0*fem,
    //                   top: 0*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 390*fem,
    //                       height: 260*fem,
    //                       child: ClipRRect(
    //                         borderRadius: BorderRadius.only (
    //                           topLeft: Radius.circular(25*fem),
    //                           topRight: Radius.circular(25*fem),
    //                           bottomRight: Radius.circular(50*fem),
    //                           bottomLeft: Radius.circular(50*fem),
    //                         ),
    //                         child: Image.asset(
    //                           'assets/page-1/images/rectangle-1.png',
    //                           fit: BoxFit.cover,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // rectangle2o1S (1:4)
    //                   left: 25*fem,
    //                   top: 221*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 75*fem,
    //                       height: 78*fem,
    //                       child: Image.asset(
    //                         'assets/page-1/images/rectangle-2.png',
    //                         width: 75*fem,
    //                         height: 78*fem,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // vector125Uk (1:9)
    //                   left: 73*fem,
    //                   top: 230*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 18*fem,
    //                       height: 19*fem,
    //                       child: Image.asset(
    //                         'assets/page-1/images/vector-12-ZZz.png',
    //                         width: 18*fem,
    //                         height: 19*fem,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // vector13Mx4 (1:10)
    //                   left: 31*fem,
    //                   top: 230*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 18*fem,
    //                       height: 19*fem,
    //                       child: Image.asset(
    //                         'assets/page-1/images/vector-13-smS.png',
    //                         width: 18*fem,
    //                         height: 19*fem,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // vector1457N (1:11)
    //                   left: 31*fem,
    //                   top: 273*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 18*fem,
    //                       height: 18*fem,
    //                       child: Image.asset(
    //                         'assets/page-1/images/vector-14-PvY.png',
    //                         width: 18*fem,
    //                         height: 18*fem,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // vector15BRJ (1:12)
    //                   left: 73*fem,
    //                   top: 273*fem,
    //                   child: Align(
    //                     child: ElevatedButton(
    //                       onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  const CameraRoute("Identify Plant")));},
    //                       child: SizedBox(
    //
    //                         width: 18*fem,
    //                         height: 18*fem,
    //                         child: Image.asset(
    //                           'assets/page-1/images/vector-15.png',
    //                           width: 18*fem,
    //                           height: 18*fem,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // rectangle10gN4 (1:13)
    //                   left: 201*fem,
    //                   top: 221*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 75*fem,
    //                       height: 78*fem,
    //                       child: Container(
    //                         decoration: BoxDecoration (
    //                           borderRadius: BorderRadius.circular(25*fem),
    //                           color: Color(0xff6d0c0c),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // rectangle11aTS (1:14)
    //                   left: 288*fem,
    //                   top: 221*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 75*fem,
    //                       height: 78*fem,
    //                       child: Container(
    //                         decoration: BoxDecoration (
    //                           borderRadius: BorderRadius.circular(25*fem),
    //                           color: Color(0xffd4e9d6),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // rectangle14V4c (1:19)
    //                   left: 115*fem,
    //                   top: 221*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 75*fem,
    //                       height: 78*fem,
    //                       child: Container(
    //                         decoration: BoxDecoration (
    //                           borderRadius: BorderRadius.circular(25*fem),
    //                           color: Color(0xffd4e9d6),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // vector16mXv (1:20)
    //                   left: 167*fem,
    //                   top: 230*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 18*fem,
    //                       height: 18*fem,
    //                       child: Image.asset(
    //                         'assets/page-1/images/vector-16.png',
    //                         width: 18*fem,
    //                         height: 18*fem,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // vector17sL4 (1:21)
    //                   left: 124*fem,
    //                   top: 230*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 18*fem,
    //                       height: 18*fem,
    //                       child: Image.asset(
    //                         'assets/page-1/images/vector-17.png',
    //                         width: 18*fem,
    //                         height: 18*fem,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // vector18Zya (1:22)
    //                   left: 124*fem,
    //                   top: 273*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 18*fem,
    //                       height: 18*fem,
    //                       child: Image.asset(
    //                         'assets/page-1/images/vector-18.png',
    //                         width: 18*fem,
    //                         height: 18*fem,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // vector19Gsz (1:23)
    //                   left: 167*fem,
    //                   top: 273*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 18*fem,
    //                       height: 18*fem,
    //                       child: Image.asset(
    //                         'assets/page-1/images/vector-19.png',
    //                         width: 18*fem,
    //                         height: 18*fem,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // rectangle15BVA (1:24)
    //                   left: 135*fem,
    //                   top: 235*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 46*fem,
    //                       height: 47*fem,
    //                       child: Image.asset(
    //                         'assets/page-1/images/rectangle-15.png',
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           // autogroupihzrW1e (6pdGebXQXshEm89vVEiHZr)
    //           left: 0*fem,
    //           top: 299*fem,
    //           child: Container(
    //             padding: EdgeInsets.fromLTRB(37*fem, 0*fem, 38*fem, 57*fem),
    //             width: 390*fem,
    //             height: 436*fem,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Container(
    //                   // autogroupypsyP5S (6pdFqTDHv9UrwT8FyGYPSY)
    //                   margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 1*fem, 29*fem),
    //                   child: Row(
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       Container(
    //                         // diagnose6kY (1:5)
    //                         margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 50*fem, 0*fem),
    //                         child: Text(
    //                           'Diagnose',
    //                           style: SafeGoogleFont (
    //                             'Inter',
    //                             fontSize: 10*ffem,
    //                             fontWeight: FontWeight.w400,
    //                             height: 1.2125*ffem/fem,
    //                             color: Color(0xff000000),
    //                           ),
    //                         ),
    //                       ),
    //                       Container(
    //                         // identifyP7N (1:6)
    //                         margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 34*fem, 0*fem),
    //                         child: Text(
    //                           'Identify',
    //                           style: SafeGoogleFont (
    //                             'Inter',
    //                             fontSize: 10*ffem,
    //                             fontWeight: FontWeight.w400,
    //                             height: 1.2125*ffem/fem,
    //                             color: Color(0xff000000),
    //                           ),
    //                         ),
    //                       ),
    //                       Container(
    //                         // recommendationsVRJ (1:7)
    //                         margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 20*fem, 0*fem),
    //                         child: Text(
    //                           'Recommendations',
    //                           style: SafeGoogleFont (
    //                             'Inter',
    //                             fontSize: 10*ffem,
    //                             fontWeight: FontWeight.w400,
    //                             height: 1.2125*ffem/fem,
    //                             color: Color(0xff000000),
    //                           ),
    //                         ),
    //                       ),
    //                       Container(
    //                         // sowingseasonsoRz (1:8)
    //                         constraints: BoxConstraints (
    //                           maxWidth: 41*fem,
    //                         ),
    //                         child: Text(
    //                           'Sowing Seasons',
    //                           style: SafeGoogleFont (
    //                             'Inter',
    //                             fontSize: 10*ffem,
    //                             fontWeight: FontWeight.w400,
    //                             height: 1.2125*ffem/fem,
    //                             color: Color(0xff000000),
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Container(
    //                   // autogroupdtsqX76 (6pdG3nC5v4XtkZ2YboDTSQ)
    //                   margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 237*fem),
    //                   padding: EdgeInsets.fromLTRB(11*fem, 8*fem, 178*fem, 12.68*fem),
    //                   width: double.infinity,
    //                   decoration: BoxDecoration (
    //                     color: Color(0xffdef0e0),
    //                     borderRadius: BorderRadius.circular(25*fem),
    //                   ),
    //                   child: Row(
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       Container(
    //                         // searchcPS (1:17)
    //                         margin: EdgeInsets.fromLTRB(0*fem, 2*fem, 12.68*fem, 0*fem),
    //                         width: 30.32*fem,
    //                         height: 30.32*fem,
    //                         child: Image.asset(
    //                           'assets/page-1/images/search.png',
    //                           fit: BoxFit.contain,
    //                         ),
    //                       ),
    //                       Container(
    //                         // searchvQ8 (1:16)
    //                         margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1.32*fem),
    //                         child: Text(
    //                           'Search',
    //                           style: SafeGoogleFont (
    //                             'Inter',
    //                             fontSize: 25*ffem,
    //                             fontWeight: FontWeight.w400,
    //                             height: 1.2125*ffem/fem,
    //                             color: Color(0xff000000),
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Container(
    //                   // rectangle14SdN (1:18)
    //                   margin: EdgeInsets.fromLTRB(5*fem, 0*fem, 0*fem, 0*fem),
    //                   width: 308*fem,
    //                   height: 35*fem,
    //                   decoration: BoxDecoration (
    //                     color: Color(0xffd9d9d9),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           // autogroup882kYwJ (6pdGGSVf3p3ewJi8vW882k)
    //           left: 0*fem,
    //           top: 735*fem,
    //           child: Container(
    //             width: 390*fem,
    //             height: 109*fem,
    //             child: Stack(
    //               children: [
    //                 Positioned(
    //                   // ellipse183t4 (1:25)
    //                   left: 156*fem,
    //                   top: 2*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 71*fem,
    //                       height: 74*fem,
    //                       child: Image.asset(
    //                         'assets/page-1/images/ellipse-18.png',
    //                         width: 71*fem,
    //                         height: 74*fem,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // rectangle4267Z5i (1:26)
    //                   left: 0*fem,
    //                   top: 39*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 390*fem,
    //                       height: 70*fem,
    //                       child: Container(
    //                         decoration: BoxDecoration (
    //                           color: Color(0xff1a8e88),
    //                           borderRadius: BorderRadius.only (
    //                             bottomRight: Radius.circular(25*fem),
    //                             bottomLeft: Radius.circular(25*fem),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // ellipse194HN (1:27)
    //                   left: 156*fem,
    //                   top: 0*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 71*fem,
    //                       height: 74*fem,
    //                       child: Image.asset(
    //                         'assets/page-1/images/ellipse-19.png',
    //                         width: 71*fem,
    //                         height: 74*fem,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // remindersyQL (1:28)
    //                   left: 254*fem,
    //                   top: 77*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 36*fem,
    //                       height: 9*fem,
    //                       child: Text(
    //                         'Reminders',
    //                         style: SafeGoogleFont (
    //                           'Inter',
    //                           fontSize: 7*ffem,
    //                           fontWeight: FontWeight.w400,
    //                           height: 1.2125*ffem/fem,
    //                           color: Color(0xff000000),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // homeHR2 (1:29)
    //                   left: 33*fem,
    //                   top: 77*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 20*fem,
    //                       height: 9*fem,
    //                       child: Text(
    //                         'Home',
    //                         style: SafeGoogleFont (
    //                           'Inter',
    //                           fontSize: 7*ffem,
    //                           fontWeight: FontWeight.w400,
    //                           height: 1.2125*ffem/fem,
    //                           color: Color(0xfc000000),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // gardenm5J (1:30)
    //                   left: 89*fem,
    //                   top: 46*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 34*fem,
    //                       height: 31*fem,
    //                       child: Image.asset(
    //                         'assets/page-1/images/garden.png',
    //                         fit: BoxFit.contain,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // remindersDxt (1:31)
    //                   left: 252*fem,
    //                   top: 46*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 34*fem,
    //                       height: 31*fem,
    //                       child: Image.asset(
    //                         'assets/page-1/images/reminders.png',
    //                         fit: BoxFit.contain,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // mygarden6Fz (1:32)
    //                   left: 92*fem,
    //                   top: 77*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 37*fem,
    //                       height: 9*fem,
    //                       child: Text(
    //                         'My Garden',
    //                         style: SafeGoogleFont (
    //                           'Inter',
    //                           fontSize: 7*ffem,
    //                           fontWeight: FontWeight.w400,
    //                           height: 1.2125*ffem/fem,
    //                           color: Color(0xfc000000),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // startagardeniHN (1:33)
    //                   left: 167*fem,
    //                   top: 77*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 49*fem,
    //                       height: 9*fem,
    //                       child: Text(
    //                         'Start a Garden',
    //                         style: SafeGoogleFont (
    //                           'Inter',
    //                           fontSize: 7*ffem,
    //                           fontWeight: FontWeight.w400,
    //                           height: 1.2125*ffem/fem,
    //                           color: Color(0xfc000000),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // plusmathkzk (1:34)
    //                   left: 165*fem,
    //                   top: 12*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 50*fem,
    //                       height: 50*fem,
    //                       child: Image.asset(
    //                         'assets/page-1/images/plus-math.png',
    //                         fit: BoxFit.contain,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // settings5XE (1:35)
    //                   left: 337*fem,
    //                   top: 77*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 28*fem,
    //                       height: 9*fem,
    //                       child: Text(
    //                         'Settings',
    //                         style: SafeGoogleFont (
    //                           'Inter',
    //                           fontSize: 7*ffem,
    //                           fontWeight: FontWeight.w400,
    //                           height: 1.2125*ffem/fem,
    //                           color: Color(0xfc000000),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // settingsait (1:36)
    //                   left: 333*fem,
    //                   top: 46*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 31*fem,
    //                       height: 27*fem,
    //                       child: Image.asset(
    //                         'assets/page-1/images/settings.png',
    //                         fit: BoxFit.contain,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   // smarthome7D2 (1:37)
    //                   left: 26*fem,
    //                   top: 46*fem,
    //                   child: Align(
    //                     child: SizedBox(
    //                       width: 34*fem,
    //                       height: 31*fem,
    //                       child: TextButton(
    //                         onPressed: () {},
    //                         style: TextButton.styleFrom (
    //                           padding: EdgeInsets.zero,
    //                         ),
    //                         child: Image.asset(
    //                           'assets/page-1/images/smart-home.png',
    //                           fit: BoxFit.contain,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           // rectangle5bdz (1:38)
    //           left: 17*fem,
    //           top: 427*fem,
    //           child: Align(
    //             child: SizedBox(
    //               width: 360*fem,
    //               height: 292*fem,
    //               child: ClipRRect(
    //                 borderRadius: BorderRadius.only (
    //                   topRight: Radius.circular(60*fem),
    //                   bottomLeft: Radius.circular(60*fem),
    //                 ),
    //                 child: Image.asset(
    //                   'assets/page-1/images/rectangle-5.png',
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           // humidity85wind19kmhfromeastTw6 (1:39)
    //           left: 211*fem,
    //           top: 622*fem,
    //           child: Align(
    //             child: SizedBox(
    //               width: 160*fem,
    //               height: 44*fem,
    //               child: Text(
    //                 'Humidity : 85%\n\nWind : 19 km/h ↑ from East',
    //                 style: SafeGoogleFont (
    //                   'Inter',
    //                   fontSize: 12*ffem,
    //                   fontWeight: FontWeight.w700,
    //                   height: 1.2125*ffem/fem,
    //                   color: Color(0xff000000),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           // pressure10111012hpavisibility1 (1:40)
    //           left: 39*fem,
    //           top: 622*fem,
    //           child: Align(
    //             child: SizedBox(
    //               width: 146*fem,
    //               height: 44*fem,
    //               child: Text(
    //                 'Pressure : 1011-1012 hPa\n\nVisibility : 15 km\n',
    //                 style: SafeGoogleFont (
    //                   'Inter',
    //                   fontSize: 12*ffem,
    //                   fontWeight: FontWeight.w700,
    //                   height: 1.2125*ffem/fem,
    //                   color: Color(0xff000000),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           // sunny31c24cbA8 (1:41)
    //           left: 168*fem,
    //           top: 489*fem,
    //           child: Align(
    //             child: SizedBox(
    //               width: 37*fem,
    //               height: 44*fem,
    //               child: RichText(
    //                 text: TextSpan(
    //                   style: SafeGoogleFont (
    //                     'Inter',
    //                     fontSize: 12*ffem,
    //                     fontWeight: FontWeight.w600,
    //                     height: 1.2125*ffem/fem,
    //                     color: Color(0xff000000),
    //                   ),
    //                   children: [
    //                     TextSpan(
    //                       text: 'Sunny\n',
    //                     ),
    //                     TextSpan(
    //                       text: '31 °C\n24 °C',
    //                       style: SafeGoogleFont (
    //                         'Inter',
    //                         fontSize: 12*ffem,
    //                         fontWeight: FontWeight.w400,
    //                         height: 1.2125*ffem/fem,
    //                         color: Color(0xff000000),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           // monday03042023j3N (1:42)
    //           left: 61*fem,
    //           top: 469*fem,
    //           child: Align(
    //             child: SizedBox(
    //               width: 68*fem,
    //               height: 30*fem,
    //               child: RichText(
    //                 text: TextSpan(
    //                   style: SafeGoogleFont (
    //                     'Inter',
    //                     fontSize: 12*ffem,
    //                     fontWeight: FontWeight.w700,
    //                     height: 1.2125*ffem/fem,
    //                     color: Color(0xff000000),
    //                   ),
    //                   children: [
    //                     TextSpan(
    //                       text: 'Monday\n',
    //                     ),
    //                     TextSpan(
    //                       text: '03/04/2023',
    //                       style: SafeGoogleFont (
    //                         'Inter',
    //                         fontSize: 12*ffem,
    //                         fontWeight: FontWeight.w300,
    //                         height: 1.2125*ffem/fem,
    //                         color: Color(0xff000000),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           // portlouismauritiusVRr (1:43)
    //           left: 61*fem,
    //           top: 435*fem,
    //           child: Align(
    //             child: SizedBox(
    //               width: 60*fem,
    //               height: 32*fem,
    //               child: RichText(
    //                 text: TextSpan(
    //                   style: SafeGoogleFont (
    //                     'Inter',
    //                     fontSize: 14*ffem,
    //                     fontWeight: FontWeight.w400,
    //                     height: 1.2102272851*ffem/fem,
    //                     color: Color(0xff000000),
    //                   ),
    //                   children: [
    //                     TextSpan(
    //                       text: 'Port Louis\n',
    //                       style: SafeGoogleFont (
    //                         'Inter',
    //                         fontSize: 12*ffem,
    //                         fontWeight: FontWeight.w700,
    //                         height: 1.2125*ffem/fem,
    //                         color: Color(0xff000000),
    //                       ),
    //                     ),
    //                     TextSpan(
    //                       text: 'Mauritius',
    //                       style: SafeGoogleFont (
    //                         'Inter',
    //                         fontSize: 14*ffem,
    //                         fontWeight: FontWeight.w300,
    //                         height: 1.2125*ffem/fem,
    //                         color: Color(0xff000000),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           // placemarkernZN (1:44)
    //           left: 39*fem,
    //           top: 439*fem,
    //           child: Align(
    //             child: SizedBox(
    //               width: 15*fem,
    //               height: 16*fem,
    //               child: Image.asset(
    //                 'assets/page-1/images/place-marker.png',
    //                 fit: BoxFit.contain,
    //               ),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           // sunbehindsmallclouduP6 (1:45)
    //           left: 149*fem,
    //           top: 534*fem,
    //           child: Align(
    //             child: SizedBox(
    //               width: 82*fem,
    //               height: 62*fem,
    //               child: Image.asset(
    //                 'assets/page-1/images/sun-behind-small-cloud.png',
    //                 fit: BoxFit.contain,
    //               ),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           // addpkx (1:46)
    //           left: 270*fem,
    //           top: 435*fem,
    //           child: Align(
    //             child: SizedBox(
    //               width: 26*fem,
    //               height: 15*fem,
    //               child: Image.asset(
    //                 'assets/page-1/images/add.png',
    //                 fit: BoxFit.contain,
    //               ),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           // addlocationkec (1:47)
    //           left: 296*fem,
    //           top: 438*fem,
    //           child: Align(
    //             child: SizedBox(
    //               width: 47*fem,
    //               height: 10*fem,
    //               child: Text(
    //                 'Add location',
    //                 style: SafeGoogleFont (
    //                   'Inter',
    //                   fontSize: 8*ffem,
    //                   fontWeight: FontWeight.w300,
    //                   height: 1.2125*ffem/fem,
    //                   color: Color(0xff000000),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           // goodqualityU4p (1:48)
    //           left: 210*fem,
    //           top: 233*fem,
    //           child: Align(
    //             child: SizedBox(
    //               width: 58*fem,
    //               height: 58*fem,
    //               child: Image.asset(
    //                 'assets/page-1/images/good-quality.png',
    //                 fit: BoxFit.contain,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FlutterTts flutterTts = FlutterTts();
  bool spokenDiagnose = false;
  bool spokenIdentify = false;
  bool spoken = false;

  void speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(0.5);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1); // 0.5 to 1.5
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double deviceWidth = MediaQuery.of(context).size.width / 1;
    double deviceHeight = MediaQuery.of(context).size.height / 1;
    //double ffem = fem * 0.97;

    Color iconColor = Color.fromRGBO(183, 204, 173, 1);
    Color iconColor2 = Color.fromRGBO(212, 233, 214, 1);
    Color iconColor3 = Color.fromRGBO(129, 164, 131, 1);

    return Listener(
      onPointerMove: (PointerMoveEvent event) {
        print("Coord: ${event.position.dx},${event.position.dy}");
        if ((event.position.dx >= 41 && event.position.dx <= 90) &&
            (event.position.dy >= 282 && event.position.dy <= 319)) {
          if (!spokenDiagnose) {
            speak("Diagnose Plant");
            setState(() {
              spokenDiagnose = true;
              spokenIdentify = false;
            });
          }
        }
        if ((event.position.dx >= 174 && event.position.dx <= 222) &&
            (event.position.dy >= 282 && event.position.dy <= 319)) {
          if (!spokenIdentify) {
            speak("Identify Plant");
            setState(() {
              spokenDiagnose = false;
              spokenIdentify = true;
            });
          }
        }
      },
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  //color: Colors.blue,
                  height: deviceHeight * 0.30,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      // BoxShadow(
                      //   color: Colors.grey.withOpacity(0.5),
                      //   spreadRadius: 10,
                      //   blurRadius: 10,
                      //   offset: Offset(0, 10), // changes position of shadow
                      // ),
                    ],
                    // borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      opacity: .7,
                      image: AssetImage('assets/appBar_Image.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 230),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 4 / 20,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(250, 250, 250, 1),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: iconColor,
                                    ),
                                    //color: Colors.green,
                                    child: GestureDetector(
                                      onLongPress: () {
                                        speak("Diagnose Plant");
                                        print("Diagnose Plant");
                                      },
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const CameraRoute(
                                                        "Diagnose Plant")),
                                          );
                                        },
                                        icon: ImageIcon(
                                          AssetImage(
                                              "assets/icons/diagnose_plant_2.png"),
                                          size: 40,
                                          color: iconColour2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      "Diagnose",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: iconColour2),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: iconColor,
                                    ),
                                    child: MouseRegion(
                                      onHover: (PointerEvent details) {
                                        speak("Identify Plant");
                                        print("Enter");
                                      },
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const CameraRoute(
                                                        "Identify Plant")),
                                          );
                                        },
                                        icon: ImageIcon(
                                          AssetImage(
                                              "assets/icons/identify_icon_2.png"),
                                          size: 40,
                                          color: iconColour2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      "Identify",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: iconColour2),
                                    ),
                                  )
                                ],
                              ),
                              // Column(
                              //   children: [
                              //     Container(
                              //       height: 60,
                              //       width: 60,
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(15),
                              //         color: iconColor,
                              //       ),
                              //       child: IconButton(
                              //         onPressed: () {
                              //           Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                   builder: (context) => ForYou()));
                              //         },
                              //         icon: Icon(
                              //           Icons.thumb_up_alt_outlined,
                              //           size: 40,
                              //         ),
                              //       ),
                              //     ),
                              //     Padding(
                              //       padding: const EdgeInsets.only(top: 5),
                              //       child: Text(
                              //         "For You",
                              //         style: TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //         ),
                              //       ),
                              //     )
                              //   ],
                              // ),
                              Column(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: iconColor,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyGarden()));
                                      },
                                      icon: ImageIcon(
                                        AssetImage(
                                            "assets/icons/icons8-garden-50.png"),
                                        size: 37,
                                        color: iconColour2,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      "Garden",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: iconColour2),
                                    ),
                                  )
                                ],
                              ),
                              // Container(
                              //   height: 70,
                              //   width: 70,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(15),
                              //     color: Colors.green,
                              //   ),
                              //   child: IconButton(
                              //     onPressed: () {
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) => RecScreen2()));
                              //     },
                              //     icon: Icon(
                              //       Icons.thumb_up_alt_outlined,
                              //       size: 40,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Stack(
                    //   children: [
                    //     // Center(
                    //     //   child: SizedBox(
                    //     //     width: 8 / 9 * MediaQuery.of(context).size.width,
                    //     //     child: GestureDetector(
                    //     //       onTap: () =>
                    //     //           showSearch(context: context, delegate: Search()),
                    //     //       child: Container(
                    //     //         child: Row(
                    //     //           children: [
                    //     //             Padding(
                    //     //               padding: const EdgeInsets.all(8.0),
                    //     //               child: Icon(
                    //     //                 CupertinoIcons.search,
                    //     //                 size: 32,
                    //     //               ),
                    //     //             ),
                    //     //             Text("Search a plant"),
                    //     //           ],
                    //     //         ),
                    //     //         decoration: BoxDecoration(
                    //     //           borderRadius: BorderRadius.circular(25),
                    //     //           border: Border.all(
                    //     //             color: Color.fromRGBO(0, 0, 0, 1),
                    //     //           ),
                    //     //         ),
                    //     //       ),
                    //     //       // child: TextField(
                    //     //       //   enabled: false,
                    //     //       //   //controller: textController,
                    //     //       //   decoration: InputDecoration(
                    //     //       //     enabledBorder: OutlineInputBorder(
                    //     //       //       borderSide: BorderSide(color: Colors.black)
                    //     //       //     ),
                    //     //       //     border: OutlineInputBorder(
                    //     //       //       borderRadius: BorderRadius.circular(30),
                    //     //       //       // borderSide: BorderSide(color: Colors.green)
                    //     //       //     ),
                    //     //       //     hintText: "Search a pl
                    //     //       //       onPressed: () => showSearch(
                    //     //       //     context: context, ant",
                    //     //       //     prefixIcon: IconButton(delegate: Search()),
                    //     //       //         icon: Icon(Icons.search)),
                    //     //       //     // suffixIcon: IconButton(
                    //     //       //     //   onPressed: () {
                    //     //       //     //     textController.clear();
                    //     //       //     //   },
                    //     //       //     //   icon: Icon(
                    //     //       //     //     Icons.close,
                    //     //       //     //   ),
                    //     //       //     // ),
                    //     //       //   ),
                    //     //       // ),
                    //     //     ),
                    //     //   ),
                    //     // ),
                    //
                    //   ],
                    // ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 300+70),
                  child: WeatherInfo2(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 500),
                  child: WhatCanIGrow(),
                  // WeatherInfo(),
                ),
              ],
            ),

            //Search Bar
          ],
        ),
      ),
    );
  }
}
