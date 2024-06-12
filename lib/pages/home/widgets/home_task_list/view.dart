import 'package:flutter/material.dart';

import 'dialog_box.dart';

class TaskListCard extends StatefulWidget {
  const TaskListCard({super.key});

  @override
  State<TaskListCard> createState() => _TaskListCardState();
}

class _TaskListCardState extends State<TaskListCard> {
  final _controller = TextEditingController();
  List toDoList = [
    ['Make To Do', false],
    ['to do Task-2', false],
  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void saveNewTask() {
    if (_controller.text != "") {
      setState(() {
        toDoList.add([_controller.text, false]);
        _controller.clear();
      });
    }
    Navigator.of(context).pop();
  }

  void createNewTask() {
    // String a = "@gmail.com";
    // print(GetUtils.isPhoneNumber(a));
    // .isValidMailId()
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onCancel: () => Navigator.of(context).pop(),
          onSave: saveNewTask,
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            title: const Text(
              "Task List",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: createNewTask,
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  taskName: toDoList[index][0],
                  taskCompleted: toDoList[index][1],
                  onChanged: (value) => {checkBoxChanged(value, index)},
                  deleteFunction: () => deleteTask(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function()? deleteFunction;

  const ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, top: 25, right: 25),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.blue,
              ),
              title: Text(
                taskName,
                style: TextStyle(
                  decoration: taskCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              trailing: IconButton(
                onPressed: deleteFunction,
                icon: const Icon(Icons.delete_outline_rounded),
              ),
            ),
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 0.5,
          indent: 25,
          endIndent: 25,
        ),
      ],
    );
  }
}
