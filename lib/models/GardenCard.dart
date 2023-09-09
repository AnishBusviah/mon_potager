import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Screens/AddNote.dart';

class GardenCard extends StatefulWidget {
  GardenCard(
      {Key? key,
      required this.plantImage,
      required this.plantName,
      required this.latinName,
      required this.sun,
      required this.water,
      required this.plantID})
      : super(key: key);

  String plantImage;
  String plantName;
  String latinName = "";
  String sun;
  String water;
  String plantID;

  @override
  State<GardenCard> createState() => _GardenCardState();
}

enum SampleItem { itemOne, itemTwo, itemThree }

class _GardenCardState extends State<GardenCard> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNote(
                  image: widget.plantImage,
                  plantID: widget.plantID,
                  plantName: widget.plantName),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0xBE43A56E),
                offset: Offset(0, 2),
              )
            ],
          ),
          // padding: EdgeInsets.only(top: 10),
          // color: Colors.red,
          width: 350 + 20,
          height: 173 + 20,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                // color: Colors.red,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.memory(
                            base64Decode(widget.plantImage),
                            width: 123,
                            height: 125,
                            fit: BoxFit.fill,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25, left: 5),
                      child: Container(
                        width: 180+1,
                        height: 100 + 30+20,
                        // color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.plantName,
                              style: TextStyle(
                                // fontFamily: 'Readex Pro',
                                color: Color(0xBE43A56E),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.latinName,
                              style: TextStyle(
                                  // fontFamily: 'Readex Pro',
                                  color: Color(0xBE43A56E),
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.sunny,
                                  color: Colors.yellow,
                                  size: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    widget.sun,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.water_drop,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    widget.water,
                                    style: TextStyle(
                                        fontSize: 12, fontFamily: 'Readex Pro'),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.blue,
                      child: PopupMenuButton<SampleItem>(
                        initialValue: selectedMenu,
                        // Callback that sets the selected popup menu item.
                        onSelected: (SampleItem item) {
                          setState(() {
                            selectedMenu = item;
                          });
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<SampleItem>>[
                          const PopupMenuItem<SampleItem>(
                            // value: SampleItem.itemOne,
                            child: Text('Add Reminder'),
                          ),
                          PopupMenuItem<SampleItem>(
                            // value: SampleItem.itemTwo,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddNote(
                                            image: widget.plantImage,
                                            plantID: widget.plantID,
                                            plantName: widget.plantName),
                                      ));
                                },
                                child: Text('Add Note')),
                          ),
                          PopupMenuItem<SampleItem>(
                            onTap: () {
                              final plantToDelete = FirebaseFirestore.instance
                                  .collection("myPlants")
                                  .doc(widget.plantID);

                              plantToDelete.delete();
                            },
                            // value: SampleItem.itemThree,
                            child: Text(
                              'Remove',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Container(
              //   height: 10,
              //     padding: EdgeInsets.only(bottom: 30),
              //     color: Colors.blue,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       // crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.only(bottom: 20),
              //           child: IconButton(
              //               onPressed: () {},
              //               icon: Icon(
              //                 Icons.playlist_add,
              //                 color: Color.fromRGBO(116, 118, 120, 1),
              //               )),
              //         ),
              //       ],
              //     ))
            ],
          ),
        ),
      ),
    );
  }
}
