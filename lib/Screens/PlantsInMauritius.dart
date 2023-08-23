import 'package:flutter/material.dart';
import 'package:mon_potager/Screens/plantPage2.dart';

class PlantsInMauritius extends StatelessWidget {
  const PlantsInMauritius({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Plants in Mauritius",
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            GestureDetector(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => plantPage2(plantName: "Mint"),));},
              child: plantCard(
                  name: "Mint",
                  image:
                      "https://ghk.h-cdn.co/assets/17/50/1600x1200/sd-aspect-1513289879-mint-plant.jpg"),
            ),
            GestureDetector(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => plantPage2(plantName: "Tomato"),));},
              child: plantCard(
                  name: "Tomato",
                  image:
                      "https://www.picturethisai.com/image-handle/website_cmsname/image/1080/317742140130164736.jpeg?x-oss-process=image/format,webp/resize,s_422&v=1.2"),
            ),
            GestureDetector(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => plantPage2(plantName: "Avocado"),));},
              child: plantCard(
                  name: "Avocado",
                  image:
                      "https://www.picturethisai.com/image-handle/website_cmsname/image/1080/317749875366264832.jpeg?x-oss-process=image/format,webp/resize,s_422&v=1.2"),
            ),
            GestureDetector(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => plantPage2(plantName: "Red frangipani"),));},
              child: plantCard(
                  name: "Red frangipani",
                  image:
                      "https://www.picturethisai.com/image-handle/website_cmsname/image/1080/154018648262967327.jpeg?x-oss-process=image/format,webp/resize,s_422&v=1.2"),
            ),
            GestureDetector(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => plantPage2(plantName: "Pepper"),));},
              child: plantCard(
                  name: "Pepper",
                  image:
                      "https://www.picturethisai.com/image-handle/website_cmsname/image/1080/317731389827022848.jpeg?x-oss-process=image/format,webp/resize,s_422&v=1.2"),
            ),
            GestureDetector(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => plantPage2(plantName: "Chinese hibiscus"),));},
              child: plantCard(
                  name: "Chinese hibiscus",
                  image:
                      "https://www.picturethisai.com/image-handle/website_cmsname/image/1080/154120121160302616.jpeg?x-oss-process=image/format,webp/resize,s_422&v=1.2"),
            ),
            GestureDetector(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => plantPage2(plantName: "Coconut tree"),));},
              child: plantCard(
                  name: "Coconut tree",
                  image:
                      "https://www.picturethisai.com/image-handle/website_cmsname/image/1080/201174919527104512.jpeg?x-oss-process=image/format,webp/resize,s_422&v=1.2"),
            ),
            GestureDetector(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => plantPage2(plantName: "Madagascar periwinkle"),));},
              child: plantCard(
                  name: "Madagascar periwinkle",
                  image:
                      "https://www.picturethisai.com/image-handle/website_cmsname/image/1080/152618265586171905.jpeg?x-oss-process=image/format,webp/resize,s_422&v=1.2"),
            ),
            GestureDetector(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => plantPage2(plantName: "Banyan fig"),));},
              child: plantCard(
                  name: "Banyan fig",
                  image:
                      "https://www.picturethisai.com/image-handle/website_cmsname/image/1080/201210516216086528.jpeg?x-oss-process=image/format,webp/resize,s_422&v=1.2"),
            ),
            GestureDetector(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => plantPage2(plantName: "Golden trumpet"),));},
              child: plantCard(
                  name: "Golden trumpet",
                  image:
                      "https://www.picturethisai.com/image-handle/website_cmsname/image/1080/201161892891262976.jpeg?x-oss-process=image/format,webp/resize,s_422&v=1.2"),
            ),
          ],
        ));
  }
}

Widget plantCard({required String name, required String image}) {
  return GestureDetector(
    child: Container(
      height: 200,
      width: 200,
      // padding: EdgeInsets.only(top: 100, left: 30),
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 30),
            child: Container(
              width: 186 + 16,
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
