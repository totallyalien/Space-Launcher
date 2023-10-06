import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

class ApplicationBrain extends ChangeNotifier {
  List apps = [];
  List search_apps = [];
  TextEditingController searchField = TextEditingController();

  Future<void> initApp() async {
    apps = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        onlyAppsWithLaunchIntent: true,
        includeSystemApps: true);

    apps.sort((a, b) => a.appName.compareTo(b.appName));
    search_apps = apps;
    notifyListeners();
  }

  void search_app() {
    List temp = [];
    apps.forEach((element) {
      if (element.appName
          .toString()
          .toLowerCase()
          .contains(searchField.text.toString())) {
        print(element);
        temp.add(element);
      }
    });
    search_apps = temp;
    notifyListeners();
  }

  void appOpen(Index, type) {
    if (type == 1) {
      DeviceApps.openApp(apps[Index].packageName);
    } else {
      DeviceApps.openApp(search_apps[Index].packageName);
    }
  }
}
