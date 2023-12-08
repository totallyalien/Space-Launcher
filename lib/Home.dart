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
import 'package:retrolauncher/sleeptimer/background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    if (Provider.of<ToDoDataBase>(context, listen: false)
            .myBox
            .get("CONTACT") ==
        null) {
      Provider.of<ToDoDataBase>(context, listen: false).updateDataBase();
    } else {
      // there already exists data
      Provider.of<ToDoDataBase>(context, listen: false).loadData();
    }
    Provider.of<TimerBrain>(context, listen: false).currentTime();
    Provider.of<ApplicationBrain>(context, listen: false).initApp();
    Provider.of<ApplicationBrain>(context, listen: false).getUsageStats();
    super.initState();
  }

  final PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    double kh = MediaQuery.of(context).size.height;
    double kw = MediaQuery.of(context).size.width;
    return SafeArea(
      maintainBottomViewPadding: true,
      child: PageView(
        controller: _pageController,
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
                      height: MediaQuery.of(context).size.height / 2.0,
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
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Provider.of<SettingBrain>(context)
                                      .todolistBackground,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30))),
                              child: Column(
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Sleep Timer",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Provider.of<BackgroundBrain>(context,
                                              listen: true)
                                          .show
                                      ? Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            timerbox(1),
                                            timerbox(15),
                                            timerbox(30),
                                          ],
                                        )
                                      : Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [Datetimerbox()],
                                        )
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SettingPage()));
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(150)),
                                          color:
                                              Provider.of<SettingBrain>(context)
                                                  .textColour),
                                      padding: EdgeInsets.all(kh / 200),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50)),
                                        child: Image.memory(
                                          Provider.of<ApplicationBrain>(context)
                                                      .search_apps[index]
                                                  is ApplicationWithIcon
                                              ? Provider.of<ApplicationBrain>(
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
                                        Provider.of<ApplicationBrain>(context)
                                            .search_apps[index]
                                            .appName,
                                        overflow: TextOverflow.fade,
                                        style: GoogleFonts.poppins(
                                            fontSize: kh / 55,
                                            color: Provider.of<SettingBrain>(
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
    );
  }

  Expanded Datetimerbox() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Provider.of<BackgroundBrain>(context, listen: false)
                .cancelScheduledTimer();
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Material(
                color: Colors.transparent,
                child: Center(
                  child: Text(
                    "${Provider.of<BackgroundBrain>(context, listen: true).tissot}",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Expanded timerbox(int time) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Provider.of<BackgroundBrain>(context, listen: false)
                .scheduleTimer(time);
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Material(
                color: Colors.transparent,
                child: Center(
                  child: Text(
                    "${time}",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                )),
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
                  // CustomAppicon(kh, context, index),
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
          Provider.of<TimerBrain>(context).timeString.toUpperCase(),
          style: GoogleFonts.poppins(
              fontSize: kh / 40,
              fontWeight: FontWeight.bold,
              color: Provider.of<SettingBrain>(context).textColour),
        ),
      ),
    );
  }

  SizedBox CustomAppname(BuildContext context, int index, double kh) {
    return SizedBox(
      width: kh / 4,
      child: Row(
        children: [
          Text(
            "${Provider.of<ApplicationBrain>(context).Usage[index][0].toString().toUpperCase()}   ",
            overflow: TextOverflow.fade,
            style: GoogleFonts.poppins(
                fontSize: kh / 55,
                fontWeight: FontWeight.bold,
                color: Provider.of<SettingBrain>(context).textColour),
          ),
          Provider.of<SettingBrain>(context, listen: false).appusage == true
              ? Text(
                  "${Provider.of<ApplicationBrain>(context).Usage[index][1]} min",
                  overflow: TextOverflow.fade,
                  style: GoogleFonts.poppins(
                      color: Colors.white54, fontSize: kh / 75),
                )
              : Text("")
        ],
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
                  height: 50,
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
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        height: 50,
                        width: 50,
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Material(
                            child: Center(
                              child: Text(
                                  Provider.of<ToDoDataBase>(context)
                                      .FavoriteList[item][0]
                                      .toString()
                                      .substring(0, 3),
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                      ),
                      Text(
                          Provider.of<ToDoDataBase>(context)
                              .FavoriteList[item][0]
                              .toString(),
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
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
        // Container(
        //     height: MediaQuery.of(context).size.height / 10,
        //     width: MediaQuery.of(context).size.height / 10,
        //     decoration: BoxDecoration(
        //         color: Provider.of<SettingBrain>(context).textColour,
        //         borderRadius: const BorderRadius.all(Radius.circular(30)))),
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  UsagePRogr(
                      context,
                      Provider.of<ApplicationBrain>(context, listen: false)
                          .Usage[0][0],
                      Provider.of<ApplicationBrain>(context, listen: false)
                          .Usage[0][1],
                      Colors.purple),
                  UsagePRogr(
                      context,
                      Provider.of<ApplicationBrain>(context, listen: false)
                          .Usage[1][0],
                      Provider.of<ApplicationBrain>(context, listen: false)
                          .Usage[1][1],
                      Colors.green),
                  UsagePRogr(
                      context,
                      Provider.of<ApplicationBrain>(context, listen: false)
                          .Usage[2][0],
                      Provider.of<ApplicationBrain>(context, listen: false)
                          .Usage[2][1],
                      Colors.yellow),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Column UsagePRogr(BuildContext context, String name, int time, Color cll) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  backgroundColor:
                      Provider.of<SettingBrain>(context).todolistBackground,
                ),
                // style: TextStyle(
                //   fontSize: 8,
                //   fontWeight: FontWeight.bold,
                //   color: Colors.white,
                //   backgroundColor:
                //       Provider.of<SettingBrain>(context).todolistBackground,
                // ),
              ),
              Text(
                "${time} min",
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  backgroundColor:
                      Provider.of<SettingBrain>(context).todolistBackground,
                ),
              )
            ],
          ),
        ),
        LinearProgressIndicator(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          value: time.toDouble() / 200,
          color: cll,
          minHeight: 5,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}

// Container CustomAppicon(double kh, BuildContext context, int index) {
//   return Container(
//     decoration: BoxDecoration(
//         borderRadius: const BorderRadius.all(Radius.circular(150)),
//         color: Provider.of<SettingBrain>(context).textColour),
//     padding: EdgeInsets.all(kh / 200),
//     child: ClipRRect(
//       borderRadius: const BorderRadius.all(Radius.circular(50)),
//       child: Image.memory(
//         Provider.of<ApplicationBrain>(context).apps[index]
//                 is ApplicationWithIcon
//             ? Provider.of<ApplicationBrain>(context).apps[index].icon
//             : null,
//         height: kh / 40,
//         gaplessPlayback: true,
//       ),
//     ),
//   );
// }

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
          fontSize: kh / 75,
          fontWeight: FontWeight.bold,
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
