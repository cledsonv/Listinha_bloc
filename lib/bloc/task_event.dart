import 'package:listinha_bloc/entities/task_entity.dart';

abstract class TaskEvent {}

class LoadingTaskEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final TaskEntity taskEntity;

  AddTaskEvent({required this.taskEntity});
}

class DeleteTaskEvent extends TaskEvent {
  final TaskEntity taskEntity;

  DeleteTaskEvent({required this.taskEntity});
}
