import 'package:flutter/material.dart';
import 'package:listinha_bloc/bloc/task_bloc.dart';
import 'package:listinha_bloc/bloc/task_event.dart';
import 'package:listinha_bloc/bloc/task_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listinha_bloc/entities/task_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late TaskBloc bloc;

  @override
  void initState() {
    bloc = TaskBloc();
    bloc.add(LoadingTaskEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          children: [
            Text(
              'Listinha',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Adicione tarefas para organizar seu dia a dia',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Titulo da tarefa',
                      border: InputBorder.none,
                    ),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Descrição da tarefa',
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      bloc.add(AddTaskEvent(
                          taskEntity: TaskEntity(
                        title: titleController.text,
                        description: descriptionController.text,
                      )));
                      titleController.clear();
                      descriptionController.clear();
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              ),
            ),
            BlocBuilder<TaskBloc, TaskState>(
              bloc: bloc,
              builder: (context, state) {
                if (state is LoadingTaskState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SucessTaskState) {
                  return ListView.builder(
                    itemCount: state.tasks.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.tasks[index].title),
                        subtitle: Text(state.tasks[index].description),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            bloc.add(DeleteTaskEvent(
                                taskEntity: state.tasks[index]));
                          },
                        ),
                      );
                    },
                  );
                } else if (state is ErrorTaskState) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
