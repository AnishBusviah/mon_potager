import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: <BottomNavigationBarItem> [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home', backgroundColor: Colors.greenAccent),
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',),
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',),
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',),
    ],
    );
  }
}
