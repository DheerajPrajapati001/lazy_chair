import 'package:flutter/material.dart';
import 'package:lazy_chair/screens/chair_details/chair_details.dart';
import 'package:lazy_chair/screens/confirmation/confirmation.dart';
import 'package:lazy_chair/screens/home_screen/home_screen.dart';
import 'package:lazy_chair/screens/my_cart/my_cart.dart';
import 'package:lazy_chair/screens/oders/orders.dart';
import 'package:lazy_chair/screens/shipping/shipping.dart';

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
        'MyCart':(context)=> MyCart(),
        'Shipping':(context)=> Shipping(),
        'Confirmation':(context)=> Confirmation()
      },
      home: HomeScreen(),
    );
  }
}



