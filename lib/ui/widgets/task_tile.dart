import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mon_potager/models/task.dart';
import 'package:mon_potager/ui/add_task_bar.dart';
import 'package:mon_potager/ui/task_type.dart';


class TaskTile extends StatelessWidget {
  final Task? task;

  final TaskType? selectedTaskType;

  TaskTile({required this.task, required this.selectedTaskType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      height: 140,
      padding: EdgeInsets.fromLTRB(30, 20, 20, 30),
      margin: EdgeInsets.only(
        bottom: 12,
        left: 20,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25)),
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 123, 214, 208),
          Color.fromARGB(255, 31, 107, 87),
        ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                selectedTaskType?.image ?? Container(),
                const SizedBox(width: 12),
                Text(
                  task?.title ?? "",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (selectedTaskType != null) selectedTaskType!.image,
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${task!.startTime}",
                      style: GoogleFonts.lato(
                        textStyle:
                        TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task!.isCompleted == 1 ? "COMPLETED" : "TODO",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getBGImage(int? image) {
    switch (image) {
      case 1:
        return Image.network(
          "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_fertilizer_title@2x.png?x-oss-process=image/format,webp/resize,m_25&v=1.0",
          fit: BoxFit.cover,
          scale: 0.5,
        );
      case 2:
        return Image.network(
          "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_water_title@2x.png?x-oss-process=image/format,webp/resize,s_25&v=1.0",
          fit: BoxFit.cover,
        );
      case 3:
        return Image.network(
            "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_sunlight_title@2x.png?x-oss-process=image/format,webp/resize,s_25&v=1.0");
      default:
        return Image.network(
          "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_pruning_title@2x.png?x-oss-process=image/format,webp/resize,s_28&v=1.0",
          fit: BoxFit.cover,
        );
    }
  }
}
