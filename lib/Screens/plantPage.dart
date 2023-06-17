import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:mon_potager/models/plantDetailsDisplay.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/searchResponseItem.dart';

class plantPage extends StatefulWidget {
  plantPage(
    this.plantDetailsMap, {
    Key? key,
  }) : super(key: key);

  final Map<String, dynamic> plantDetailsMap;

  @override
  State<plantPage> createState() => _plantPageState();
}

class _plantPageState extends State<plantPage> {
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

    final plantCareInfo = plantCareHtml
        .querySelectorAll(
            '#care_basic_guide_layout > div > div.care-basic-guide-wrapper > div)')
        .map((element) => element.innerHtml.trim())
        .toList();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plant Details"),
      ),
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                //color: Colors.redAccent,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 2 / 5,

                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.network(
                      "https://www.picturethisai.com/image-handle/website_cmsname/image/1080/${plantDetails.image}?x-oss-process=image/format,webp/quality,q_70/resize,l_500&v=1.1"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 250),
                child: DefaultTabController(
                  length: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 2 / 3,
                    child: Column(
                      children: [
                        Container(
                          child: TabBar(
                            tabs: [
                              Tab(
                                child: Text(
                                  "Description",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Plant Care",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(children: [
                            //1st tab
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                  ),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        9 /
                                        10,
                                    child: Text(
                                      plantDetails.name,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      9 /
                                      10,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                      plantDetails.latinName,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),

                                //Description
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        9 /
                                        10,
                                    child: Text(
                                      plantDetails.description,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            //2nd tab
                            DefaultTabController(
                              length: 4,
                              child: Row(
                                children: [
                                  Container(
                                    //color: Colors.redAccent,
                                    width: 0.15 *
                                        MediaQuery.of(context).size.width,
                                    height: 0.45 *
                                        MediaQuery.of(context).size.height,
                                    child: RotatedBox(
                                      quarterTurns: 1,
                                      child: TabBar(
                                        tabs: [
                                          Tab(
                                            icon: RotatedBox(
                                                quarterTurns: 3,
                                                child: Image.network('https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_water_title@2x.png?x-oss-process=image/format,webp/resize,s_40&v=1.0')),
                                          ),
                                          Tab(
                                            icon: RotatedBox(
                                                quarterTurns: 3,
                                                child: Image.network('https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_fertilizer_title@2x.png?x-oss-process=image/format,webp/resize,s_40&v=1.0')),
                                          ),
                                          Tab(
                                            icon: RotatedBox(
                                                quarterTurns: 3,
                                                child: Image.network('https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_sunlight_title@2x.png?x-oss-process=image/format,webp/resize,s_40&v=1.0')),
                                          ),
                                          Tab(
                                            icon: RotatedBox(
                                                quarterTurns: 3,
                                                child: Image.network('https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_pruning_title@2x.png?x-oss-process=image/format,webp/resize,s_40&v=1.0')),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    //color: Colors.blue,
                                    width: 0.85 *
                                        MediaQuery.of(context).size.width,
                                    height: 0.45 *
                                        MediaQuery.of(context).size.height,
                                    child: RotatedBox(
                                        quarterTurns: 1,
                                        child: TabBarView(physics: NeverScrollableScrollPhysics(), children: [
                                          RotatedBox(
                                              quarterTurns: 3,
                                              child: PageView(scrollDirection: Axis.vertical, children: [
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 15, right: 250),
                                                      child: Text("Water", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                                    ),
                                                    Expanded(
                                                      child: SingleChildScrollView(
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 8, left: 15, right: 20),
                                                          child: Text(plantDetails.waterDetails, textAlign: TextAlign.justify,
                                                            style: TextStyle(
                                                                fontSize: 22,
                                                                fontWeight: FontWeight.w400),),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],)),
                                          RotatedBox(
                                              quarterTurns: 3,
                                              child: PageView(scrollDirection: Axis.vertical, children: [
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 15, right: 200),
                                                      child: Text("Fertilizer", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                                    ),
                                                    Expanded(
                                                      child: SingleChildScrollView(
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 8, left: 15, right: 20),
                                                          child: Text(plantDetails.fertilizationDetails, textAlign: TextAlign.justify,
                                                            style: TextStyle(
                                                                fontSize: 22,
                                                                fontWeight: FontWeight.w400),),
                                                        ),
                                                      ),
                                                    ),
                                                  ]
                                                ),
                                              ],)),RotatedBox(
                                              quarterTurns: 3,
                                              child: PageView(scrollDirection: Axis.vertical, children: [
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 15, right: 210),
                                                      child: Text("Sunlight", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                                    ),
                                                    Expanded(
                                                      child: SingleChildScrollView(
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 8, left: 15, right: 20),
                                                          child: Text(plantDetails.sunlightDetails, textAlign: TextAlign.justify,
                                                            style: TextStyle(
                                                                fontSize: 22,
                                                                fontWeight: FontWeight.w400),),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],)),
                                          RotatedBox(
                                              quarterTurns: 3,
                                              child: PageView(scrollDirection: Axis.vertical, children: [
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 15, right: 215),
                                                      child: Text("Pruning", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                                    ),
                                                    Expanded(
                                                      child: SingleChildScrollView(
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 8, left: 15, right: 20),
                                                          child: Text(plantDetails.pruningDetails, textAlign: TextAlign.justify,
                                                            style: TextStyle(
                                                                fontSize: 22,
                                                                fontWeight: FontWeight.w400),),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],)),
                                        ])),
                                  )
                                ],
                              ),
                            )
                          ]),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Offstage(
            child: WebView(
              initialUrl:
                  'https://www.picturethisai.com/care/${plantData.latinName}.html',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) async {
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

      //Column(
      //   children: [
      //     SizedBox(child: Image.network("https://www.picturethisai.com/image-handle/website_cmsname/image/1080/${plantDetails.image}?x-oss-process=image/format,webp/quality,q_70/resize,l_500&v=1.1"))
      //     ,
      //
      //   ],
    );
  }
}
