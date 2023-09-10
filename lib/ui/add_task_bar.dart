import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mon_potager/models/Colours.dart';
import 'package:mon_potager/ui/task_type.dart';
import 'package:mon_potager/ui/task_type_card.dart';
import 'package:mon_potager/ui/textstyle.dart';
import 'package:mon_potager/ui/widgets/create_task.dart';
import 'package:mon_potager/ui/widgets/input_field.dart';
import 'package:mon_potager/widgets/TextToSpeech.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'package:sqflite/sqflite.dart';

import '../controllers/task_controller.dart';
import '../models/task.dart';
import '../services/awesome_notification_service.dart';

class AddTaskPage extends StatefulWidget {
  final TaskType? selectedTaskType;
  String? description="";

  AddTaskPage({Key? key, this.selectedTaskType, this.description }  ) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());

  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  String _startTime = DateFormat("HH:mm").format(DateTime.now()).toString();

  final fertiliserIcon =
      "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_fertilizer_title@2x.png?x-oss-process=image/format,webp/resize,s_50&v=1.0";
  final waterIcon =
      "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_water_title@2x.png?x-oss-process=image/format,webp/resize,s_50&v=1.0";
  final pruningIcon =
      "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_pruning_title@2x.png?x-oss-process=image/format,webp/resize,s_50&v=1.0";

  final List<TaskType> taskTypes = [
    TaskType(
        "Fertilser",
        Image.network(
            "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_fertilizer_title@2x.png?x-oss-process=image/format,webp/resize,s_50&v=1.0"),
        false,
        0),
    TaskType(
        "Water",
        Image.network(
            "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_water_title@2x.png?x-oss-process=image/format,webp/resize,s_50&v=1.0"),
        false,
        1),
    TaskType(
        "Pruning",
        Image.network(
            "https://www.picturethisai.com/image-handle/website_cmsname/static/name/c383e7e8de0fce33a82f35fab1a0cb12/img/default_v2/icons/pc/care_images/icon_pruning_title@2x.png?x-oss-process=image/format,webp/resize,s_50&v=1.0"),
        false,
        2),
  ];
  TaskType? selectedTaskType;
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



  bool _listening = false;
  Icon _micIcon = Icon(Icons.mic_none,color: Color.fromARGB(255, 173, 236, 180) );
  SpeechToText speechToText = SpeechToText();

Future<void> _toggleListening() async {
  if(!_listening){

    var available = await speechToText.initialize();

    if(available){
      setState(() {
        _listening = true;
        speak("Listening...");
        _micIcon = Icon(Icons.mic, color: solidGreen,);
        speechToText.listen(
          onResult: (result){
            setState(() {
              _noteController.text = result.recognizedWords;
            });
          }
        );
      });
    }
  }else{
    setState(() {
      _listening = false;
      speak("Recording Stopped!");
      _micIcon = Icon(Icons.mic_none,color: Color.fromARGB(255, 173, 236, 180)
      );});
    speechToText.stop();
  }
}

@override
  void initState() {
    if (widget.description != null){
      _noteController.text = widget.description!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 595+15, left: 310+20),
        child: AvatarGlow(
            endRadius: 25,
            animate: _listening,
            duration: Duration(milliseconds: 2000),
            glowColor: solidGreen,
            repeat: true,
            repeatPauseDuration: Duration(milliseconds: 100),
            showTwoGlows: true,
            child: GestureDetector(
                onTap: _toggleListening,
                child: _micIcon),
      )),
      appBar: _appbar(context, selectedTaskType),
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
                  children:
                      // [Container(child: Column(children: [Image.network(fertiliserIcon), Text("Fertiliser")],),)]
                      <Widget>[
                    ...taskTypes
                        .map((type) => TaskTypeCard(type, taskTypeClick))
                  ],
                ),
              ),
              MyInputField(
                title: "Description",
                hint: "Enter your note",
                controller: _noteController,
                widget: null
                // AvatarGlow(
                //   endRadius: 25,
                //   animate: false,
                //   duration: Duration(milliseconds: 2000),
                //   glowColor: Colors.red,
                //   repeat: true,
                //   repeatPauseDuration: Duration(milliseconds: 100),
                //   showTwoGlows: true,
                //   child: IconButton(
                //     icon: Icon(Icons.mic_none_outlined,
                //         color: Color.fromARGB(255, 173, 236, 180)),
                //     onPressed: () {},
                //   ),
                // ),
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
                mainAxisAlignment: MainAxisAlignment.center,
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

  _validateDate() async {
    var title =
        taskTypes[taskTypes.indexWhere((element) => element.isChoose == true)]
            .name;

    var body = _noteController.text;

    // await NotificationService.showNotification(
    //   title: "Tile of Notif",
    //   body: "Body of Notif",
    // );

    int year = int.parse(DateFormat.y().format(_selectedDate));
    int month = int.parse(DateFormat.M().format(_selectedDate));
    int day = int.parse(DateFormat.d().format(_selectedDate));

    DateTime time = DateFormat.Hm().parse(_startTime);
    int hour = time.hour;
    int minute = time.minute;
    // print("hi${time.hour}",);

    await NotificationService.scheduleNotification(
        title: title,
        body: body,
        day: day,
        month: month,
        year: year,
        hour: hour,
        minute: minute);

    _addTaskToDb();
    Get.back();
  }

  _addTaskToDb() async {
    try {
      int value = await _taskController.addTask(
        task: Task(
          note: _noteController.text,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime,
          todo: taskTypes[
                  taskTypes.indexWhere((element) => element.isChoose == true)]
              .name,
          repeat: _selectedRepeat,
          isCompleted: 0,
        ),
      );
      print('my id is $value');
    } catch (e) {
      print('Error occurred while adding task: $e');
    }
  }

  _appbar(BuildContext context, TaskType? selectedTaskType) {
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
      backgroundColor: const Color.fromRGBO(129, 164, 131, 1),
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
    TimeOfDay currentTime = TimeOfDay.now();

    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: currentTime,
    );
  }

  void taskTypeClick(TaskType task) {
    setState(() {
      taskTypes.forEach((taskType) => taskType.isChoose = false);
      task.isChoose = true;
      selectedTaskType = task;
      print("Selected index in TaskTile: ${task.imageIndex}");
    });
  }
}
