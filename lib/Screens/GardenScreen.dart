import "dart:convert";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:mon_potager/models/Colours.dart";
import "package:mon_potager/models/GardenCard.dart";

import "../Navigation.dart";
import "../models/myGardenPlant.dart";

class MyGarden extends StatefulWidget {
  const MyGarden({Key? key}) : super(key: key);

  @override
  State<MyGarden> createState() => _MyGardenState();
}

class _MyGardenState extends State<MyGarden> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CameraRoute("Identify Plant")),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Color.fromARGB(500, 36, 139, 88),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height * 1 / 9,
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
            flexibleSpace: Container(
              color: Color.fromRGBO(129, 164, 131, 1),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1 / 9,
              child: Center(
                child: Container(
                  height: 50,
                  width: 270,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 222, 240, 224),
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Text(
                      "My Garden",
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: StreamBuilder<List<MyPlant>>(
            stream: readPlants(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              } else if (snapshot.hasData) {
                final myPlants = snapshot.data!;
                return SafeArea(
                  child: Column(
                    children: [
                      // Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     height: MediaQuery.of(context).size.height * 5/7,
                      //     child: Center(child: Text("No plants added",  style: TextStyle(fontSize: 20),),))

                      // ListView(
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.only(top: 20),
                      //       child: Container(
                      //         padding: EdgeInsets.only(top: 10),
                      //         decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           borderRadius: BorderRadius.all(
                      //             Radius.circular(15),
                      //           ),
                      //           boxShadow: [
                      //             BoxShadow(
                      //               blurRadius: 4,
                      //               color: Color(0xBE43A56E),
                      //               offset: Offset(0, 2),
                      //             )
                      //           ],
                      //         ),
                      //         // padding: EdgeInsets.only(top: 10),
                      //         // color: Colors.red,
                      //         width: 350 + 20,
                      //         height: 173 + 20,
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //           crossAxisAlignment: CrossAxisAlignment.end,
                      //           children: [
                      //             new Flexible(
                      //               child: Container(
                      //                 // color: Colors.red,
                      //                 child: Row(
                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                      //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //                   children: [
                      //                     new Flexible(
                      //                       child: ClipRRect(
                      //                           borderRadius: BorderRadius.circular(5),
                      //                           child: Image.asset(
                      //                             "assets/plants/monstera.jpg",
                      //                             width: 123,
                      //                             height: 125,
                      //                             fit: BoxFit.fill,
                      //                           )),
                      //                     ),
                      //                     new Flexible(
                      //                       child: Padding(
                      //                         padding: const EdgeInsets.only(bottom: 25),
                      //                         child: Container(
                      //                           height: 100 + 10,
                      //                           // color: Colors.red,
                      //                           child: Column(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment.spaceEvenly,
                      //                             crossAxisAlignment: CrossAxisAlignment.start,
                      //                             children: [
                      //                               new Flexible(
                      //                                 child: Text(
                      //                                   'Monstera Plant',
                      //                                   style: TextStyle(
                      //                                     // fontFamily: 'Readex Pro',
                      //                                     color: Color(0xBE43A56E),
                      //                                     fontSize: 20,
                      //                                     fontWeight: FontWeight.bold,
                      //                                   ),
                      //                                 ),
                      //                               ),
                      //                               Row(
                      //                                 mainAxisAlignment:
                      //                                     MainAxisAlignment.spaceBetween,
                      //                                 children: [
                      //                                   new Flexible(
                      //                                     child: Icon(
                      //                                       Icons.sunny,
                      //                                       color: Colors.yellow,
                      //                                       size: 20,
                      //                                     ),
                      //                                   ),
                      //                                   new Flexible(
                      //                                     child: Padding(
                      //                                       padding: const EdgeInsets.only(left: 5),
                      //                                       child: Text(
                      //                                         "Max 8 hours per day",
                      //                                         style: TextStyle(fontSize: 12),
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                               Row(
                      //                                 children: [
                      //                                   new Flexible(
                      //                                     child: Icon(
                      //                                       Icons.water_drop,
                      //                                       color: Colors.blue,
                      //                                       size: 20,
                      //                                     ),
                      //                                   ),
                      //                                   new Flexible(
                      //                                     child: Padding(
                      //                                       padding: const EdgeInsets.only(left: 5),
                      //                                       child: Text(
                      //                                         "Every 1-2 weeks",
                      //                                         style: TextStyle(
                      //                                             fontSize: 12,
                      //                                             fontFamily: 'Readex Pro'),
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               )
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     new Flexible(
                      //                       child: IconButton(
                      //                           onPressed: () {}, icon: Icon(Icons.more_vert)),
                      //                     )
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //             Container(
                      //                 padding: EdgeInsets.all(0),
                      //                 // color: Colors.blue,
                      //                 child: Row(
                      //                   mainAxisAlignment: MainAxisAlignment.end,
                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                      //                   children: [
                      //                     IconButton(
                      //                         onPressed: () {},
                      //                         icon: Icon(Icons.playlist_add, color: Color.fromRGBO(116, 118, 120, 1),)),
                      //                   ],
                      //                 ))
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     GardenCard(),
                      //     GardenCard(),
                      //   ],
                      // ),
                      Expanded(
                          child: ListView(
                        children: myPlants.map(buildMyGarden).toList(),
                      ))
                      // Expanded(
                      //     child: ListView(
                      //       padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      //       children: [
                      //         GardenCard(
                      //           plantImage: "assets/plants/monstera.jpg",
                      //           plantName: 'Monstera Plant',
                      //           sun: "Max 8 hours per day",
                      //           water: "Every 1-2 weeks",
                      //           latinName: "Monstera deliciosa Liebm",
                      //         ),
                      //         GardenCard(
                      //           plantImage: "assets/plants/snake_plant.jpg",
                      //           plantName: 'Snake Plant',
                      //           sun: "Full Sun",
                      //           water: "Every 2 weeks",
                      //           latinName: "Dracaena trifasciata",
                      //         ),
                      //         GardenCard(
                      //           plantImage: "assets/plants/aloevera.jpg",
                      //           plantName: 'Aloe Vera Plant',
                      //           sun: "6 hours per day",
                      //           water: "Every 2-3 weeks",
                      //           latinName: "Aloe vera",
                      //         ),
                      //         GardenCard(
                      //           plantImage: "assets/plants/cactus.jpeg",
                      //           plantName: 'Cactus Plant',
                      //           sun: "Full Sun",
                      //           water: "Every 10 days",
                      //           latinName: "Cactaceae",
                      //         ),
                      //       ],
                      //     ))
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}

Stream<List<MyPlant>> readPlants() =>
    FirebaseFirestore.instance.collection("myPlants").snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => MyPlant.fromJson(doc.data(), doc.id))
              .toList(),
        );

Widget buildMyGarden(MyPlant myPlant) => Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: GardenCard(
        plantName: myPlant.name,
        latinName: myPlant.latinName,
        sun: myPlant.sun,
        water: myPlant.water,
        plantImage: myPlant.image,
        plantID: myPlant.plantID,
      ),
    );
