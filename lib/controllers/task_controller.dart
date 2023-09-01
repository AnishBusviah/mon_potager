import 'package:get/get.dart';

import '../db/db_helper.dart';
import '../models/task.dart';


class TaskController extends GetxController {
  get selectedTaskImage => null;

  @override
  void onReady() {
    getTask();
    super.onReady();
  }

  final RxList<Task> taskList = List<Task>.empty().obs;

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  Future<void> getTask() async {
    try {
      List<Map<String, dynamic>> tasks = await DBHelper.query();
      taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
    } catch (e) {
      // Handle the error appropriately
      print('Error getting tasks: $e');
    }
  }

  void delete(Task task) {
    DBHelper.delete(task);
    getTask();
  }

  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTask();
  }
}
