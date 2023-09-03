import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mon_potager/Screens/ForumScreen.dart';
import 'package:mon_potager/models/Colours.dart';

import '../Screens/logInScreen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              SizedBox(
                child: DrawerHeader(
                    decoration: BoxDecoration(color: iconColour),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 78,
                          // child: Image.asset("assets/monPotagerLogo.png")
                          child: Image.asset("assets/connoisseur.png"),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Mon Potager",
                              style: TextStyle(fontSize: 20),
                            ), Text("Your virtual plant connoisseur", style: TextStyle(fontSize: 12),)
                          ],
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SizedBox(

                  child: Column(
                    children: [
                      ListTile(
                          title: Text("Forum"),
                          // trailing: Icon(Icons.forum),
                          leading: Icon(Icons.forum),
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => ForumScreen(),
                            //     ));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => logInScreen(),
                                ));
                          },
                      ),
                      ListTile(
                        title: Text("Settings"),
                        leading: Icon(Icons.settings),
                      ),
                      ListTile(
                        title: Text("About"), leading: Icon(CupertinoIcons.chat_bubble),
                      ),
                      ListTile(
                        title: Text("Help"),leading: Icon(CupertinoIcons.question),
                      ),
                      ListTile(
                        title: Text("Exit"), leading: Icon(Icons.exit_to_app), onTap: (){exit(0);},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
