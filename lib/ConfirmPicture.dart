import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mon_potager/Navigation.dart';
import 'package:mon_potager/Screens/plantPage.dart';
import 'package:mon_potager/Screens/plantPage3.dart';
import 'package:mon_potager/models/Colours.dart';
import 'package:mon_potager/models/PlantAssessmentResults.dart';
import 'package:mon_potager/widgets/TextToSpeech.dart';
import 'package:path_provider/path_provider.dart';
import './Camera.dart';
import 'Screens/DiagnosisResultsScreen.dart';

import 'package:image_cropper/image_cropper.dart';

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File("$path/healthJson.json");
  }

  Future<File> writeFile(var content) async {
    final file = await _localFile;

    return file.writeAsString('$content');
  }
}

class displayPicture extends StatefulWidget {
  displayPicture(this.image, this.previousPage, this.title, {Key? key})
      : super(key: key);

  File image;

  final String previousPage;
  final String title;






  @override
  State<displayPicture> createState() => _displayPictureState();



}

class _displayPictureState extends State<displayPicture> {
  CroppedFile? croppedFile;

  Future cropImage() async {
      croppedFile = await ImageCropper().cropImage(
      sourcePath: widget.image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: pageTitleColour,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: pageTitleColour,

            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
      ],


    );

      // setState(() {
      //
      // });
    // return File(croppedFile!.path);

