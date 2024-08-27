import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todoo/constants/constants.dart';
import 'package:todoo/models/task_list.dart';
import 'package:todoo/models/todo_model.dart';
import 'package:todoo/todo/bloc/todo_bloc.dart';

class TaskDetailPage extends StatefulWidget {
  TaskDetailPage({super.key, required this.task});

  final Task task;

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  // bool isChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TodoBloc>().add(FetchTodosEvent());
  }

  Future<void> showAddTodoDialog(BuildContext context) {
    final TextEditingController _todoController = TextEditingController();
    final TextEditingController _userIdController = TextEditingController();
    bool _completed = false;

    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Add Todo'),
                content: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _todoController,
                          decoration:
                              const InputDecoration(hintText: 'Enter todo'),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _userIdController,
                          keyboardType: TextInputType.number,
                          decoration:
                              const InputDecoration(hintText: 'User ID'),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Completed: '),
                            Checkbox(
                              value: _completed,
                              onChanged: (value) {
                                setState(() {
                                  _completed = value ?? false;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      final todoText = _todoController.text;
                      final userIdText = _userIdController.text;
                      final int userId = int.tryParse(userIdText) ?? 0;

                      if (todoText.isNotEmpty && userId > 0) {
                        context.read<TodoBloc>().add(AddTodoEvent(
                              TodoModel(
                                id: userId,
                                todo: todoText,
                                completed: _completed,
                              ),
                            ));
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Todo title and a valid User ID are required.',
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Add'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: AppBar(
          // toolbarHeight: 150,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100))),
          // flexibleSpace: Container(
          //   decoration: const BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(100),
          //       bottomRight: Radius.circular(100),
          //     ),
          //     color: Colors.yellow,
          //   ),
          // ),
          actions: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.more_vert),
            )
          ],
          surfaceTintColor: Colors.yellow,
          backgroundColor: Colors.yellow,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 5, 0, 0),
                child: ListTile(
                  leading:
                      Icon(widget.task.icon, size: 40, color: Colors.black45),
                  title: Text(
                    widget.task.description,
                    style: subtitleStyle,
                  ),
                  subtitle: Text(
                    widget.task.title,
                    style: titleStyle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: BlocBuilder<TodoBloc, TodoState>(
                  builder: (context, state) {
                    if (state is TodoLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TodoLoaded) {
                      return ListView.builder(
                          itemCount: state.todos.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final todo = state.todos[index];
                            return ListTile(
                              title: Text(todo.todo),
                              leading: Checkbox(
                                value: todo.completed,
                                onChanged: (bool? value) {
                                  context
                                      .read<TodoBloc>()
                                      .add(UpdateTodosEvent(todo.id, value!));
                                  // setState(() {
                                  //   // value = value!;
                                  //   value = value!;
                                  //   // todo.completed = value!;
                                  // });
                                },
                              ),
                              // leading: IconButton(
                              //     onPressed: () {
                              //       context.read<TodoBloc>().add(
                              //           UpdateTodosEvent(
                              //               todo.id, !todo.completed));
                              //     },
                              //     icon: Icon(todo.completed
                              //         ? Icons.check_box
                              //         : Icons.check_box_outline_blank)),
                              trailing: IconButton(
                                  onPressed: () {
                                    context
                                        .read<TodoBloc>()
                                        .add(DeleteTodoEvent(todo.id));
                                  },
                                  icon: Icon(Icons.delete)),
                            );
                          });
                    } else if (state is TodoError) {
                      return Center(child: Text(state.message));
                    }
                    return Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Press the button to load todos',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 5,
          backgroundColor: Colors.green.shade400,
          onPressed: () {
            showAddTodoDialog(context);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          )),
    );
  }
}
