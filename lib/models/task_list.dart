import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:todoo/constants/constants.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class Task {
  final String title;
  final String description;
  final IconData icon;

  Task({required this.title, required this.description, required this.icon});
}

List<Task> getList() {
  return [
    Task(title: 'Today', description: '4 Tasks', icon: Icons.sunny),
    Task(title: 'Planned', description: '8 Tasks', icon: Icons.date_range),
    Task(title: 'Personal', description: '6 Tasks', icon: Icons.person),
    Task(title: 'Work', description: '5 Tasks', icon: Icons.badge),
    Task(title: 'Shopping', description: '4 Tasks', icon: Icons.shopping_bag),
    Task(title: 'Shopping', description: '4 Tasks', icon: Icons.shopping_bag),
    Task(title: 'Shopping', description: '4 Tasks', icon: Icons.shopping_bag),
    Task(title: 'Shopping', description: '4 Tasks', icon: Icons.shopping_bag),
    Task(title: 'Shopping', description: '4 Tasks', icon: Icons.shopping_bag),
    Task(title: 'Shopping', description: '4 Tasks', icon: Icons.shopping_bag),
    // Task(title: 'Shopping', description: '4 Tasks', icon: Icons.shopping_bag),
    // Task(title: 'Shopping', description: '4 Tasks', icon: Icons.shopping_bag),
  ];
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    List<Task> tasks = getList();
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              Container(
                alignment: Alignment.center,
                height: Get.height * 0.095,
                width: Get.width * 0.85,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Icon(
                    tasks[index].icon,
                    size: 40,
                    color: Colors.black45,
                  ),
                  title: Text(
                    tasks[index].title,
                    style: titleStyle,
                  ),
                  subtitle: Text(
                    tasks[index].description,
                    style: subtitleStyle,
                  ),
                  trailing: PopupMenuButton<String>(
                    color: Colors.white,
                    elevation: 8,
                    onSelected: (String value) {
                      if (value == 'edit') {
                      } else if (value == 'delete') {}
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, color: Colors.black45),
                              SizedBox(width: 8),
                              Text('Edit Task'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.black45),
                              SizedBox(width: 8),
                              Text('Delete Task'),
                            ],
                          ),
                        ),
                      ];
                    },
                    icon: const Icon(Icons.more_vert),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
