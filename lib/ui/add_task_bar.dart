import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mon_potager/controllers/task_controller.dart';
import 'package:mon_potager/models/task.dart';
import 'package:mon_potager/ui/task_type.dart';
import 'package:mon_potager/ui/textstyle.dart';
import 'package:mon_potager/ui/widgets/create_task.dart';
import 'package:mon_potager/ui/widgets/input_field.dart';
import 'package:mon_potager/ui/task_type_card.dart';
import 'package:sqflite/sqflite.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  final List<TaskType> taskTypes = [
    TaskType(
        "Fertilser",
        Image.network(
            "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_fertilizer_title@2x.png?x-oss-process=image/format,webp/resize,s_25&v=1.0"),
        false),
    TaskType(
        "Water",
        Image.network(
            "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_water_title@2x.png?x-oss-process=image/format,webp/resize,s_25&v=1.0"),
        false),
    TaskType(
        "Sunlight",
        Image.network(
            "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_sunlight_title@2x.png?x-oss-process=image/format,webp/resize,s_25&v=1.0"),
        false),
    TaskType(
        "Pruning",
        Image.network(
            "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_pruning_title@2x.png?x-oss-process=image/format,webp/resize,s_28&v=1.0"),
        false),
  ];
  TaskType? selectedTaskType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: headingStyles,
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: FittedBox(
                    child: Text("To do", style: titleStyles),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ...taskTypes
                        .map((type) => TaskTypeCard(type, taskTypeClick))
                  ],
                ),
              ),
              MyInputField(
                title: "Description",
                hint: "Enter your title",
                controller: _titleController,
                widget: null,
              ),
              MyInputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                controller: null,
                widget: IconButton(
                  icon: const Icon(Icons.calendar_today_outlined,
                      color: Color.fromARGB(255, 173, 236, 180)),
                  onPressed: () {
                    print("Cicked");
                    _getDate();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "Reminder",
                      hint: _startTime,
                      controller: null,
                      widget: IconButton(
                          onPressed: () {
                            _getTime(isStartTime: true);
                          },
                          icon: Icon(Icons.access_time_rounded,
                              color: Color.fromARGB(255, 173, 236, 180))),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CreateTask(
                    label: "Create Task",
                    onTap: () {_creatTask();},
                    // onTap: () => _validateDate()
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          icon: const Icon(
            Icons.warning_amber_outlined,
            color: Colors.red,
          ));
    }
  }

  _creatTask() {
    _addTaskToDb();
    Get.back();
  }

  _addTaskToDb() async {
    try {
      int value = await _taskController.addTask(
        task: Task(
          title: _titleController.text,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime,
          isCompleted: 0,
        ),
      );
      print('my id is $value');
    } catch (e) {
      print('Error occurred while adding task: $e');
    }
  }

  _appbar(BuildContext context) {
    return AppBar(
      title: const Text('Task',
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
      backgroundColor: const Color.fromARGB(255, 26, 142, 136),
      toolbarHeight: 100,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
    );
  }

  _getDate() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2026),
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
        print(_selectedDate);
      });
    } else {
      print("It's null");
    }
  }

  _getTime({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("time cancel");
    } else {
      setState(() {
        _startTime = _formatedTime;
      });
    }
    ;
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split("")[0]),
      ),
    );
  }

  void taskTypeClick(TaskType task) {
    setState(() {
      if (selectedTaskType == task) {
        selectedTaskType = null;
      } else {
        selectedTaskType = task;
      }

      taskTypes.forEach((taskType) => taskType.isChoose = false);
      taskTypes[taskTypes.indexOf(task)].isChoose = true;
    });
  }
}
