
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingBrain extends ChangeNotifier {
  bool mode = false;
  bool grid = false;
  bool doubletap = false;
  bool appusage = false;
  int imgTile = 1;

  var todolistBackground = const Color(0xFF191D23);
  var todolist_tile = const Color.fromARGB(255, 255, 255, 255);
  var todolist_tile_text = Colors.black;
  var todolist_button = const Color.fromRGBO(250, 240, 230, 0.993);
  var appColour = Colors.white;
  var textColour = Colors.black;
  var textstyle = GoogleFonts.poppins;
  void changeMode() {
    mode = mode ? false : true;
    appColour = mode ? Colors.black : Colors.white;
    textColour = mode ? Colors.white : Colors.black;
    notifyListeners();
  }

  void GridMode() {
    grid = grid ? false : true;
    notifyListeners();
  }

  void usageMode() {
    appusage = appusage ? false : true;
    notifyListeners();
  }

  void tapMode() {
    doubletap = doubletap ? false : true;
    notifyListeners();
  }

  Future turnoff() async {
  }

  void fcover() {
    if (imgTile < 7) {
      imgTile++;
    } else {
      imgTile = 0;
    }
    notifyListeners();
  }
}
