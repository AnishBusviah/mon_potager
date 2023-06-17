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
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "10:00 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

  final List<TaskType> taskTypes = [
    TaskType("Water", Image.asset("assets/water.jpg"), false),
    TaskType("Fertiliser", Image.asset("assets/fertilise.jpg"), false),
    TaskType("Repot", Image.asset("assets/repot.jpg"), false),
    TaskType("Light", Image.asset("assets/light.jpg"), false),
  ];

  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];
  String _selectedRepeat = "None";
  List<String> repeatList = [
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];
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
              MyInputField(
                title: "Title",
                hint: "Enter your title",
                controller: _titleController,
                widget: null,
              ),
              MyInputField(
                title: "Note",
                hint: "Enter your note",
                controller: _noteController,
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
                      title: "Start Time",
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
                  SizedBox(width: 12),
                  Expanded(
                    child: MyInputField(
                      title: "End Time",
                      hint: _endTime,
                      controller: null,
                      widget: IconButton(
                          onPressed: () {
                            _getTime(isStartTime: true);
                          },
                          icon: const Icon(Icons.access_time_rounded,
                              color: Color.fromARGB(255, 173, 236, 180))),
                    ),
                  ),
                ],
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
                title: "Remind",
                hint: "$_selectedRemind minutes early",
                controller: null,
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color.fromARGB(255, 173, 236, 180),
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyles,
                  underline: Container(
                    height: 0,
                  ),
                  items: remindList.map<DropdownMenuItem<String>>(
                    (int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    },
                  ).toList(),
                  onChanged: (String? newvalue) {
                    setState(() {
                      _selectedRemind = int.parse(newvalue!);
                    });
                  },
                ),
              ),
              MyInputField(
                title: "Repeat",
                hint: "$_selectedRepeat",
                controller: null,
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color.fromARGB(255, 173, 236, 180),
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyles,
                  underline: Container(
                    height: 0,
                  ),
                  items: repeatList.map<DropdownMenuItem<String>>(
                    (String? value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child:
                            Text(value!, style: TextStyle(color: Colors.grey)),
                      );
                    },
                  ).toList(),
                  onChanged: (String? newvalue) {
                    setState(() {
                      _selectedRepeat = newvalue!;
                    });
                  },
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CreateTask(label: "Create Task", onTap: () => _validateDate())
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          icon: const Icon(
            Icons.warning_amber_outlined,
            color: Colors.red,
          ));
    }
  }

  _addTaskToDb() async {
    try {
      int value = await _taskController.addTask(
        task: Task(
          note: _noteController.text,
          title: _titleController.text,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime,
          endTime: _endTime,
          todo: taskTypes[
                  taskTypes.indexWhere((element) => element.isChoose == true)]
              .name,
          remind: _selectedRemind,
          repeat: _selectedRepeat,
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
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else {
      setState(() {
        _endTime = _formatedTime;
      });
    }
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
      taskTypes.forEach((taskType) => taskType.isChoose = false);
      taskTypes[taskTypes.indexOf(task)].isChoose = true;
    });
  }
}
