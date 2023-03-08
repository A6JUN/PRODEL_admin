import 'package:flutter/material.dart';
import 'package:prodel_admin/ui/screen/home_screen.dart';
import 'package:prodel_admin/ui/screen/login_screen.dart';
import 'package:prodel_admin/ui/screen/message_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen());
  }
}
