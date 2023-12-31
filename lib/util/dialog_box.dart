import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retrolauncher/Setting.dart';

import 'my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Provider.of<SettingBrain>(context).todolist_tile,
      content: Container(
        decoration:
            const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            TextField(
              controller: controller,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add a new task",
                  hintStyle: TextStyle(color: Colors.black)),
            ),

            // buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save button
                MyButton(text: "Save", onPressed: onSave),

                const SizedBox(width: 8),

                // cancel button
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
