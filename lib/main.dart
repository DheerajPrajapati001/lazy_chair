import 'package:flutter/material.dart';
import 'package:lazy_chair/screens/bottom_navigation/bottom_navigation.dart';
import 'package:lazy_chair/screens/chair_details/chair_details.dart';
import 'package:lazy_chair/screens/confirmation/confirmation.dart';
import 'package:lazy_chair/screens/coupon_screen/coupons_screen.dart';
import 'package:lazy_chair/screens/home_screen/home_screen.dart';
import 'package:lazy_chair/screens/login_screen/login_screen.dart';
import 'package:lazy_chair/screens/my_cart/my_cart.dart';
import 'package:lazy_chair/screens/oders/order_details.dart';
import 'package:lazy_chair/screens/oders/orders.dart';
import 'package:lazy_chair/screens/settings_screen/setting_screen.dart';
import 'package:lazy_chair/screens/shipping/shipping.dart';
import 'package:lazy_chair/screens/splash_screen/splash_screen.dart';

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
        'ChairDetails':(context)=> ProductDetails(),
        'BottomNav':(context)=> BottomNavBar(),
        'HomePage':(context)=> HomeScreen(),
        'MyCart':(context)=> MyCart(),
        'Shipping':(context)=> Shipping(),
        'Confirmation':(context)=> Confirmation(),
        'LoginPage':(context)=> LoginScreen(),
        'ViewOrders':(context)=> Orders(),
        'OrderDetails':(context)=> OrderDetailsScreen(),
        'Settings':(context)=> Setting(),
        'Coupons':(context)=> Coupon()
      },
      home: SplashScreen(),
    );
  }
}



