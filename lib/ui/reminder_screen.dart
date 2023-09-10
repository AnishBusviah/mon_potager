import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mon_potager/models/Colours.dart';
import 'package:mon_potager/ui/textstyle.dart';
import 'package:mon_potager/ui/widgets/task_tile.dart';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../controllers/task_controller.dart';
import '../models/task.dart';


import 'add_task_bar.dart';
import 'widgets/button.dart';

class ReminderScreen extends StatefulWidget {
   ReminderScreen({super.key,});



  @override
  // ignore: library_private_types_in_public_api
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {

  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());

  @override
  void initState() {
    _taskController.getTask();
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        child: FloatingActionButton(
          shape: CircleBorder(),
            
          onPressed: () async {
            await Get.to(() =>  AddTaskPage());
            _taskController.getTask();
          },
          child: Icon(Icons.add),
          backgroundColor: solidGreen,
        ),
      ),
      appBar: _appbar(),
      body: Column(
        children: [
          _addtask(),
          _addDatebar(),
          SizedBox(
            height: 12,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  _showTasks() {
    print(_taskController.taskList);
    return Expanded(
      child: Obx(
        () {
          final taskList = _taskController.taskList;
          if (taskList.isEmpty) {
            return const Center(
              child: Text(
                'No tasks available',
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: _taskController.taskList.length,
            itemBuilder: (context, index) {
              Task task = _taskController.taskList[index];
              print(task.toJson());
              // if (task.repeat == 'Daily' ||
              //     task.repeat == 'Weekly' ||
              //     task.repeat == 'Monthly') {
              //   DateTime date =
              //       DateFormat.Hm().parse(task.startTime.toString());
              //
              //   var myTime = DateFormat("HH:mm").format(date);
              //   notifyHelper.scheduledNotification(
              //       11, 09, task);
              //   var selectedTaskType;
              //   return AnimationConfiguration.staggeredList(
              //     position: index,
              //     child: SlideAnimation(
              //       child: FadeInAnimation(
              //         child: Row(
              //           children: [
              //             GestureDetector(
              //                 onTap: () {
              //                   _showBottomSheet(context, task);
              //                 },
              //                 child: TaskTile(
              //                   task: task,
              //                   selectedTaskType: selectedTaskType,
              //                   todo: task.todo,
              //                   // selectedImageIndex1: 1,
              //                   // selectedImageIndex2: 2,
              //                   // selectedImageIndex0: 0,
              //                 )),
              //           ],
              //         ),
              //       ),
              //     ),
              //   );
              // }
              if (task.date == DateFormat.yMd().format(_selectedDate)) {

                var selectedTaskType;
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  _showBottomSheet(context, task);
                                },
                                child: TaskTile(
                                  task: task,
                                  selectedTaskType: selectedTaskType,
                                  todo: task.todo,
                                  // selectedImageIndex1: 1,
                                  // selectedImageIndex2: 2,
                                  // selectedImageIndex0: 0,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 123, 214, 208),
            Color.fromARGB(255, 31, 107, 87),
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
            ),
            Spacer(),
            task.isCompleted == 1
                ? Container()
                : _bottomSheetbutton(
                    label: "Task Completed",
                    onTap: () {
                      _taskController.markTaskCompleted(task.id!);
                      Get.back();
                    },
                    color: Color.fromRGBO(93, 215, 173, 0.493),
                    context: context,
                  ),
            _bottomSheetbutton(
              label: "Delete Task",
              onTap: () {
                _taskController.delete(task);

                Get.back();
              },
              color: Color.fromRGBO(232, 137, 130, 0.493),
              context: context,
            ),
            SizedBox(
              height: 20,
            ),
            _bottomSheetbutton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              color: Color.fromRGBO(250, 251, 251, 0.493),
              isClose: true,
              context: context,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  _bottomSheetbutton({
    required String label,
    required Function()? onTap,
    required Color color,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          height: 55,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: isClose == true
                    ? Color.fromRGBO(250, 251, 251, 0.493)
                    : color),
            borderRadius: BorderRadius.circular(20),
            color:
                isClose == true ? Color.fromRGBO(250, 251, 251, 0.493) : color,
          ),
          child: Center(
            child: Text(label,
                style: isClose
                    ? titleStyles
                    : titleStyles.copyWith(color: Colors.black)),
          )),
    );
  }

  _addDatebar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor:pageTitleColour,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _addtask() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyles,
                ),
                Text(
                  "Today",
                  style: headingStyles,
                )
              ],
            ),
          ),
          // Button(
          //     label: "+ ",
          //     onTap: () async {
          //       await Get.to(() => const AddTaskPage());
          //       _taskController.getTask();
          //     }),
        ],
      ),
    );
  }

  _appbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Reminder',
          style: TextStyle(color: Colors.black, fontSize: 25)),
      centerTitle: true,
      flexibleSpace: Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsetsDirectional.fromSTEB(60, 50, 60, 25),
        padding: const EdgeInsets.all(60.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 222, 240, 224),
            Color.fromARGB(255, 222, 240, 224)
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
      ),
      actions: <Widget>[
        // IconButton(
        //     icon: const Icon(Icons.close, color: Colors.black),
        //     onPressed: () {})
      ],
      backgroundColor: Color.fromRGBO(129, 164, 131, 1),
      toolbarHeight: 100,
      leading: GestureDetector(
        onTap: () {

//notifyHelper.scheduledNotification();
        },
        // child: const Icon(
        //   Icons.arrow_back_ios,
        //   color: Colors.black,
        ),
      );
  }
}