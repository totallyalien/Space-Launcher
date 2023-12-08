import 'package:app_usage/app_usage.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

class ApplicationBrain extends ChangeNotifier {
  List apps = [];
  List search_apps = [];
  List<AppUsageInfo> infoList = [];
  TextEditingController searchField = TextEditingController();
  List Usage = [];

  Future<void> initApp() async {
    apps = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        onlyAppsWithLaunchIntent: true,
        includeSystemApps: true);

    apps.sort((a, b) => a.appName.compareTo(b.appName));
    search_apps = apps;
    notifyListeners();
  }

  Future<void> getUsageStats() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate =
          DateTime(endDate.year, endDate.month, endDate.day - 1);
      infoList = await AppUsage().getAppUsage(startDate, endDate);

      infoList.sort((a, b) => b.usage.inMinutes.compareTo(a.usage.inMinutes));
      for (var info in infoList) {
        if (info.appName.toString() != 'retrolauncher' &&
            info.appName != 'android' &&
            info.appName != 'india' &&
            info.appName != 'launcher' &&
            info.appName != 'telephonyui' &&
            info.appName != 'incallui') {
          Usage.add([info.appName, info.usage.inMinutes, info.packageName]);
        }
        print(info.appName.toString() + info.usage.inMinutes.toString());
      }
      print(Usage);
    } on AppUsageException catch (exception) {
      print(exception);
    }
    apps = apps;
    notifyListeners();
  }

  void search_app() {
    List temp = [];
    for (var element in apps) {
      if (element.appName
          .toString()
          .toLowerCase()
          .contains(searchField.text.toString())) {
        print(element);
        temp.add(element);
      }
    }
    search_apps = temp;
    notifyListeners();
  }

  void appOpen(Index, type) {
    if (type == 1) {
      DeviceApps.openApp(Usage[Index][2]);
    } else {
      DeviceApps.openApp(search_apps[Index].packageName);
    }
  }
}
