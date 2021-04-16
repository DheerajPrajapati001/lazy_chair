import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences prefs ;

  getUserDetails()async{
    prefs = await SharedPreferences.getInstance();
    print(prefs.get("Id"));
    if(prefs.get("Id")!=null)
    {


      GlobalData.userId=prefs.get("Id");
      GlobalData.niceName=prefs.get("name");


    }
    else
    {
      print("Apple");
      //Navigator.of(context).pushReplacementNamed('loging_selection');
    }
  }


  static const timeout = const Duration(seconds: 3);
  static const ms = const Duration(milliseconds: 1);

  startTimeout([int milliseconds]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return new Timer(duration, handleTimeout);
  }

  void handleTimeout() async {
    getUserDetails();
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF2C33FF),
            Color(0xFFF62658),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Text("E-Commerce App",style: TextStyle(fontSize: 20),),
      ),
    );
  }
}
