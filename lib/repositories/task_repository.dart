import 'package:listinha_bloc/entities/task_entity.dart';

class TaskRepository {
  final List<TaskEntity> _task = [];

  List<TaskEntity> addTask(TaskEntity task) {
    _task.add(task);
    return _task;
  }

  List<TaskEntity> removeTask(TaskEntity task) {
    _task.remove(task);
    return _task;
  }
}
