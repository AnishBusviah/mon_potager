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
    List<dynamic> treatment = widget.diagnosis.diseases[0].diseaseDetails.treatment.biological;
    return Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(40.0),
                child: Center(
                  child: Text("Treatment Guide",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 30)),
                ),
              ),
              AspectRatio(
                aspectRatio: 1,
                child: PageView.builder(
                    itemCount: treatment.length,
                    physics: PageScrollPhysics(),
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: carouselView(index, treatment),
                      );
                    }),
              )
            ],
          ),
        ));
  }

  Widget carouselView(int index, List<dynamic> treatment) {
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
          child: carouselCard(treatment[index], index),
        );
      },
    );
  }

  Widget carouselCard(String treatment, int index) {
    return Column(
      children: <Widget>[
        // Expanded(
        //   child: Padding(
        //     padding: const EdgeInsets.all(20.0),
        //     child: Hero(
        //       tag: data.imageName,
        //       child: GestureDetector(
        //         onTap: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => DetailsScreen(data: data)));
        //         },
        //         child: Container(
        //           decoration: BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.circular(30),
        //               image: DecorationImage(
        //                   image: AssetImage(
        //                     data.imageName,
        //                   ),
        //                   fit: BoxFit.fill),
        //               boxShadow: const [
        //                 BoxShadow(
        //                     offset: Offset(0, 4),
        //                     blurRadius: 4,
        //                     color: Colors.black26)
        //               ]),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
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
            treatment,
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
