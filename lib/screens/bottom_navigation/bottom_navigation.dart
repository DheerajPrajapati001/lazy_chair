import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:lazy_chair/screens/category_screen/category_screen.dart';
import 'package:lazy_chair/screens/home_screen/home_screen.dart';
import 'package:lazy_chair/screens/my_cart/my_cart.dart';
import 'package:lazy_chair/screens/settings_screen/setting_screen.dart';

import '../global.dart';



class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _pageIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  List pages = [
    MyRoute(
      iconData: Icons.home,
      page: HomeScreen(),
    ),
    MyRoute(
      iconData: Icons.category,
      page: CategoryScreen(),
    ),
    MyRoute(
      iconData: Icons.shopping_cart,
      page: MyCart(),
    ),
    MyRoute(
      iconData: Icons.settings,
      page: Setting(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              offset: Offset(0, 0),
              spreadRadius: 10,
              blurRadius: 10)
        ]),
        child: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: pages
              .map((p) => Icon(
            p.iconData,
            size: 30,
          ))
              .toList(),
          color: Colors.white,
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: GlobalData.orange,
          animationCurve: Curves.easeInOut,
          onTap: (index) {
            setState(() {
              _pageIndex = index;
            });
          },
        ),
      ),
      backgroundColor: Colors.orange.shade50,
      body: pages[_pageIndex].page,
    );
  }
}

class MyRoute {
  final IconData? iconData;
  final Widget? page;

  MyRoute({this.iconData, this.page});
}