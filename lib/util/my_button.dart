import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retrolauncher/Setting.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Provider.of<SettingBrain>(context).todolist_button,
      child: Text(text),
    );
  }
}
