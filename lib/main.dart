import 'package:flutter/material.dart';
import 'package:lazy_chair/screens/home_screen/home_screen.dart';
import 'package:lazy_chair/screens/login_screen/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}