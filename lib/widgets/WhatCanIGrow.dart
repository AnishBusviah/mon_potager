import 'package:flutter/material.dart';
import 'package:mon_potager/widgets/TextToSpeech.dart';


import '../Screens/PlantDetails.dart';
import '../Screens/PlantsInMauritius.dart';
import '../Screens/plantPage2.dart';

class WhatCanIGrow extends StatefulWidget {
  const WhatCanIGrow({Key? key}) : super(key: key);

  @override
  State<WhatCanIGrow> createState() => _WhatCanIGrowState();
}



class _WhatCanIGrowState extends State<WhatCanIGrow> {

  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerMove: (PointerMoveEvent event) {
      print("Reccommendation: ${event.position.dx},${event.position.dy}");
      if ((event.position.dx >= 272 && event.position.dx <= 355) &&
          (event.position.dy >= 518 && event.position.dy <= 522)) {
        if (!spokenSeeMore) {
            speak("click to view more plants");
            spokenSeeMore = true;
        }
      }
    },
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 8 / 9,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onLongPress: () {
                      speak("Plants recommendations");
                      announcedWeather = false;
                      spokenSeeMore=false;
                    },
                    child: Text(
                      "What Can I Grow?",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlantsInMauritius(),
                          ));
                    },
                    child: Row(
                      children: [
                        Text(
                          "See More",
                          style: TextStyle(color: Colors.black),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        )
                      ],
                    ),
                  )),
                ],
              ),
              Container(
                // color: Colors.black,
                child: Container(
                  height: 140,
                  child: ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    // controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onLongPress: (){
                          speak("Mint plant, click to get more info");


                          },
                        child: plantCard(
                            name: "Mint",
                            image:
                                "https://ghk.h-cdn.co/assets/17/50/1600x1200/sd-aspect-1513289879-mint-plant.jpg"),
                      ),
                      SizedBox(width: 12),
                      GestureDetector(
                        onLongPress: (){
                          speak("Tomato plant, click to get more info");

                        },
                        child: plantCard(
                            name: "Tomato",
                            image:
                                "https://www.picturethisai.com/image-handle/website_cmsname/image/1080/317742140130164736.jpeg?x-oss-process=image/format,webp/resize,s_622&v=2"),
                      ),
                      SizedBox(width: 12),
                      GestureDetector(
                        onLongPress: (){
                          speak("Avocado tree, click to get more info");


                        },
                        child: plantCard(
                            name: "Avocado",
                            image:
                                "https://www.picturethisai.com/image-handle/website_cmsname/image/1080/317749875366264832.jpeg?x-oss-process=image/format,webp/resize,s_422&v=1.2"),
                      ),
                      SizedBox(width: 12),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget plantCard({required String name, required String image}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => plantPage2(plantName: name,),));
      },
      // onHorizontalDragUpdate: (DragUpdateDetails details){
      //   speak("${name} plant. Click to get more info");
      //
      // },
      child: Container(
        height: 200,
        width: 200,
        // padding: EdgeInsets.only(top: 100, left: 30),
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Container(
                width: 186 + 14,
                height: 40,
                color: Color.fromRGBO(0, 0, 0, .5),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 10),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
