import 'package:flutter/material.dart';

class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;

  String? todo;

  String? repeat;
  List<String>? imageUrls;

  Task({
    this.id,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.todo,
    this.repeat,
    this.imageUrls,
  });
  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];

    todo = json['todo'];

    repeat = json['repeat'];
    imageUrls = [
      "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_fertilizer_title@2x.png?x-oss-process=image/format,webp/resize,s_50&v=1.0",
      "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_water_title@2x.png?x-oss-process=image/format,webp/resize,s_50&v=1.0",
      "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_pruning_title@2x.png?x-oss-process=image/format,webp/resize,s_50&v=1.0"
    ];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;

    data['note'] = this.note;
    data['isCompleted'] = this.isCompleted;
    data['date'] = this.date;
    data['startTime'] = this.startTime;

    data['todo'] = this.todo;
    data['imageUrls'] = this.imageUrls;

    data['repeat'] = this.repeat;
    return data;
  }
}
