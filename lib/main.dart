import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retrolauncher/ApplicationBrain.dart';
import 'package:retrolauncher/Home.dart';
import 'package:retrolauncher/Setting.dart';
import 'package:flutter/services.dart';
import 'package:retrolauncher/TimerBrain.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:retrolauncher/data/database.dart';
import 'package:retrolauncher/sleeptimer/background.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge).then((_) {
    runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SettingBrain()),
          ChangeNotifierProvider(create: (context) => ApplicationBrain()),
          ChangeNotifierProvider(create: (context) => TimerBrain()),
          ChangeNotifierProvider(create: (context) => ToDoDataBase()),
          ChangeNotifierProvider(create: (context) => BackgroundBrain())

        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false, home: HomeScreen())));
  });
}
