import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:retrolauncher/ApplicationBrain.dart';
import 'package:retrolauncher/Setting.dart';
import 'package:retrolauncher/SettingsUi.dart';
import 'package:retrolauncher/TimerBrain.dart';
import 'package:retrolauncher/data/database.dart';
import 'package:retrolauncher/pages/Calculator.dart';
import 'package:retrolauncher/pages/TodoList.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ToDoDataBase>(context, listen: false).loadData();
    Provider.of<TimerBrain>(context, listen: false).currentTime();
    Provider.of<ApplicationBrain>(context, listen: false).initApp();
    Provider.of<ApplicationBrain>(context, listen: false).getUsageStats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double kh = MediaQuery.of(context).size.height;
    double kw = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: PageView(
            physics: const CustomPageViewScrollPhysics(),
            children: [
              SafeArea(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          margin: const EdgeInsets.all(15),
                          padding: const EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height / 2.5,
                          decoration: BoxDecoration(
                              color: Provider.of<SettingBrain>(context)
                                  .todolistBackground,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30))),
                          child: PageView(
                            children: const [
                              ToDoList(),
                              Calculator(),
                            ],
                          )),
                      Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height / 2.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Provider.of<SettingBrain>(context)
                                          .todolistBackground,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30))),
                                  child: const LocalMusicPlayer(),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width / 50,
                              ),
                              // Expanded(
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //         color: Provider.of<SettingBrain>(context)
                              //             .todolistBackground,
                              //         borderRadius: const BorderRadius.all(
                              //             Radius.circular(30))),
                              //     child: LocalContactWidget(),
                              //   ),
                              // ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Provider.of<SettingBrain>(context)
                                          .todolistBackground,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30))),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        height: kh,
                                        margin: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                bottomLeft:
                                                    Radius.circular(30))),
                                        child: Center(
                                          child: Text(
                                            "5 💤",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )),
                                      Expanded(
                                          child: Container(
                                        height: kh,
                                        margin: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(0))),
                                        child: Center(
                                          child: Text(
                                            "10 💤",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )),
                                      Expanded(
                                          child: Container(
                                        height: kh,
                                        margin: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(30),
                                                bottomRight:
                                                    Radius.circular(30))),
                                        child: Center(
                                          child: Text(
                                            "15 💤",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width / 50,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Provider.of<SettingBrain>(context)
                                          .todolistBackground,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30))),
                                  child: LocalContactWidget(),
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
              HomePageView(context, kh, kw),
              GestureDetector(
                onLongPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingPage()));
                },
                child: Scaffold(
                  backgroundColor: Provider.of<SettingBrain>(context).appColour,
                  body: SizedBox(
                    height: kh,
                    width: kw,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: CustomSearchBox(context),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: Provider.of<ApplicationBrain>(context)
                                  .search_apps
                                  .length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.all(kh / 100),
                                  child: GestureDetector(
                                    onTap: () {
                                      Provider.of<ApplicationBrain>(context,
                                              listen: false)
                                          .appOpen(index, 2);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(150)),
                                              color: Provider.of<SettingBrain>(
                                                      context)
                                                  .textColour),
                                          padding: EdgeInsets.all(kh / 200),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(50)),
                                            child: Image.memory(
                                              Provider.of<ApplicationBrain>(
                                                              context)
                                                          .search_apps[index]
                                                      is ApplicationWithIcon
                                                  ? Provider.of<
                                                              ApplicationBrain>(
                                                          context)
                                                      .search_apps[index]
                                                      .icon
                                                  : null,
                                              height: kh / 40,
                                              gaplessPlayback: true,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: kw / 20,
                                        ),
                                        SizedBox(
                                          width: kh / 5,
                                          child: Text(
                                            Provider.of<ApplicationBrain>(
                                                    context)
                                                .search_apps[index]
                                                .appName,
                                            overflow: TextOverflow.fade,
                                            style: GoogleFonts.poppins(
                                                fontSize: kh / 55,
                                                color:
                                                    Provider.of<SettingBrain>(
                                                            context)
                                                        .textColour),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        SizedBox(
                          height: kh / 20,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextField CustomSearchBox(BuildContext context) {
    return TextField(
      showCursor: true,
      style: TextStyle(color: Provider.of<SettingBrain>(context).textColour),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 2,
              color:
                  Provider.of<SettingBrain>(context).textColour), //<-- SEE HERE
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      controller: Provider.of<ApplicationBrain>(context).searchField,
      onChanged: (value) {
        Provider.of<ApplicationBrain>(context, listen: false).search_app();
      },
    );
  }

  GestureDetector HomePageView(BuildContext context, double kh, double kw) {
    return GestureDetector(
      onLongPress: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SettingPage()));
      },
      onDoubleTap: () {
        print("double tap tap");
        Provider.of<SettingBrain>(context, listen: false).turnoff();
      },
      child: Scaffold(
        backgroundColor: Provider.of<SettingBrain>(context).appColour,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: kh / 20,
            ),
            GestureDetector(
              onTap: () {
                Provider.of<SettingBrain>(context, listen: false).fcover();
              },
              child: SvgPicture.asset(
                  "assets/pt${Provider.of<SettingBrain>(context, listen: true).imgTile}.svg",
                  width: MediaQuery.of(context).size.width / 1.5),
            ),
            customTimeWidget(kw, kh, context),
            Center(
              child: SizedBox(
                height: kh / 2,
                width: kw / 1.5,
                child: Provider.of<SettingBrain>(context).grid
                    ? GridviewDisplay(context, kh, kw)
                    : ListviewDisplay(context, kh, kw),
              ),
            ),
            SizedBox(
              height: kh / 20,
            ),
          ],
        ),
      ),
    );
  }

  GridView GridviewDisplay(BuildContext context, double kh, double kw) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // number of items in each row
          mainAxisSpacing: 30.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ),
        itemCount: Provider.of<ApplicationBrain>(context).apps.length > 5
            ? 9
            : Provider.of<ApplicationBrain>(context).apps.length,
        itemBuilder: (context, index) {
          return Container(
            child: GestureDetector(
              onTap: () {
                Provider.of<ApplicationBrain>(context, listen: false)
                    .appOpen(index, 1);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomAppiconGridView(kh, context, index),
                  SizedBox(
                    width: kw / 20,
                  ),
                  CustomAppnameGridView(context, index, kh),
                ],
              ),
            ),
          );
        });
  }

  ListView ListviewDisplay(BuildContext context, double kh, double kw) {
    return ListView.builder(
        itemCount: Provider.of<ApplicationBrain>(context).apps.length > 5
            ? 8
            : Provider.of<ApplicationBrain>(context).apps.length,
        itemBuilder: (context, index) {
          return Container(
            // color: Colors.red,
            margin: EdgeInsets.all(kh / 100),
            child: GestureDetector(
              onTap: () {
                Provider.of<ApplicationBrain>(context, listen: false)
                    .appOpen(index, 1);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomAppicon(kh, context, index),
                  SizedBox(
                    width: kw / 20,
                  ),
                  CustomAppname(context, index, kh),
                ],
              ),
            ),
          );
        });
  }

  SizedBox customTimeWidget(double kw, double kh, BuildContext context) {
    return SizedBox(
      width: kw,
      height: kh / 8,
      child: Center(
        child: Text(
          Provider.of<TimerBrain>(context).timeString,
          style: GoogleFonts.poppins(
              fontSize: kh / 40,
              fontWeight: FontWeight.w500,
              color: Provider.of<SettingBrain>(context).textColour),
        ),
      ),
    );
  }

  SizedBox CustomAppname(BuildContext context, int index, double kh) {
    return SizedBox(
      width: kh / 5,
      child: Text(
        Provider.of<ApplicationBrain>(context).apps[index].appName,
        overflow: TextOverflow.fade,
        style: GoogleFonts.poppins(
            fontSize: kh / 55,
            color: Provider.of<SettingBrain>(context).textColour),
      ),
    );
  }
}

