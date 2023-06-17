import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mon_potager/Navigation.dart';
import './Camera.dart';

class displayPicture extends StatefulWidget {
  const displayPicture(this.image, this.previousPage, this.title, {Key? key}) : super(key: key);


  final File image;
  final String previousPage;
  final String title;


  @override
  State<displayPicture> createState() => _displayPictureState();
}

class _displayPictureState extends State<displayPicture> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Confirm Picture?"),
        ),
        body: Center(
            child: Container(
              child: Image.file(widget.image),
            )),
        bottomNavigationBar: BottomAppBar(
          height: MediaQuery
              .of(context)
              .size
              .height * 1 / 7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 1 / 7,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 1 / 3,
                child: InkWell(

                  splashColor: Colors.redAccent,

                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    CupertinoIcons.xmark,
                    size: 48,
                  ),
                ),
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 1 / 7,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 1 / 3,
                child: InkWell(
                  //highlightColor: Colors.yellowAccent,
                    splashColor: Colors.yellowAccent,
                    //splashRadius: 60,
                    onTap: () {
                      if (widget.previousPage == "gallery"){
                        CameraAppState camera = new CameraAppState();
                        camera.pickImage();
                      }else{
                        Navigator.pop(context);
                      }

                    },
                    child: Icon(
                      CupertinoIcons.refresh_thick,
                      size: 48,
                    )),
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 1 / 7,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 1 / 3,
                child: InkWell(

                  splashColor: Colors.greenAccent,

                  onTap: () async {





                    // Uint8List imageBytes = await widget.image.readAsBytes();
                    // var imageBase64 = base64Encode(imageBytes);
                    //
                    // var url;
                    //
                    // if (widget.title == "Diagnose Plant"){
                    //    url = Uri.https("api.plant.id", "v2/health_assessment");
                    // }else{
                    //    url = Uri.https("api.plant.id", "v2/identify");
                    //    print(2);
                    // }
                    //
                    // print(url);
                    //
                    // final response = await http.post(url, headers: {
                    //   "Content-Type": "application/json",
                    //   "Api-Key": "zPWL2eLrvkBuu5U9l5IfDdL7TVrNqa7nRIKc6R3W6z0YGKmv9D",
                    // }, body: json.encode({"images": [imageBase64],}));
                    //
                    // print(response.statusCode);
                    // print("----------------------------------------------");
                    // print(response);
                    // print("------------------------------------------------");
                    // print(response.body);
                    // print("---------------------------------------------------");
                  },
                  child: Icon(
                    CupertinoIcons.check_mark,
                    size: 48,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
