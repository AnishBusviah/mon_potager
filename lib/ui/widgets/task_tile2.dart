import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/task.dart';
import '../task_type.dart';

class TaskTile2 extends StatelessWidget {
  final Task? task;

  final TaskType? selectedTaskType;

  TaskTile2({required this.task, required this.selectedTaskType});
  @override
  Widget build(BuildContext context) {
    print("Selected index in TaskTile: ${selectedTaskType?.imageIndex}");
    print("Is selected: ${selectedTaskType?.isChoose}");
    final selectedImageIndex = selectedTaskType?.imageIndex ?? 0;
    return Container(
      width: 350,
      height: 140,
      padding: const EdgeInsets.fromLTRB(30, 20, 20, 30),
      margin: const EdgeInsets.only(
        bottom: 12,
        left: 20,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        color: Color.fromARGB(255, 62, 182, 158),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12,
                  width: 26,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (task?.imageUrls != null && task!.imageUrls!.isNotEmpty)
                      Flexible(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              // Container for displaying the first image based on selected index
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                    child: Image.network(
                                  task?.imageUrls?[1] ?? '',
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: 50,
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(width: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey[200],
                              size: 20,
                            ),
                            SizedBox(width: 14),
                            Text(
                              "${task!.startTime}",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 15, color: Colors.grey[100]),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8, height: 5),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4, right: 25, left: 25), // Add top padding
                          child: Text(
                            task?.note ?? "",
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Container(
            height: 100,
            width: 2.0,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          SizedBox(width: 10),
          Center(
            child: RotatedBox(
              quarterTurns: 0,
              child: task!.isCompleted == 1
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 40,
                    )
                  : Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 245, 242, 241),
                      size: 40,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getImage(int? image) {
    switch (image) {
      case 1:
        return Image.network(
          "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_fertilizer_title@2x.png?x-oss-process=image/format,webp/resize,s_25&v=1.0",
          fit: BoxFit.cover,
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
