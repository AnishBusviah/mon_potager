import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlantDetails extends StatefulWidget {
  PlantDetails({Key? key, required this.plantName}) : super(key: key);
  final String plantName;

  late Map<String, dynamic> plantData;

  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  @override
  void initState() {
    readPlantData(widget.plantName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      // child: Image.network(
                      //     "https://www.picturethisai.com/image-handle/website_cmsname/image/1080/${plantDetails
                      //         .image}?x-oss-process=image/format,webp/quality,q_70/resize,l_500&v=1.1",
                      //     height: 50),
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
                          // openwaterDialog();
                        },
                        child: SizedBox(
                          height: 51+4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(35, 5, 18, 3),
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
                          // opensunDialog();
                        },
                        child: SizedBox(
                          height: 51 +4,
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
                          // openFertiliserDialog();
                        },
                        child: SizedBox(
                          height: 51 +4,
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
                          // openPruningDialog();
                        },
                        child: SizedBox(
                          height: 51 + 4,
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
                    padding: EdgeInsets.fromLTRB(25, 10, 60, 10),
                    height: MediaQuery.of(context).size.height * 4 / 30,
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
                                // text: plantDetails.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
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
                                // text: plantDetails.latinName,
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
                          textAlign: TextAlign.center,
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
                    Expanded(child: InkWell(
                      onTap: () {
                        // opendescDialog();
                      },
                      // child: Text(
                      //   // plantDetails.description,
                      //   style: TextStyle(
                      //     height: 1.9,
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.black,
                      //   ),
                      //   maxLines:
                      //   1, // Limit the number of lines to prevent overflow
                      //   overflow: TextOverflow.ellipsis,
                      // ),
                    ))
                  ],
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
              // Offstage(
              //   child: WebView(
              //     initialUrl:
              //     'https://www.picturethisai.com/care/${plantData
              //         .latinName}.html',
              //     javascriptMode: JavascriptMode.unrestricted,
              //     onWebViewCreated:
              //         (WebViewController webViewController) async {
              //       controller = webViewController;
              //     },
              //     onPageFinished: (_) async {
              //       final sourceHtml =
              //       await controller.runJavascriptReturningResult(
              //           'new XMLSerializer().serializeToString(document)');
              //
              //       getWebsiteData(json.decode(sourceHtml));
              //     },
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Future readPlantData(String plantName) async {
    final plantDataJson =
        await rootBundle.loadString("assets/plants/plantDB.json");
    final decodedPlantData = await jsonDecode(plantDataJson);

    setState(() {
      widget.plantData = decodedPlantData[plantName];
    });

  }
}
