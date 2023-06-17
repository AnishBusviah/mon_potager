import 'package:flutter/material.dart';

class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  String? todo;
  int? remind;
  String? repeat;

  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.todo,
    this.remind,
    this.repeat,
  });
  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    todo = json['todo'];
    remind = json['remind'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['note'] = this.note;
    data['isCompleted'] = this.isCompleted;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['todo'] = this.todo;
    data['remind'] = this.remind;
    data['repeat'] = this.repeat;
    return data;
  }

  String get image {
    switch (this.todo) {
      case "water":
        {
          return ("assets/water.jpg");
        }

      case "Fertiliser":
        {
          return ("assets/fertilise.jpg");
        }

      case "Repot":
        {
          return ("assets/repot.jpg");
        }

      case "Light":
        {
          return ("assets/light.jpg");
        }
      default:
        {
          return ("assets/fertilise.png");
        }
    }
  }
}
