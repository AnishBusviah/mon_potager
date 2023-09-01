
import 'package:mon_potager/ui/task_type.dart';

import '../models/task.dart';

class TaskWithSelectedType {
  final Task task;
  final TaskType? selectedTaskType;

  TaskWithSelectedType({
    required this.task,
    required this.selectedTaskType,
  });
}
