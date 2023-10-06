import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TimerBrain extends ChangeNotifier {
  String timeString = "";

  void _getCurrentTime() {
    DateTime datetime = DateTime.now();
    timeString = DateFormat.MMMMEEEEd().format(datetime);
    notifyListeners();
  }

  void currentTime() {
    _getCurrentTime();
    Timer.periodic(Duration(days: 1), (Timer t) => _getCurrentTime());
  }
}
