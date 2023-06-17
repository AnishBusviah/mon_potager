import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:mon_potager/models/plantDetailsDisplay.dart';

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



  Future<void> getPlantData(Map<String, dynamic> plantMap) async {
    final plantData = new searchResult.fromJson(plantMap);

    plantDetails = new plantDetailsDisplay();

    plantDetails.setName(plantData.commonName);
    plantDetails.setImage(plantData.thumbnail);
    plantDetails.setLatinName(plantData.latinName);

    final url =
    Uri.parse("https://www.picturethisai.com/wiki/${plantDetails.latinName}.html");
    final response = await http.get(url);

    dom.Document html = dom.Document.html(response.body);

    final plantDescription = html
        .querySelectorAll(
        '#about_layout > div > div.header > div.basic-information > div.basic-information-description > div')
        .map((element) => element.innerHtml.trim()).toList();




    final scientificName = html
        .querySelectorAll(
        '#about_layout > div > div.header > div.basic-information > div.basic-information-latin-name')
        .map((element) => element.innerHtml.trim()).toList();


    final plantCareUrl = Uri.parse("https://www.picturethisai.com/care/${plantDetails.latinName}.html#Cultivation:FertilizerDetail");
    final plantCareResponse = await http.get(plantCareUrl);

    dom.Document plantCareHtml = dom.Document.html(plantCareResponse.body);


    final waterInfo = plantCareHtml
        .querySelectorAll(
        '#care_basic_guide_layout > div > div.care-basic-guide-wrapper > div:nth-child(1) > div.care-common-field-item > div.care-common-field-content-wrapper.field-content-selected > div.care-common-field-values-part > div:nth-child(1) > div > strong')
        .map((element) => element.innerHtml.trim());

    print(waterInfo);


    final sunInfo = html
        .querySelectorAll(
        '#about_layout > div > div.header > div.basic-information > div.basic-information-items > div:nth-child(2) > div > div.basic-information-item-content-title')
        .map((element) => element.innerHtml.trim());

    print(sunInfo);





    //print(plantDetails.description);



    setState(() {
      plantDetails.setDescription(plantDescription[0].toString());
      plantDetails.setLatinName(scientificName[0].toString());
    });





    final plantImage = html.querySelectorAll('#about_layout > div > div.header > div.cover-wrap > div.sub-images > div:nth-child(1) > img').map((element) => element.attributes['data-src']).toList();




    //
    //
    //
    // print(url);
    // print(plantDescription);
    // print(plantImage);
    // print(name);
    // print(latinName);



  }


  @override
  void initState() {
    getPlantData(widget.plantDetailsMap);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(title: Text("Plant Details"),),
      body: Column(
        children: [
          SizedBox(child: Image.network(
                  "https://www.picturethisai.com/image-handle/website_cmsname/image/1080/${plantDetails.image}?x-oss-process=image/format,webp/quality,q_70/resize,l_500&v=1.1"))
          ,Text(plantDetails.name), Text(plantDetails.latinName), Text(plantDetails.description)

        ],
      ),
    );
  }


  Future<Widget> textDescription() async {
    return Text(await plantDetails.description);
  }
}
