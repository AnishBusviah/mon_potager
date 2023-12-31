import 'package:flutter/material.dart';

import '../ui/task_type.dart';

class TaskTypeCard extends StatelessWidget {
  final TaskType tasktype;
  final Function handler;
  TaskTypeCard(this.tasktype, this.handler);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => handler(tasktype),
          child: Container(
            margin: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: tasktype.isChoose
                  ? Color.fromARGB(255, 123, 214, 208)
                  : Color.fromARGB(255, 31, 107, 87),
            ),
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 5.0,
                ),
                Container(width: 80, height: 60.0, child: tasktype.image),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                    child: Text(
                  tasktype.name,
                  style: TextStyle(
                      color: tasktype.isChoose ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500),
                )),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 15.0,
        )
      ],
    );
  }
}
