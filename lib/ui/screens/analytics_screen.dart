import 'package:flutter/material.dart';

class Analytics_screen extends StatefulWidget {
  const Analytics_screen({super.key});

  @override
  State<Analytics_screen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<Analytics_screen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: const [
      Padding(
        padding: EdgeInsets.only(right: 1250),
        child: Text(
          "Analytics",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
        ),
      ),
      Divider(
        height: 50,
        color: Color.fromARGB(255, 165, 163, 163),
        thickness: 1,
      )
    ]));
  }
}
