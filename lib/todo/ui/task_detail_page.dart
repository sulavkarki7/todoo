import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoo/constants/constants.dart';
import 'package:todoo/models/task_list.dart';
import 'package:todoo/models/todo_model.dart';
import 'package:todoo/todo/bloc/todo_bloc.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({super.key, required this.task});

  final Task task;

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  String searchQuery = '';
  bool showCompletedOnly = false;
  bool showPendingOnly = false;

  @override
  void initState() {
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

  void _onSearchChanged(String value) {
    setState(() {
      searchQuery = value;
    });
  }

  void _toggleShowCompletedOnly() {
    setState(() {
      showCompletedOnly = !showCompletedOnly;
      showPendingOnly = false;
    });
  }

  void _toggleShowPendingOnly() {
    setState(() {
      showPendingOnly = !showPendingOnly;
      showCompletedOnly = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(100),
              bottomRight: Radius.circular(100),
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.more_vert),
            )
          ],
          surfaceTintColor: Colors.yellow,
          backgroundColor: Colors.yellow,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search Todos...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<TodoBloc>().add(FetchTodosEvent());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                        var todos = state.todos;

                        if (searchQuery.isNotEmpty) {
                          todos = todos
                              .where((todo) => todo.todo
                                  .toLowerCase()
                                  .contains(searchQuery.toLowerCase()))
                              .toList();
                        }

                        if (showCompletedOnly) {
                          todos =
                              todos.where((todo) => todo.completed).toList();
                        } else if (showPendingOnly) {
                          todos =
                              todos.where((todo) => !todo.completed).toList();
                        }

                        double completionPercentage =
                            _getCompletionPercentage(todos);
                        _buildProgressIndicator(completionPercentage);

                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FilterChip(
                                    label: const Text('All'),
                                    selected:
                                        !showCompletedOnly && !showPendingOnly,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        showCompletedOnly = false;
                                        showPendingOnly = false;
                                      });
                                    },
                                  ),
                                  FilterChip(
                                    label: const Text('Completed'),
                                    selected: showCompletedOnly,
                                    onSelected: (bool selected) {
                                      _toggleShowCompletedOnly();
                                    },
                                  ),
                                  FilterChip(
                                    label: const Text('Pending'),
                                    selected: showPendingOnly,
                                    onSelected: (bool selected) {
                                      _toggleShowPendingOnly();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                              itemCount: todos.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final todo = todos[index];
                                return ListTile(
                                  title: Text(todo.todo),
                                  leading: Checkbox(
                                    value: todo.completed,
                                    onChanged: (bool? value) {
                                      context.read<TodoBloc>().add(
                                          UpdateTodosEvent(todo.id, value!));
                                    },
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      context
                                          .read<TodoBloc>()
                                          .add(DeleteTodoEvent(todo.id));
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      } else if (state is TodoError) {
                        return Center(child: Text(state.message));
                      }
                      return const Center(
                        child: Text(
                          'Press the button to load todos',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
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
        child: PopupMenuButton<String>(
          onSelected: (String result) {
            if (result == 'Add Task') {
              showAddTodoDialog(context);
            } else if (result == 'Clear Completed') {
              // Add clear completed logic here
            }
          },
          icon: const Icon(Icons.add),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Add Task',
              child: Text('Add Task'),
            ),
            const PopupMenuItem<String>(
              value: 'Clear Completed',
              child: Text('Clear Completed Tasks'),
            ),
          ],
        ),
      ),
    );
  }

  double _getCompletionPercentage(List<TodoModel> todos) {
    if (todos.isEmpty) {
      return 0.0;
    }
    int completedTasks = todos.where((todo) => todo.completed).length;
    return (completedTasks / todos.length) * 100;
  }

  Widget _buildProgressIndicator(double completionPercentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: completionPercentage / 100,
            backgroundColor: Colors.grey.shade300,
            color: Colors.green.shade400,
            minHeight: 10,
          ),
          const SizedBox(height: 10),
          Text(
            '${completionPercentage.toStringAsFixed(1)}% Completed',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
