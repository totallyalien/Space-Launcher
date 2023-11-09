import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingBrain extends ChangeNotifier {
  bool mode = false;
  bool grid = false;

  var todolistBackground = Color.fromRGBO(185, 180, 199, 1);
  var todolist_tile = Color.fromARGB(255, 92, 84, 112);
  var todolist_tile_text = Colors.white;
  var todolist_button = Color.fromRGBO(250, 240, 230, 0.993);
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
}
