import 'package:flutter/material.dart';
import 'package:mon_potager/models/PlantAssessmentResults.dart';

class DiagnosisResultsScreen extends StatefulWidget {
  PlantAssessmentResults diagnosis;

  DiagnosisResultsScreen(this.diagnosis, {Key? key}) : super(key: key);

  @override
  State<DiagnosisResultsScreen> createState() => _DiagnosisResultsScreenState();
}

class _DiagnosisResultsScreenState extends State<DiagnosisResultsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              child: Center(
                  child: Text(
                "Image",
                style: TextStyle(fontSize: 50),
              )),
              color: Colors.red,
              height: 1 / 3 * MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              child: results(widget.diagnosis, screenWidth, screenHeight),
              color: Colors.blue,
              height: 0.636 * MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }
}

PageView results(
    PlantAssessmentResults diagnosis, double screenWidth, double screenHeight) {
  return PageView(
    children: [
      Column(
        children: [
          Text(
            "Results",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Text(
                "Name: ",
                style: dataStyle(isTitle: true),
              ),
              Text(
                diagnosis.diseases[0].diseaseDetails.localName,
                style: dataStyle(isTitle: false),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description: ",
                style: dataStyle(isTitle: true),
              ),
              Container(
                  color: Colors.red,
                  width: 2 / 3 * screenWidth,
                  child: Text(
                    diagnosis.diseases[0].diseaseDetails.description,
                    softWrap: true,
                    style: dataStyle(isTitle: false),textAlign: TextAlign.left,
                  ))
            ],
          )
        ],
      ),
    ],
  );
}

TextStyle dataStyle({required bool isTitle}) {
  if (isTitle)
    return TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  else
    return TextStyle(fontSize: 20, wordSpacing: 5,);
}
