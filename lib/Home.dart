import 'dart:async';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:retrolauncher/ApplicationBrain.dart';
import 'package:retrolauncher/Setting.dart';
import 'package:retrolauncher/SettingsUi.dart';
import 'package:retrolauncher/TimerBrain.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<TimerBrain>(context, listen: false).currentTime();
    Provider.of<ApplicationBrain>(context, listen: false).initApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double kh = MediaQuery.of(context).size.height;
    double kw = MediaQuery.of(context).size.width;
    return PageView(
      children: [
        HomePageView(context, kh, kw),
        GestureDetector(
          onLongPress: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingPage()));
          },
          child: Scaffold(
            backgroundColor: Provider.of<SettingBrain>(context).appColour,
            body: Container(
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(150)),
                                        color:
                                            Provider.of<SettingBrain>(context)
                                                .textColour),
                                    padding: EdgeInsets.all(kh / 200),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
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
                                  Container(
                                    width: kh / 5,
                                    child: Text(
                                      Provider.of<ApplicationBrain>(context)
                                          .search_apps[index]
                                          .appName,
                                      overflow: TextOverflow.fade,
                                      style: GoogleFonts.poppins(
                                          fontSize: kh / 55,
                                          color:
                                              Provider.of<SettingBrain>(context)
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingPage()));
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
            customTimeWidget(kw, kh, context),
            Center(
              child: SizedBox(
                height: kh / 2,
                width: kw / 1.5,
                child: ListView.builder(
                    itemCount:
                        Provider.of<ApplicationBrain>(context).apps.length > 5
                            ? 8
                            : Provider.of<ApplicationBrain>(context)
                                .apps
                                .length,
                    itemBuilder: (context, index) {
                      return Container(
                        // color: Colors.red,
                        margin: EdgeInsets.all(kh / 100),
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<ApplicationBrain>(context,
                                    listen: false)
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
                    }),
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

  Container customTimeWidget(double kw, double kh, BuildContext context) {
    return Container(
      width: kw,
      height: kh / 8,
      child: Center(
        child: Text(
          Provider.of<TimerBrain>(context).timeString,
          style: GoogleFonts.poppins(
              fontSize: kh / 30,
              fontWeight: FontWeight.w500,
              color: Provider.of<SettingBrain>(context).textColour),
        ),
      ),
    );
  }

  Container CustomAppname(BuildContext context, int index, double kh) {
    return Container(
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

Container CustomAppicon(double kh, BuildContext context, int index) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(150)),
        color: Provider.of<SettingBrain>(context).textColour),
    padding: EdgeInsets.all(kh / 200),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(50)),
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
