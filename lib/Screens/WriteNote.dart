import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mon_potager/Navigation.dart';

import '../widgets/AddNotePhoto.dart';

class WriteNote extends StatefulWidget {
  String name;

  WriteNote({Key? key, required this.name}) : super(key: key);

  @override
  State<WriteNote> createState() => _WriteNoteState();
}

class _WriteNoteState extends State<WriteNote> {
  bool isLoaded = false;
  double width = 0;
  late File image;
  String encodedImage = "";

  final noteController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        // leading: Text("Cancel", style: TextStyle(color: Colors.black),),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              GestureDetector(
                  onTap: () {
                    saveToDatabase(
                        name: widget.name,
                        note: noteController.text,
                        imageBase64: encodedImage);
                    Navigator.pop(context);
                  },
                  child: Text("Done")),
            ],
          ),
        ),
      ),
      body: Column(children: [
        Container(
          // color: Colors.yellow,
          width: MediaQuery.of(context).size.width,
          height: 200,
          padding: EdgeInsets.all(20),
          child: TextField(
            controller: noteController,
            maxLines: null,
            expands: true,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              isCollapsed: true,
              contentPadding: EdgeInsets.all(9),
              filled: true,
              border: OutlineInputBorder(),
              hintText: "Write a note",
              // labelText: 'Password',
            ),
          ),
        ),
        Row(
          children: [
            isLoaded == true
                ? Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                      // color: Colors.red,
                      width: width,
                      child: Image.file(
                        image,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                padding: EdgeInsets.all(10),
                color: Color.fromRGBO(235, 235, 235, 1),
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () async {
                        final response = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddNotePhoto("Add Photos"),
                            ));
                        setState(() async {
                          image = response;
                          width = 100;
                          isLoaded = true;
                          Uint8List imageBytes = await image.readAsBytes();
                          encodedImage = base64Encode(imageBytes);
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                    Text("Add Photo")
                  ],
                ),
              ),
            ),
          ],
        )
      ]),
    ));
  }
}

Future saveToDatabase({
  required String name,
  required String note,
  required String imageBase64,
}) async {
  final noteDatabase = FirebaseFirestore.instance.collection(name);

  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);
  // print(formattedDate); // 2016-01-25

  final noteJson = {
    'date': formattedDate,
    'note': note,
    'image': imageBase64,
  };

  await noteDatabase.add(noteJson);
}
