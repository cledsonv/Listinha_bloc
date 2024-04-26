import 'package:bloc/bloc.dart';
import 'package:listinha_bloc/bloc/task_event.dart';
import 'package:listinha_bloc/bloc/task_state.dart';
import 'package:listinha_bloc/repositories/task_repository.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final _taskRepo = TaskRepository();

  TaskBloc() : super(InitialTaskState()) {
    on<LoadingTaskEvent>((event, emit) {
      emit(LoadingTaskState());
    });

    on<AddTaskEvent>((event, emit) {
      emit(SucessTaskState(tasks: _taskRepo.addTask(event.taskEntity)));
    });

    on<DeleteTaskEvent>((event, emit) {
      emit(SucessTaskState(tasks: _taskRepo.removeTask(event.taskEntity)));
    });
  }
}
