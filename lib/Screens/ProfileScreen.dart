import 'package:flutter/material.dart';
import 'package:mon_potager/Screens/ForumScreen.dart';
import 'package:mon_potager/Screens/logInScreen.dart';
import 'package:mon_potager/isLogin.dart';
import 'package:mon_potager/models/Colours.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: pageTitleColour,
        title: Text(
          'My Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 60),
            child: Column(
              children: [IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ForumScreen(),));
              }, icon: Icon(Icons.forum))],
            ),
          ),
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                  },
                  icon: Icon(Icons.person))
            ],
          )
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 270 - 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/1465399314.png"),
                backgroundColor: pageTitleColour,
              ),
              SizedBox(height: 16),
              Text(
                'Aftab',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'aftab@zoom.com',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Contact: +230 5888 0000',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: () {},
              //   child: Text('About'),
              //   style: ElevatedButton.styleFrom(backgroundColor: pageTitleColour),
              // ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  toggleLogin();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => logInScreen(),
                      ));
                },
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                style:
                    ElevatedButton.styleFrom(backgroundColor: pageTitleColour),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
