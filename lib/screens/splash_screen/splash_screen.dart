import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lazy_chair/config/config.dart';
import 'package:lazy_chair/models/shipping_zone.dart';
import 'package:lazy_chair/models/shipping_zone_method.dart';
import 'package:lazy_chair/screens/bottom_navigation/bottom_navigation.dart';
import 'package:lazy_chair/screens/home_screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../woocommerce.dart';
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
      GlobalData.couponCode = prefs.get("couponCode");
      GlobalData.discountTotal = prefs.get("discountPrice");
      GlobalData.currencySymbol = prefs.get("currencySymbol");
      print("token: "+GlobalData.tokenId);
      print("nonceKey: "+GlobalData.nonceKey);
      print("userid: "+GlobalData.userId.toString());


      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));

    }
    else
    {
      print("Apple");
      Navigator.of(context).pushReplacementNamed('PhoneLogin');
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


  List<WooShippingZone> shippingZone = [];
  List<WooShippingZoneMethod> shippingZoneMethodId = [];

  WooCommerce wooCommerce = WooCommerce(
    baseUrl: Config.baseUrl,
    consumerKey: Config.key,
    consumerSecret: Config.secret,
    isDebug: true,
  );

  getShippingZone() async{

    GlobalData.isLoading=true;
    setState(() {

    });
    shippingZone = await wooCommerce.getShippingZones();
    setState(() {
    });
    GlobalData.isLoading=false;
    for(int i=0; i<shippingZone.length; i++)
    {
      GlobalData.shippingZoneId=shippingZone[i].id.toString();
      GlobalData.shippingZoneName = shippingZone[i].name;
      print("Shipping Zone Id: "+GlobalData.shippingZoneId);
      print("Shipping Zone Name: "+GlobalData.shippingZoneName);
    }
    setState(() {

    });
    getShippingZoneMethodId();
    //print(shippingZone.toString());
  }

  getShippingZoneMethodId() async{

    GlobalData.isLoading=true;
    setState(() {

    });
    shippingZoneMethodId = await wooCommerce.getAllShippingZoneMethods(
        shippingZoneId: int.parse(GlobalData.shippingZoneId)
    );
    setState(() {
    });
    GlobalData.isLoading=false;
    for(int i=0; i<shippingZoneMethodId.length; i++)
    {
      GlobalData.shippingMethodId=shippingZoneMethodId[i].methodId;
      GlobalData.shippingMethodTitle=shippingZoneMethodId[i].methodTitle;
      GlobalData.shippingMethodTotalPrice=shippingZoneMethodId[i].settings.cost.value.toString();


      print("Shipping Method Id: "+GlobalData.shippingMethodId);
      print("Shipping Method Title: "+GlobalData.shippingMethodTitle);
      print("Shipping Method Total Price: "+GlobalData.shippingMethodTotalPrice);
      //print("Shipping Zone Id: "+GlobalData.shippingZoneId);
    }
    setState(() {

    });
    //print(shippingZone.toString());
  }
  @override
  void initState() {
    super.initState();
    getShippingZone();

    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset("assets/logo.png",height: 100,),

            /*Text("E-Commerce App",style: TextStyle(fontSize: 20),),*/
          ],
        ),
      ),
    );
  }
}
