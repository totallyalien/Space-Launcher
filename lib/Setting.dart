import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingBrain extends ChangeNotifier {
  bool mode = false;
  var appColour = Colors.white;
  var textColour = Colors.black;
  var textstyle = GoogleFonts.poppins;
  void changeMode() {
    mode = mode ? false : true;
    appColour = mode ? Colors.black : Colors.white;
    textColour = mode ? Colors.white : Colors.black;
    notifyListeners();
  }
}
