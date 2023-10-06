import 'package:flutter/material.dart';
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
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Settings",
                style: GoogleFonts.poppins(
                    fontSize: kh / 30,
                    color: Provider.of<SettingBrain>(context).textColour),
              ),
            ),
            Divider(
                height: kh / 20,
                thickness: kh / 100,
                color: Provider.of<SettingBrain>(context).textColour),
            SwitchListTile(
              title: Text(
                "Dark Mode",
                style: GoogleFonts.poppins(
                    color: Provider.of<SettingBrain>(context).textColour),
              ),
              value: Provider.of<SettingBrain>(context).mode,
              onChanged: (value) {
                print(value);
                Provider.of<SettingBrain>(context, listen: false).changeMode();
              },
            )
          ],
        ),
      ),
    );
  }
}
