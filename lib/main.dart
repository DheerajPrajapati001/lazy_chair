import 'package:flutter/material.dart';
import 'package:lazy_chair/screens/chair_details/chair_details.dart';
import 'package:lazy_chair/screens/home_screen/home_screen.dart';
import 'package:lazy_chair/screens/my_cart/my_cart.dart';

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
      routes: {
        'ChairDetails':(context)=> ChairDetails(),
        'MyCart':(context)=> MyCart()
      },
      home: HomeScreen(),
    );
  }
}



