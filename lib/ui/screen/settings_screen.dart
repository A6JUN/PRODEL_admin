import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: const [
      Padding(
        padding: EdgeInsets.only(right: 1250),
        child: Text(
          "Settings",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
        ),
      ),
      Divider(
        thickness: 1,
        color: Color.fromARGB(255, 165, 163, 163),
        height: 10,
      )
    ]));
  }
}
