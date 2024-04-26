import 'package:listinha_bloc/entities/task_entity.dart';

abstract class TaskState {
  List<TaskEntity> tasks;

  TaskState({required this.tasks});
}

class InitialTaskState extends TaskState {
  InitialTaskState() : super(tasks: []);
}

class LoadingTaskState extends TaskState {
  LoadingTaskState() : super(tasks: []);
}

class SucessTaskState extends TaskState {
  SucessTaskState({required List<TaskEntity> tasks}) : super(tasks: tasks);
}

class ErrorTaskState extends TaskState {
  final String message;

  ErrorTaskState({required this.message}) : super(tasks: []);
}
