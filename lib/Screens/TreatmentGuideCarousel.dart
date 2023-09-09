import 'dart:math';
import 'package:flutter/material.dart';

import '../models/CareCards.dart';
import '../models/PlantAssessmentResults.dart';
import 'CareDetails.dart';

class TreatmentGuideCarousel extends StatefulWidget {
  PlantAssessmentResults diagnosis;
  TreatmentGuideCarousel(this.diagnosis, {Key? key}) : super(key: key);

  @override
  _TreatmentGuideCarouselState createState() => _TreatmentGuideCarouselState();
}

class _TreatmentGuideCarouselState extends State<TreatmentGuideCarousel> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Treatment treatment = widget.diagnosis.diseases[0].diseaseDetails.treatment;
    List<dynamic> biologicalTreatment = treatment.biological;
    return Container(
      height: 300,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top:10.0),
            child: Center(
              child: Text(widget.diagnosis.diseases[0].diseaseDetails.localName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 30)),
            ),
          ),
          Column(
            children: [
              AspectRatio(
                aspectRatio: 1.1,
                child: PageView.builder(
                    itemCount: biologicalTreatment.length,
                    physics: PageScrollPhysics(),
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: carouselView(index, biologicalTreatment),
                      );
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget carouselView(int index, List<dynamic> biologicalTreatment) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 0.0;
        if (_pageController.position.haveDimensions) {
          value = index.toDouble() - (_pageController.page ?? 0);
          value = (value * 0.038).clamp(-1, 1);
          print("value $value index $index");
        }
        return Transform.rotate(
          angle: pi * value,
          child: carouselCard(biologicalTreatment[index], index),
        );
      },
    );
  }

  Widget carouselCard(String biologicalTreatment, int index) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 400,
              width: 150+25,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: AssetImage(
                        getMatchingImage(biologicalTreatment),
                      ),
                      fit: BoxFit.fitHeight),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        color: Colors.black26)
                  ]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            "Step ${index+1}",
            style: const TextStyle(
                color: Colors.black45,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            biologicalTreatment,
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}


String getMatchingImage(String treatment){
  String fileDirectory = "assets/treatmentGuides/";

  if(treatment.contains("Burn it")){
    return "${fileDirectory}burn.jpg";
  }else if(treatment.contains("Remove weeds")){
    return "${fileDirectory}removeWeeds.jpg";
  }else if(treatment.contains("neem oil")){
    return "${fileDirectory}neemOil.png";
  }else if(treatment.contains("copper-based spray")){
    return "${fileDirectory}copperBasedSpray.jpg";
  }else if(treatment.contains("Replant the plant")){
    return "${fileDirectory}replant.jpg";
  }else if(treatment.contains("Add manure or compost")){
    return "${fileDirectory}compost.jpg";
  }

  return "";
}