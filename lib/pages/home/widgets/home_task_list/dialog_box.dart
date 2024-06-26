import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DialogBox(
      {super.key,
      required this.controller,
      required this.onCancel,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Material(
        child: SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Add a new task",
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: onSave,
                      child: const Text(
                        "Save",
                      ),
                    ),
                    // MyButton(onPressed: onSave, text: "Save"),
                    const SizedBox(
                      width: 8,
                    ),
                    MyButton(onPressed: () => Get.back(), text: "Cancel"),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