    setState(() {
      widget.image = File(croppedFile!.path);
    });

  }

  @override
  void initState() {
    speak("Confirm Picture Screen");
    super.initState();
  }

  bool spokenCancel = false;
  bool spokenRetry = false;
  bool spokenConfirm = false;
  bool  spokenCrop = false;

  void setFalse(){
    spokenCancel = false;
    spokenConfirm = false;
    spokenRetry = false;
    spokenCrop = false;
  }


  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerMove: (PointerMoveEvent event) {
      print("Coord: ${event.position.dx},${event.position.dy}");
      if ((event.position.dx >= 41 && event.position.dx <= 90) &&
          (event.position.dy >= 694 && event.position.dy <= 784)) {
        if (!spokenCancel) {
          speak("Click to Cancel");
          setState(() {
            setFalse();
            spokenCancel = true;
          });
        }
      }else if ((event.position.dx >= 174 && event.position.dx <= 268) &&
          (event.position.dy >= 694 && event.position.dy <= 784)) {
        if (!spokenRetry) {
          speak("Click retake picture");
          setState(() {
            setFalse();
            spokenRetry = true;
          });
        }
      }else if ((event.position.dx >= 294 && event.position.dx <= 396) &&
          (event.position.dy >= 694 && event.position.dy <= 784)) {
        if (!spokenConfirm) {
          speak("Click to Confirm");
          setState(() {
            setFalse();
            spokenConfirm = true;
          });
        }
      }else if ((event.position.dx >= 353 && event.position.dx <= 382) &&
          (event.position.dy >= 600 && event.position.dy <= 664)) {
        if (!spokenCrop) {
          speak("Click to Crop Picture");
          setState(() {
            setFalse();
            spokenCrop = true;
          });
        }
      }else{
        setState(() {
          setFalse();
        });
      }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(

          floatingActionButton: FloatingActionButton(
            shape: CircleBorder(),
            backgroundColor: solidGreen,
            child: Icon(CupertinoIcons.crop),
            elevation: 0,
            onPressed: () {
              cropImage();
            },
          ),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: pageTitleColour,
            title: Text("Confirm Picture?", style: TextStyle(color: Colors.white),),
          ),
          body: Center(
              child: Container(
            child: croppedFile == null? Image.file(widget.image) : Image.file(File(croppedFile!.path)),
          )),
          bottomNavigationBar: BottomAppBar(
            height: MediaQuery.of(context).size.height * 1 / 7,
            padding: EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 1 / 7,
                  width: MediaQuery.of(context).size.width * 1 / 3,
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
                  height: MediaQuery.of(context).size.height * 1 / 7,
                  width: MediaQuery.of(context).size.width * 1 / 3,
                  child: InkWell(
                      //highlightColor: Colors.yellowAccent,
                      splashColor: Colors.yellowAccent,
                      //splashRadius: 60,
                      onTap: () {
                        if (widget.previousPage == "gallery") {
                          CameraAppState camera = new CameraAppState();
                          camera.pickImage();
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: Icon(
                        CupertinoIcons.refresh_thick,
                        size: 48,
                      )),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 1 / 7,
                  width: MediaQuery.of(context).size.width * 1 / 3,
                  child: InkWell(
                    splashColor: Colors.greenAccent,
                    onTap: () async {
                      Uint8List imageBytes = await widget.image.readAsBytes();
                      var imageBase64 = base64Encode(imageBytes);

                      var url;

                      if (widget.title == "Diagnose Plant") {
                        url = Uri.https("api.plant.id", "v2/health_assessment");

                        ///API Call
                        final response = await http.post(url,
                            headers: {
                              "Content-Type": "application/json",
                              "Api-Key":
                                  "zPWL2eLrvkBuu5U9l5IfDdL7TVrNqa7nRIKc6R3W6z0YGKmv9D",
                            },
                            body: json.encode({
                              "images": [imageBase64],
                              "modifiers": ["similar_images"],
                              "disease_details": [
                                "common_names",
                                "url",
                                "description",
                                "cause",
                                "treatment"
                              ]
                            }));

                        final decodedResponse = await jsonDecode(response.body);

                        print(imageBase64);
                        print(response.statusCode);
                        print("----------------------------------------------");
                        print(response);
                        print("------------------------------------------------");
                        print(response.body);
                        print(
                            "---------------------------------------------------");

                        // ///READING JSON
                        // final response =
                        //     await rootBundle.loadString("assets/health.json");
                        // final decodedResponse = await jsonDecode(response);
                        //
                        // print(decodedResponse["health_assessment"]);
                        final Map<String, dynamic> healthAssessment =
                            decodedResponse["health_assessment"];

                        final mappedJsonResponse =
                            new PlantAssessmentResults.fromJson(healthAssessment);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DiagnosisResultsScreen(mappedJsonResponse, widget.image)));

                        ///Write to File
                        // CounterStorage storage = CounterStorage();
                        // storage.writeFile(decodedResponse);

                        ///Else Identify
                      } else if(widget.title == "Identify Plant") {
                        var url = Uri.https("api.plant.id", "v2/identify");

                        final response = await http.post(url,
                            headers: {
                              "Content-Type": "application/json",
                              "Api-Key":
                                  "zPWL2eLrvkBuu5U9l5IfDdL7TVrNqa7nRIKc6R3W6z0YGKmv9D",
                            },
                            body: json.encode({
                              "images": [imageBase64],
                            }));

                        print(response.statusCode);
                        print("----------------------------------------------");
                        print(response);
                        print("------------------------------------------------");
                        print(response.body);
                        print(
                            "---------------------------------------------------");

                        final decodedResponse = await jsonDecode(response.body);
                        final latinName =
                            decodedResponse["suggestions"][0]["plant_name"];
                        print(latinName);

                        var url2 = Uri.parse(
                            "https://cms-fullsearch-service.picturethisai.com/api/v1/cmsfullsearch/cms_full_search?searchText=${latinName}&languageCode=0&countryCode=Other");
                        var plantResponse = await http.get(url2);

                        if (plantResponse.statusCode == 200) {
                          var plantResponseBody = plantResponse.body;
                          var jsonPlantResponse = jsonDecode(plantResponseBody);

                          var resultsMap = jsonPlantResponse["response"] as Map;

                          print(resultsMap);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      plantPage3(resultsMap["indexModels"][0], imageBase64)));
                        }
                      }else if(widget.title == "Add Photos"){
                        Navigator.of(context)..pop()..pop(widget.image);
                      }

                      print(url);

                      // if (widget.title == "Diagnose Plant") {
                      // } else {
                      //   // decodedResponse should decode response.body
                      //   final response = await rootBundle.loadString(
                      //       "assets/response_species_identification.json");
                      //   final decodedResponse = await jsonDecode(response);
                      //
                      //   final latinName =
                      //       decodedResponse["suggestions"][0]["plant_name"];
                      //   print(latinName);
                      //
                      //   var url = Uri.parse(
                      //       "https://cms-fullsearch-service.picturethisai.com/api/v1/cmsfullsearch/cms_full_search?searchText=${latinName}&languageCode=0&countryCode=Other");
                      //   var plantResponse = await http.get(url);
                      //
                      //   if (plantResponse.statusCode == 200) {
                      //     var plantResponseBody = plantResponse.body;
                      //     var jsonPlantResponse = jsonDecode(plantResponseBody);
                      //
                      //     var resultsMap = jsonPlantResponse["response"] as Map;
                      //
                      //     print(resultsMap);
                      //
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) =>
                      //                 plantPage(resultsMap["indexModels"][0])));
                      //   }
                      // }
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
      ),
    );
  }
}
