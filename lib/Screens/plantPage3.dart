import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:mon_potager/Screens/GardenScreen.dart';
import 'package:mon_potager/models/Colours.dart';
import 'package:mon_potager/models/plantDetailsDisplay.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/searchResponseItem.dart';
import '../widgets/TextToSpeech.dart';

class plantPage3 extends StatefulWidget {
  plantPage3(this.plantDetailsMap, [this.imageBase64 = ""]) ;

  final Map<String, dynamic> plantDetailsMap;
  String imageBase64;

  @override
  State<plantPage3> createState() => _plantPage3State();
}

class _plantPage3State extends State<plantPage3> {
  var plantDetails;
  var plantData;
  var controller;

  Future<void> getPlantData(Map<String, dynamic> plantMap) async {
    plantData = new searchResult.fromJson(plantMap);

    plantDetails = new plantDetailsDisplay();

    plantDetails.setName(plantData.commonName);
    plantDetails.setImage(plantData.thumbnail);
    plantDetails.setLatinName(plantData.latinName);

    // WebView Code
    // controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..runJavaScriptReturningResult("document.querySelector('#care_guide_layout > div > div.care-guide-wrap > div.care-guide-items-wrap > div.care-guide-items > div:nth-child(1) > div.care-guide-item-content > div')")
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {},
    //       onWebResourceError: (WebResourceError error) {},
    //       // onNavigationRequest: (NavigationRequest request) {
    //       //   if (request.url.startsWith('https://www.youtube.com/')) {
    //       //     return NavigationDecision.prevent;
    //       //   }
    //       //   return NavigationDecision.navigate;
    //       // },
    //     ),
    //   )..loadRequest(Uri.parse('https://www.picturethisai.com/care/${plantDetails.latinName}.html#Cultivation:FertilizerDetail'));

    // setState(() {
    //   plantDetails.setDescription(plantDescription[0].toString());
    //   plantDetails.setLatinName(scientificName[0].toString());
    // });
  }

  @override
  void initState() {
    getPlantData(widget.plantDetailsMap);
    super.initState();
  }

  void getWebsiteData(String rawHtml) {
    //print(rawHtml);
    dom.Document plantCareHtml = dom.Document.html(rawHtml);
    //print(plantCareHtml);

    //print(waterInfo[0].replaceAll(RegExp('<[^>]*>'), ''));

    final plantDescriptionHtml = plantCareHtml
        .querySelectorAll(
        '#care_about_layout > div > div.care-about-content-wrapper > div.care-about-basic-info > div.care-about-description > div')
        .map((element) => element.innerHtml.trim())
        .toList();

    // print(plantDescriptionHtml);

    setState(() {
      plantDetails.setLatinName(plantDetails.latinName.replaceAll("_", " "));

      if (plantDescriptionHtml.length != 0) {
        plantDetails.setDescription(
            plantDescriptionHtml[0].replaceAll(RegExp('<[^>]*>'), ''));
      } else {
        plantDetails.setDescription("No Data Available");
      }
    });

    // final plantCareInfo = plantCareHtml
    //     .querySelectorAll(
    //     '#care_basic_guide_layout > div > div.care-basic-guide-wrapper > div)')
    //     .map((element) => element.innerHtml.trim())
    //     .toList();

    final plantCareInfo = plantCareHtml
        .querySelectorAll(
        '#care_guide_layout > div > div.care-guide-wrap > div.care-guide-items-wrap > div.care-guide-items > div:nth-child(2) > div.care-guide-item-content')
        .map((element) => element.innerHtml.trim())
        .toList();

    print(plantCareInfo);

    //print(info.length);

    final waterHtml = dom.Document.html(plantCareInfo[0]);
    final fertilizerHtml = dom.Document.html(plantCareInfo[1]);
    final sunlightHtml = dom.Document.html(plantCareInfo[2]);
    final pruningHtml = dom.Document.html(plantCareInfo[3]);

    final waterInfo = waterHtml
        .querySelectorAll(
        'div.care-common-field-item > div.care-common-field-content-wrapper.field-content-selected > div.care-common-field-values-part > div.care-common-field-value > div')
        .map((element) => element.innerHtml.trim())
        .toList();

    final fertilizerInfo = fertilizerHtml
        .querySelectorAll(
        'div.care-common-field-item > div.care-common-field-content-wrapper.field-content-selected > div.care-common-field-values-part > div.care-common-field-value > div')
        .map((element) => element.innerHtml.trim())
        .toList();

    final sunlightInfo = sunlightHtml
        .querySelectorAll(
        'div.care-common-field-item > div.care-common-field-content-wrapper.field-content-selected > div.care-common-field-values-part > div.care-common-field-value > div')
        .map((element) => element.innerHtml.trim())
        .toList();

    final pruningInfo = pruningHtml
        .querySelectorAll(
        'div.care-common-field-item > div.care-common-field-content-wrapper.field-content-selected > div.care-common-field-values-part > div.care-common-field-value > div')
        .map((element) => element.innerHtml.trim())
        .toList();

    setState(() {
      if (waterInfo.length == 0) {
        plantDetails.setWaterDetails("No Data Available");
      } else {
        plantDetails
            .setWaterDetails(waterInfo[0].replaceAll(RegExp('<[^>]*>'), ''));
      }

      if (fertilizerInfo.length == 0) {
        plantDetails.setFertilizationDetails("No Data Available");
      } else {
        plantDetails.setFertilizationDetails(
            fertilizerInfo[0].replaceAll(RegExp('<[^>]*>'), ''));
      }

      if (sunlightInfo.length == 0) {
        plantDetails.setSunlightrDetails("No Data Available");
      } else {
        plantDetails.setSunlightDetails(
            sunlightInfo[0].replaceAll(RegExp('<[^>]*>'), ''));
      }

      if (pruningInfo.length == 0) {
        plantDetails.setPruningDetails("No Data Available");
      } else {
        plantDetails.setPruningDetails(
            pruningInfo[0].replaceAll(RegExp('<[^>]*>'), ''));
      }

      // print(plantDetails.waterDetails);
      // print(plantDetails.fertilizationDetails);
      // print(plantDetails.sunlightDetails);
      // print(plantDetails.pruningDetails);
    });

    // print(plantCareInfo[0].replaceAll('<div class="care-common-field-item"> <div class="care-common-field-title-wrapper" id="pc_Cultivation:WaterDetail"> <img data-src="/wiki-static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_water_title@2x.png" alt="Cultivation:WaterDetail" class="care-layout-title-wrap-icon" width="4.0rem" height="4.0rem"> <h3 class="care-layout-title-wrap-text"> Water </h3> </div> <div class="care-common-field-content-wrapper field-content-selected"> <div class="care-common-field-values-part"> <div class="care-common-field-value">    <div> ', ''));
    // print(waterInfo);
  }

