import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/task.dart';
import '../task_type.dart';

class TaskTile extends StatelessWidget {
  final Task? task;
  final TaskType? selectedTaskType;
  final String? todo;

  TaskTile({
    required this.task,
    required this.selectedTaskType,
    required this.todo,
    // required this.selectedImageIndex0,
    // required this.selectedImageIndex1,
    // required this.selectedImageIndex2,
  });

  @override
  Widget build(BuildContext context) {
    print("Selected index in TaskTile: ${selectedTaskType?.imageIndex}");
    print("Is selected: ${selectedTaskType?.isChoose}");

    final selectedImageIndex;

    if(todo == "Fertilser"){
      selectedImageIndex = 0;
    }else if(todo == "Water"){
      selectedImageIndex = 1;
    }else if(todo == "Pruning"){
      selectedImageIndex = 2;
    }else selectedImageIndex = 4;


    return Container(
      width: 350+25,
      height: 140,
      padding: const EdgeInsets.fromLTRB(30, 20-2, 15, 30),
      margin: const EdgeInsets.only(
        bottom: 12,
        left: 20,
        right: 0
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
      child: SizedBox(
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
                      selectedImageIndex == 4? SizedBox() :
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child:  Image.network(
                            task?.imageUrls?[selectedImageIndex] ?? '',
                            fit: BoxFit.cover,
                            width: 60,
                            height: 50,
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
                          const SizedBox(width: 5, height: 5),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 4-4, right: 25, left: 0,),
                            child: Container(
                              padding: EdgeInsets.all(0),
                              width: 150,
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