class LocalContactWidget extends StatelessWidget {
  const LocalContactWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      padding: EdgeInsets.all(8),
      scrollDirection: Axis.horizontal,
      itemCount: Provider.of<ToDoDataBase>(context).FavoriteList.length,
      itemBuilder: (context, item) {
        return Provider.of<ToDoDataBase>(context).FavoriteList[item][0] == "ADD"
            ? GestureDetector(
                onTap: () async {
                  if (await ContactPickerPlatform.instance.hasPermission() ==
                      false) {
                    await ContactPickerPlatform.instance
                        .requestPermission(force: true);
                  }
                  final FullContact contact =
                      await FlutterContactPicker.pickFullContact();

                  print("number= ${contact.phones[1].number}");

                  Provider.of<ToDoDataBase>(context, listen: false).addContacts(
                      contact.name!.firstName.toString(),
                      contact.phones[1].number.toString());
                  Provider.of<ToDoDataBase>(context, listen: false)
                      .updateDataBase();
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  height: 40,
                  width: 50,
                  child: Icon(Icons.add),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
              )
            : GestureDetector(
                onTap: () {
                  Provider.of<ToDoDataBase>(context, listen: false)
                      .makingPhoneCall(
                          Provider.of<ToDoDataBase>(context, listen: false)
                              .FavoriteList[item][1]);
                },
                onLongPress: () {
                  Provider.of<ToDoDataBase>(context, listen: false)
                      .deleteContact(context);
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  height: 40,
                  width: 50,
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Material(
                      child: Center(
                        child: Text(
                          Provider.of<ToDoDataBase>(context)
                              .FavoriteList[item][0]
                              .toString()
                              .substring(0, 2),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
              );
      },
    );
  }
}

class LocalMusicPlayer extends StatelessWidget {
  const LocalMusicPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            height: MediaQuery.of(context).size.height / 10,
            width: MediaQuery.of(context).size.height / 10,
            decoration: BoxDecoration(
                color: Provider.of<SettingBrain>(context).textColour,
                borderRadius: const BorderRadius.all(Radius.circular(30)))),
        Container(
            height: MediaQuery.of(context).size.height / 20,
            width: MediaQuery.of(context).size.height / 20,
            decoration: BoxDecoration(
                color: Provider.of<SettingBrain>(context).todolist_tile,
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: const Icon(
              Icons.play_arrow,
            )),
        Container(
            height: MediaQuery.of(context).size.height / 20,
            width: MediaQuery.of(context).size.height / 20,
            decoration: BoxDecoration(
                color: Provider.of<SettingBrain>(context).todolist_tile,
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: const Icon(
              Icons.play_arrow,
            )),
        Container(
            height: MediaQuery.of(context).size.height / 20,
            width: MediaQuery.of(context).size.height / 20,
            decoration: BoxDecoration(
                color: Provider.of<SettingBrain>(context).todolist_tile,
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: const Icon(
              Icons.play_arrow,
            )),
      ],
    );
  }
}

Container CustomAppicon(double kh, BuildContext context, int index) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(150)),
        color: Provider.of<SettingBrain>(context).textColour),
    padding: EdgeInsets.all(kh / 200),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      child: Image.memory(
        Provider.of<ApplicationBrain>(context).apps[index]
                is ApplicationWithIcon
            ? Provider.of<ApplicationBrain>(context).apps[index].icon
            : null,
        height: kh / 40,
        gaplessPlayback: true,
      ),
    ),
  );
}

Container CustomAppiconGridView(double kh, BuildContext context, int index) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(150)),
        color: Provider.of<SettingBrain>(context).textColour),
    padding: EdgeInsets.all(kh / 200),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      child: Image.memory(
        Provider.of<ApplicationBrain>(context).apps[index]
                is ApplicationWithIcon
            ? Provider.of<ApplicationBrain>(context).apps[index].icon
            : null,
        height: kh / 20,
        gaplessPlayback: true,
      ),
    ),
  );
}

Container CustomAppnameGridView(BuildContext context, int index, double kh) {
  return Container(
    width: kh / 5,
    alignment: Alignment.center,
    child: Text(
      Provider.of<ApplicationBrain>(context).apps[index].appName,
      overflow: TextOverflow.fade,
      maxLines: 1,
      style: GoogleFonts.poppins(
          fontSize: kh / 65,
          color: Provider.of<SettingBrain>(context).textColour),
    ),
  );
}

class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageViewScrollPhysics(parent: buildParent(ancestor)!);
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 80,
        stiffness: 100,
        damping: 1,
      );
}