  bool speakWater = false;
  bool speakSun = false;
  bool speakFertiliser = false;
  bool speakPruning = false;
  bool speakName = false;
  bool speakDesc = false;
  bool speakAdd = false;

  void setFalse() {
    speakWater = false;
    speakSun = false;
    speakFertiliser = false;
    speakPruning = false;
    speakName = false;
    speakDesc = false;
    speakAdd = false;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerMove: (PointerMoveEvent event) {
          print("Coord: ${event.position.dx},${event.position.dy}");

          if ((event.position.dx >= 307 && event.position.dx <= 408) &&
              (event.position.dy >= 140 && event.position.dy <= 180)) {
            if (!speakWater) {
              speak("Water Details. ${plantDetails.waterDetails}");
              setState(() {
                setFalse();
                speakWater = true;
              });
            }
          } else if ((event.position.dx >= 307 && event.position.dx <= 408) &&
              (event.position.dy >= 218 && event.position.dy <= 263)) {
            if (!speakSun) {
              speak("Sunlight details. ${plantDetails.sunlightDetails}");
              setState(() {
                setFalse();
                speakSun = true;
              });
            }
          }else if ((event.position.dx >= 307 && event.position.dx <= 408) &&
              (event.position.dy >= 305 && event.position.dy <= 336)) {
            if (!speakFertiliser) {
              speak("Fertiliser details. ${plantDetails.fertilizationDetails}");
              setState(() {
                setFalse();
                speakFertiliser = true;
              });
            }
          }else if ((event.position.dx >= 307 && event.position.dx <= 408) &&
              (event.position.dy >= 384 && event.position.dy <= 424)) {
            if (!speakPruning) {
                speak("Pruning Details. ${plantDetails.pruningDetails}");
                setState(() {
                  setFalse();
                  speakPruning = true;
                });
              }

            }else if ((event.position.dx >= 36 && event.position.dx <= 374) &&
              (event.position.dy >= 497 && event.position.dy <= 537)) {
            if (!speakName) {
              speak("Plant name. ${plantData
                  .commonName}. Latin name.${plantDetails.latinName}");
              setState(() {
                setFalse();
                speakName = true;
              });
            }
          }else if ((event.position.dx >= 36 && event.position.dx <= 388) &&
              (event.position.dy >= 615 && event.position.dy <= 724)) {
            if (!speakDesc) {
              speak("Plant description. ${plantDetails.description}");
              setState(() {
                setFalse();
                speakDesc = true;
              });
            }
          }else if ((event.position.dx >= 152 && event.position.dx <= 272) &&
              (event.position.dy >= 755 && event.position.dy <= 763)) {
            if (!speakAdd) {
              speak("Click to add plant to Garden.");
              setState(() {
                setFalse();
                speakAdd = true;
              });
            }
          }else{
            setState(() {
              setFalse();
            });
          }
          },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(241, 236, 238, 1),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          // iconTheme: IconThemeData(color: pageTitleColour),
          // backgroundColor: Colors.transparent,
          backgroundColor: Color.fromARGB(168, 36, 139, 88),
          elevation: 0,
          title: Text(
            "Plant Details", style: TextStyle(color: Colors.white),
            // style: TextStyle(color: pageTitleColour),
          ),
        ),
        body: Stack(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 400,
                  width: 400,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 120, 30),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15)),
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Image.network(
                            "https://www.picturethisai.com/image-handle/website_cmsname/image/1080/${plantDetails
                                .image}?x-oss-process=image/format,webp/quality,q_70/resize,l_500&v=1.1",
                            height: 50),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Card(
                        margin: EdgeInsets.fromLTRB(270, 50, 30 - 25, 3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        color: Color.fromARGB(190, 204, 236, 218),
                        child: InkWell(
                          onTap: () {
                            openwaterDialog();
                          },
                          child: plantDetails.waterDetails == "Loading Data..."
                              ? null
                              : SizedBox(
                            height: 51+4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                  EdgeInsets.fromLTRB(35, 5, 18, 3),
                                  child: Text(
                                      "Water", // Replace with your desired text
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Image.network(
                                          "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_water_title@2x.png?x-oss-process=image/format,webp/resize,s_25&v=1.0",
                                          height: 25,
                                          width: 10),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Card(
                        margin: EdgeInsets.fromLTRB(270, 25, 30 - 25, 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        color: Color.fromARGB(190, 204, 236, 218),
                        child: InkWell(
                          onTap: () {
                            opensunDialog();
                          },
                          child: SizedBox(
                            height: 51+4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 6, 18, 4),
                                  child: Text("Sunlight",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Image.network(
                                          "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_sunlight_title@2x.png?x-oss-process=image/format,webp/resize,s_25&v=1.0",
                                          height: 20,
                                          width: 10),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Card(
                        margin: EdgeInsets.fromLTRB(270, 25, 30 - 25, 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        color: Color.fromARGB(190, 204, 236, 218),
                        child: InkWell(
                          onTap: () {
                            openFertiliserDialog();
                          },
                          child: SizedBox(
                            height: 51+4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align the text to the left
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(26, 6, 18, 4),
                                  child: Text("Fertiliser",
                                      // Replace with your desired text
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Image.network(
                                          "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_fertilizer_title@2x.png?x-oss-process=image/format,webp/resize,s_25&v=1.0",
                                          height: 20,
                                          width: 20),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Card(
                        margin: EdgeInsets.fromLTRB(270, 25, 30 - 25, 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        color: Color.fromARGB(190, 204, 236, 218),
                        child: InkWell(
                          onTap: () {
                            openPruningDialog();
                          },
                          child: SizedBox(
                            height: 51+4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align the text to the left
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(26, 6, 18, 4),
                                  child: Text(
                                      "Pruning", // Replace with your desired text
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Image.network(
                                          "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_pruning_title@2x.png?x-oss-process=image/format,webp/resize,s_25&v=1.0",
                                          height: 20,
                                          width: 20),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 378, 15, 40),
                  padding: EdgeInsets.fromLTRB(25, 10, 60, 10),
                  height: 600,
                  width: 550,
                  decoration: BoxDecoration(
                    // color: Color.fromARGB(168, 36, 139, 88),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(025),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(25),
                      )),
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(29, 410, 30, 60),
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 4 / 30,
                      // was 100
                      width: 500,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(219, 172, 242, 207),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.elliptical(12, 40),
                            topRight: Radius.elliptical(12, 40),
                            bottomLeft: Radius.elliptical(12, 40),
                            bottomRight: Radius.elliptical(12, 40),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Common name: ",
                              style: TextStyle(
                                color: Color.fromARGB(200, 137, 136,
                                    136), // Change the color of "Name:"
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: plantDetails.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Latin name: ",
                              style: TextStyle(
                                color: Color.fromARGB(255, 124, 126,
                                    129), // Change the color of "Name:"
                                fontSize: 16,
                                fontWeight: FontWeight.bold,

                                height: 2,
                              ),
                              children: [
                                TextSpan(
                                  text: plantDetails.latinName,
                                  style: TextStyle(
                                    height: 0.6,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors
                                        .black, // Change the color of the name value
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 530, 20, 70),
                  padding: EdgeInsets.fromLTRB(30, 10, 60, 20),
                  height: 150,
                  width: 450,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(213, 145, 216, 176),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description:",
                        style: TextStyle(
                          height: 1.5,
                          color: Color.fromARGB(199, 10, 9, 9),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                          child: InkWell(
                            onTap: () {
                              opendescDialog();
                            },
                            child: Text(
                              plantDetails.description,
                              style: TextStyle(
                                height: 1.9,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              maxLines:
                              1, // Limit the number of lines to prevent overflow
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 655, left: 135),
                  child: Container(
                    child: ElevatedButton(
                        onPressed: () {
                          addToGarden(name: plantDetails.name,
                              latinName: plantDetails.latinName,
                              sun: plantDetails.sunlightDetails,
                              water: plantDetails.waterDetails,
                              imageBase64: widget.imageBase64);
                          speak("Plant Added to Garden");

                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyGarden(),));

                        },
                        child: Text("Add to Garden", style: TextStyle(color: Colors.white),),
                        style:
                        ElevatedButton.styleFrom(backgroundColor: solidGreen)),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.only(top: 660, left: 130),
                //   child: SizedBox(
                //     width: 150,
                //     height: 50,
                //     child: ElevatedButton(onPressed: () {},
                //         child: Text("Add to Garden", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                //         style: ElevatedButton.styleFrom(backgroundColor: pageTitleColour,)),
                //   ),
                // ),
                Offstage(
                  child: WebView(
                    initialUrl:
                    'https://www.picturethisai.com/care/${plantData
                        .latinName}.html',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated:
                        (WebViewController webViewController) async {
                      controller = webViewController;
                    },
                    onPageFinished: (_) async {
                      final sourceHtml =
                      await controller.runJavascriptReturningResult(
                          'new XMLSerializer().serializeToString(document)');

                      getWebsiteData(json.decode(sourceHtml));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ));
  }

  Future addToGarden({
    required String name,
    required String latinName,
    required String sun,
    required String water,
    required String imageBase64,}) async {

    final database = FirebaseFirestore.instance.collection('myPlants');

    //encode image in Base64

    final json = {
      'name': name,
      'latinName': latinName,
      'sun': sun,
      'water': water,
      'image': imageBase64,
    };

    /// Create document and write to Firebase
    await database.add(json);
    
    final noteDatabase = FirebaseFirestore.instance.collection(name);

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    // print(formattedDate); // 2016-01-25

    final noteJson = {
      'date': formattedDate,
      'note': "Plant Added",
      'image': imageBase64,
      'createdAt': Timestamp.now(),
    };

    await noteDatabase.add(noteJson);
  }

  Future openwaterDialog() =>
      showDialog(
        context: context,
        builder: ((context) =>
            Container(
              child: AlertDialog(
                backgroundColor: Color.fromARGB(237, 194, 236, 222),
                title: Text(
                  "Water",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                content: Text(
                  plantDetails.waterDetails,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                ),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: ok,
                  ),
                ],
              ),
            )),
      );

  void ok() {
    Navigator.of(context).pop();
  }

  Future opensunDialog() =>
      showDialog(
        context: context,
        builder: ((context) =>
            Container(
              child: AlertDialog(
                backgroundColor: Color.fromARGB(237, 194, 236, 222),
                title: Text(
                  "Sun",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                content: Text(
                  plantDetails.sunlightDetails,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                ),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: ok,
                  ),
                ],
              ),
            )),
      );

  void OK() {
    Navigator.of(context).pop();
  }

  Future openFertiliserDialog() =>
      showDialog(
        context: context,
        builder: ((context) =>
            Container(
              child: AlertDialog(
                backgroundColor: Color.fromARGB(237, 194, 236, 222),
                title: Text(
                  "Fertilisers",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                content: Text(
                  plantDetails.fertilizationDetails,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                ),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: ok,
                  ),
                ],
              ),
            )),
      );

  void Ok() {
    Navigator.of(context).pop();
  }

  Future openPruningDialog() =>
      showDialog(
        context: context,
        builder: ((context) =>
            Container(
              child: AlertDialog(
                backgroundColor: Color.fromARGB(237, 194, 236, 222),
                title: Text(
                  "Pruning",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                content: Text(
                  plantDetails.pruningDetails,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                ),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: ok,
                  ),
                ],
              ),
            )),
      );

  void o() {
    Navigator.of(context).pop();
  }

  Future opendescDialog() =>
      showDialog(
        context: context,
        builder: ((context) =>
            Container(
              child: AlertDialog(
                backgroundColor: Color.fromARGB(237, 194, 236, 222),
                title: Text(
                  "Description",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                content: SingleChildScrollView(
                  child: Text(
                    plantDetails.description,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: ok,
                  ),
                ],
              ),
            )),
      );

  void oK() {
    Navigator.of(context).pop();
  }
//Column(
//   children: [
//     SizedBox(child: Image.network("https://www.picturethisai.com/image-handle/website_cmsname/image/1080/${plantDetails.image}?x-oss-process=image/format,webp/quality,q_70/resize,l_500&v=1.1"))
//     ,
//
//   ],
}
