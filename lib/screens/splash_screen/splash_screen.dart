import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lazy_chair/screens/home_screen/home_screen.dart';
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


      GlobalData.userId = prefs.getInt("Id");
      GlobalData.niceName = prefs.get("NiceName");
      GlobalData.tokenId = prefs.get("TokenId");
      GlobalData.emailId = prefs.get("Email");
      GlobalData.firstName = prefs.get("FirstName");
      GlobalData.lastName = prefs.get("LastName");
      GlobalData.nonceKey = prefs.get("NonceKey");
      print("token: "+GlobalData.tokenId);
      print("nonceKey: "+GlobalData.nonceKey);
      print("userid: "+GlobalData.userId.toString());


      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

    }
    else
    {
      print("Apple");
      Navigator.of(context).pushReplacementNamed('LoginPage');
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
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          child: Center(child: Text("E-Commerce App",style: TextStyle(fontSize: 20),)),
        ),
      ),
    );
  }
}
