import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mon_potager/models/Colours.dart';
import 'package:mon_potager/models/plantNote.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter/material.dart';

import '../widgets/TextToSpeech.dart';
import 'WriteNote.dart';

class AddNote extends StatefulWidget {
  String image;
  String plantID;
  String plantName;

  AddNote(
      {Key? key,
      required this.image,
      required this.plantID,
      required this.plantName})
      : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}



class _AddNoteState extends State<AddNote> {

@override
  void initState() {
    speak("${widget.plantName} monitoring page");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1 / 3,
          decoration: BoxDecoration(color: Colors.green),
          child: Image.memory(base64Decode(widget.image), fit: BoxFit.fitWidth),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.only(
                top: (MediaQuery.of(context).size.height * 1 / 3) - 30),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height * 2 / 3) + 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: Column(
                children: [
                  Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Divider(
                        thickness: 2+2,
                        indent: 20+100+50+12,
                        endIndent: 20+100+50+12,
                        height: 125-100,
                        
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text(widget.plantName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                    ),
                    Divider(
                      thickness: 2,
                      indent: 20,
                      endIndent: 20,
                      height: 125,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 90, left: 20),
                      child: Text("Plant Timeline",
                          style: TextStyle(fontSize: 20)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        padding: EdgeInsets.all(0),
                        // color: Colors.redAccent,
                        height: 500,
                        child: Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 110,
                                  left: 15,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 0),
                                  child: StreamBuilder<List<PlantNote>>(
                                      stream: readPlantNotes(widget.plantName),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return Text(
                                              "Something went wrong! ${snapshot.error}");
                                        } else if (snapshot.hasData) {
                                          final plantNotes = snapshot.data!;
                                          return Expanded(
                                              child: ListView(

                                                padding: EdgeInsets.only(bottom: 70+100),


                                            // reverse: true,
                                            children: plantNotes
                                                .map(buildPlantNotes)
                                                .toList(),
                                          ));
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      }),
                                )

                                // ListView(
                                // children: [
                                // TimelineTile(
                                // beforeLineStyle: LineStyle(color: solidGreen),
                                // afterLineStyle: LineStyle(color: solidGreen),
                                // indicatorStyle:
                                // IndicatorStyle(color: solidGreen),
                                // isFirst: false,
                                // endChild: Row(
                                // mainAxisAlignment:
                                // MainAxisAlignment.spaceEvenly,
                                // children: [
                                // Column(
                                // mainAxisAlignment:
                                // MainAxisAlignment.center,
                                // children: [
                                // Text("31/08/02"),
                                // Text("Plant Added")
                                // ],
                                // ),
                                // Container(
                                // width: 150,
                                // child: Image.memory(
                                // base64Decode(widget.image),
                                // ),
                                // )
                                // ],
                                // ),
                                // ),
                                // TimelineTile(),
                                // TimelineTile(),
                                // TimelineTile(),
                                // TimelineTile(),
                                // TimelineTile(),
                                // TimelineTile()
                                // ],
                                // ),
                                )),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 600, left: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            color: Colors.white,
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 250, top: 10),
                      child: Text("Plant Notes",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 0),
                      child: GestureDetector(
                        onLongPress: (){
                          speak("Click to add plant notes");
                        },
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    WriteNote(name: widget.plantName),
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 129,
                          width: 350,
                          // color: Colors.red,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(207, 253, 188, .5),
                              border: Border.all(color: solidGreen),
                              borderRadius: BorderRadius.circular(15)),

                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("How does it look?"),
                                    Icon(Icons.camera_alt_outlined)
                                  ],
                                ),
                                Text("See any new leaves or flowers?"),
                                Text("Notice any new growth?"),
                                Text("Record your plant's progress!"),
                              ]),
                        ),
                      ),
                    ),
                  ])
                ]),
          ),
        ),
      ]),
    );
  }
}

Stream<List<PlantNote>> readPlantNotes(String plantName) {
  // print(FirebaseFirestore.instance.collection(plantName)
  // .orderBy('createdAt', descending: false)
  //     .snapshots().map(
  //       (snapshot) => snapshot.docs
  //       .map((doc) => PlantNote.fromJson(doc.data()))
  //       .toList(),
  // ));


    return FirebaseFirestore.instance.collection(plantName)
        .orderBy('createdAt', descending: false)
        .snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => PlantNote.fromJson(doc.data()))
              .toList(),
        );

}

int compare(PlantNote a, PlantNote b){
  return a.date.compareTo(b.date);
}

Widget buildPlantNotes(PlantNote note) => SizedBox(
      height: 200,
      child: GestureDetector(
        onLongPress: (){
          speak("${note.note} on ${note.date}");
        },
        child: TimelineTile(
          beforeLineStyle: LineStyle(color: solidGreen),
          afterLineStyle: LineStyle(color: solidGreen),
          indicatorStyle: IndicatorStyle(color: solidGreen),
          isFirst: false,
          endChild: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(note.date), SizedBox(
                    width: 150,
                    child: Text(note.note))],
              ),
              note.image == ""
                  ? SizedBox(
                      width: 150,
                    )
                  : Container(
                      width: 150,
                      child: Image.memory(
                        base64Decode(note.image),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
