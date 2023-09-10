import 'dart:convert';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mon_potager/Navigation.dart';
import 'package:mon_potager/models/Colours.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../widgets/AddNotePhoto.dart';
import '../widgets/TextToSpeech.dart';

class WriteNote extends StatefulWidget {
  String name;

  WriteNote({Key? key, required this.name}) : super(key: key);

  @override
  State<WriteNote> createState() => _WriteNoteState();
}

class _WriteNoteState extends State<WriteNote> {

  @override
  void initState() {
    speak("Add plant note screen");
    super.initState();
  }

  bool isLoaded = false;
  double width = 0;
  late File image;
  String encodedImage = "";

  final noteController = TextEditingController();

  double _iconSize = 38;
  bool _listening = false;
  Icon _micIcon = Icon(Icons.mic_none,color: Colors.white, size: 38, );
  SpeechToText speechToText = SpeechToText();

  Future<void> _toggleListening() async {
    if(!_listening){

      var available = await speechToText.initialize();

      if(available){
        setState(() {
          _listening = true;
          speak("Listening...");
          _micIcon = Icon(Icons.mic, color: Colors.white, size: _iconSize,);
          speechToText.listen(
              onResult: (result){
                setState(() {
                  noteController.text = result.recognizedWords;
                });
              }
          );
        });
      }
    }else{
      setState(() {
        _listening = false;
        speak("Recording Stopped!");
        _micIcon = Icon(Icons.mic_none,color: Colors.white, size: _iconSize,
        );});
      speechToText.stop();
    }
  }



  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    noteController.dispose();
    super.dispose();
  }

  bool speakCancel = false;
  bool speakDone = false;
  bool speakNote = false;
  bool speakPhoto = false;
  bool speakMic = false;

  void setFalse(){
    speakCancel = false;
    speakDone = false;
    speakNote = false;
    speakPhoto = false;
    speakMic = false;
  }


  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerMove: (PointerMoveEvent event) {
      print("Coord: ${event.position.dx},${event.position.dy}");

      if ((event.position.dx >= 34 && event.position.dx <= 80) &&
          (event.position.dy >= 36 && event.position.dy <= 59)) {
        if (!speakCancel) {
          speak("Click to Cancel");
          setState(() {
            setFalse();
            speakCancel = true;
          });

        }
      }else if ((event.position.dx >= 354 && event.position.dx <= 400) &&
          (event.position.dy >= 36 && event.position.dy <= 59)) {
        if (!speakDone) {
          speak("Click to Save");
          setState(() {
            setFalse();
            speakDone = true;
          });

        }
      }else if ((event.position.dx >= 28 && event.position.dx <= 388) &&
          (event.position.dy >= 104 && event.position.dy <= 245)) {
        if (!speakNote) {
          speak("Click to Write a note");
          setState(() {
            setFalse();
            speakNote = true;
          });

        }
      }else if ((event.position.dx >= 27 && event.position.dx <= 102) &&
          (event.position.dy >= 281 && event.position.dy <= 364)) {
        if (!speakPhoto) {
          speak("Click to add a picture");
          setState(() {
            setFalse();
            speakPhoto = true;
          });

        }
      }else if ((event.position.dx >= 183 && event.position.dx <= 233) &&
          (event.position.dy >= 676 && event.position.dy <= 737)) {
        if (!speakMic) {
          if(_listening){
            speak("Click to turn off speech to text");
          }else{
            speak("Click to turn on speech to text");
          }

          setState(() {
            setFalse();
            speakMic = true;
          });

        }
      }else{
        setState(() {
          setFalse();
        });
      }
      },
      child: SafeArea(
          child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
                padding: const EdgeInsets.only(),
                child: AvatarGlow(
                  endRadius: 75,
                  animate: _listening,
                  duration: Duration(milliseconds: 2000),
                  glowColor: solidGreen,
                  repeat: true,
                  repeatPauseDuration: Duration(milliseconds: 100),
                  showTwoGlows: true,
                  child: GestureDetector(
                      onTap: _toggleListening,
                      child: CircleAvatar(
                        maxRadius: 35,
                          backgroundColor: solidGreen,
                          child: _micIcon)),
                )),
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
                      speak("Cancelled");
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.redAccent,
                        // fontWeight: FontWeight.bold,
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      saveToDatabase(
                          name: widget.name,
                          note: noteController.text,
                          imageBase64: encodedImage);
                      Navigator.pop(context);
                      speak("Note Saved!");
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(
                          color: solidGreen, fontWeight: FontWeight.bold),
                    )),
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
      )));

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
    'createdAt': Timestamp.now(),
  };

  await noteDatabase.add(noteJson);
}
