import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class BackgroundBrain extends ChangeNotifier {
  String tissot = "";
  bool show = true;
  late Timer timer;
  void scheduleTimer(int time) {
    print("object");
    tissot =
        "${DateTime.now().add(Duration(minutes: time)).hour} : ${DateTime.now().add(Duration(minutes: time)).minute}";
    show = false;
    notifyListeners();
    timer = Timer.periodic(Duration(minutes: time), (Timer timer) {
      sleepfunc();
      show = true;
      notifyListeners();
    });
  }

  void cancelScheduledTimer() {
    timer.cancel();
    show = true;
    print("cancel");
    notifyListeners();
  }

  Future<void> sleepfunc() async {
    final player = AudioPlayer(); // Create a player
    var dura = player.setAsset("assets/file_example_MP3_700KB.mp3");
    player.play();
    print("ALIENNNNNNNNNNNNN");
    Duration(seconds: 3);
    await player.stop();
    show = false;
    notifyListeners();
  }
}
