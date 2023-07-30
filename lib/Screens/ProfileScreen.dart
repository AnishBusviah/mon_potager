import 'package:flutter/material.dart';
import 'package:mon_potager/models/Colours.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pageTitleColour,
        title: Text('My Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 270),
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
              ElevatedButton(
                onPressed: () {},
                child: Text('About'),
                style: ElevatedButton.styleFrom(backgroundColor: pageTitleColour),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {},
                child: Text('Logout'),
                style: ElevatedButton.styleFrom(backgroundColor: pageTitleColour),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
