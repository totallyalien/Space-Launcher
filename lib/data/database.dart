import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:retrolauncher/Setting.dart';
import 'package:url_launcher/url_launcher.dart';

class ToDoDataBase extends ChangeNotifier {
  List toDoList = [];
  List FavoriteList = [
    ["ADD", "ADD"]
  ];
  // reference our box
  final myBox = Hive.box('mybox');

  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    toDoList = [
      ["Make Tutorial", false],
      ["Do Exercise", false],
    ];
  }

  void makingPhoneCall(number) async {
    print(number);
    var url = Uri.parse("tel:${number}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void deleteContact(context) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Material(
              child: Container(
                color: Colors.black,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color:
                          Provider.of<SettingBrain>(context).todolistBackground,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: ListView.builder(
                      itemCount: FavoriteList.length - 1,
                      itemBuilder: (context, item) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          margin: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  FavoriteList[item + 1][0],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print(FavoriteList[item + 1][0]);
                                  deleteName(item + 1);
                                  notifyListeners();
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      color: Colors.white),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ),
          );
        });
  }

  // load the data from database
  void loadData() {
    toDoList = myBox.get("TODOLIST");
    FavoriteList = myBox.get("CONTACT");
    notifyListeners();
  }

  // update the database
  void updateDataBase() {
    myBox.put("TODOLIST", toDoList);
    myBox.put("CONTACT", FavoriteList);
    notifyListeners();
  }

  void deleteName(index) {
    FavoriteList.removeAt(index);
    updateDataBase();
    notifyListeners();
  }

  void addContacts(name, number) {
    FavoriteList.add([name, number]);
    print(FavoriteList);
    notifyListeners();
  }
}
