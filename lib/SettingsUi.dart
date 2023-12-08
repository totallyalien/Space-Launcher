import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:retrolauncher/Setting.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    double kh = MediaQuery.of(context).size.height;
    double kw = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Provider.of<SettingBrain>(context).appColour,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white),
                        child: const Icon(Icons.exit_to_app)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Settings",
                          style: GoogleFonts.poppins(
                              fontSize: kh / 30,
                              color: Provider.of<SettingBrain>(context)
                                  .textColour),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.width / 2.2,
              width: MediaQuery.of(context).size.width / 2.2,
              child: SvgPicture.asset("assets/settingLogo.svg"),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Provider.of<SettingBrain>(context).todolistBackground,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 15, right: 15, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                        color: Provider.of<SettingBrain>(context).appColour,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: SwitchListTile(
                      title: Text(
                        "Dark Mode",
                        style: GoogleFonts.poppins(
                            color:
                                Provider.of<SettingBrain>(context).textColour),
                      ),
                      value: Provider.of<SettingBrain>(context).mode,
                      onChanged: (value) {
                        print(value);
                        Provider.of<SettingBrain>(context, listen: false)
                            .changeMode();
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 15, right: 15, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                        color: Provider.of<SettingBrain>(context).appColour,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: SwitchListTile(
                      title: Text(
                        "GridView",
                        style: GoogleFonts.poppins(
                            color:
                                Provider.of<SettingBrain>(context).textColour),
                      ),
                      value: Provider.of<SettingBrain>(context).grid,
                      onChanged: (value) {
                        print(value);
                        Provider.of<SettingBrain>(context, listen: false)
                            .GridMode();
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 15, right: 15, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                        color: Provider.of<SettingBrain>(context).appColour,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: SwitchListTile(
                      title: Text(
                        "Show App usage",
                        style: GoogleFonts.poppins(
                            color:
                                Provider.of<SettingBrain>(context).textColour),
                      ),
                      value: Provider.of<SettingBrain>(context).appusage,
                      onChanged: (value) {
                        print(value);
                        Provider.of<SettingBrain>(context, listen: false)
                            .usageMode();
                      },
                    ),
                  ),
                  Container(
                      width: kw,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, top: 8, bottom: 8),
                      decoration: BoxDecoration(
                          color: Provider.of<SettingBrain>(context).appColour,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Text(
                        "Hide App",
                        style: GoogleFonts.poppins(
                            color:
                                Provider.of<SettingBrain>(context).textColour),
                      )),
                  // Container(
                  //     width: kw,
                  //     padding: const EdgeInsets.all(20),
                  //     margin: const EdgeInsets.only(
                  //         left: 15, right: 15, top: 8, bottom: 8),
                  //     decoration: BoxDecoration(
                  //         color: Provider.of<SettingBrain>(context).appColour,
                  //         borderRadius:
                  //             const BorderRadius.all(Radius.circular(20))),
                  //     child: Text(
                  //       "Select Favourite Apps",
                  //       style: GoogleFonts.poppins(
                  //           color:
                  //               Provider.of<SettingBrain>(context).textColour),
                  //     )),
                  // Container(
                  //   margin: const EdgeInsets.only(
                  //       left: 15, right: 15, top: 8, bottom: 8),
                  //   decoration: BoxDecoration(
                  //       color: Provider.of<SettingBrain>(context).appColour,
                  //       borderRadius:
                  //           const BorderRadius.all(Radius.circular(20))),
                  //   child: SwitchListTile(
                  //     title: Text(
                  //       "Double tap to lock",
                  //       style: GoogleFonts.poppins(
                  //           color:
                  //               Provider.of<SettingBrain>(context).textColour),
                  //     ),
                  //     value: Provider.of<SettingBrain>(context).grid,
                  //     onChanged: (value) {
                  //       print(value);
                  //       Provider.of<SettingBrain>(context, listen: false)
                  //           .GridMode();
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
