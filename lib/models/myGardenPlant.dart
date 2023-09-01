import 'package:flutter/material.dart';

class MyPlant {
  // int id = 0;
  String name = "";
  String latinName = "";
  String sun = "";
  String water = "";
  String image = "";
  String plantID = "";


  MyPlant({
    // required this.id,
    required this.name,
    required this.latinName,
    required this.sun,
    required this.water,
    required this.image,
    required this.plantID,
  });
  MyPlant.fromJson(Map<String, dynamic> json, String ID) {
    name = json['name'];
    latinName = json['latinName'];
    sun = json['sun'];
    water = json['water'];
    image = json['image'];
    plantID = ID;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['latinName'] = this.latinName;
    data['sun'] = this.sun;
    data['water'] = this.water;
    data['image'] = this.image;
    return data;
  }

  // String get image {
  //   switch (this.todo) {
  //     case "water":
  //       {
  //         return ("assets/water.jpg");
  //       }
  //
  //     case "Fertiliser":
  //       {
  //         return ("assets/fertilise.jpg");
  //       }
  //
  //     case "Repot":
  //       {
  //         return ("assets/repot.jpg");
  //       }
  //
  //     case "Light":
  //       {
  //         return ("assets/light.jpg");
  //       }
  //     default:
  //       {
  //         return ("assets/fertilise.png");
  //       }
  //   }
  // }
}
