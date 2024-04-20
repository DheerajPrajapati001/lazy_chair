import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lazy_chair/screens/about_us/about_us_screen.dart';
import 'package:lazy_chair/screens/bottom_navigation/bottom_navigation.dart';
import 'package:lazy_chair/screens/chair_details/chair_details.dart';
import 'package:lazy_chair/screens/confirmation/confirmation.dart';
import 'package:lazy_chair/screens/coupon_screen/coupons_screen.dart';
import 'package:lazy_chair/screens/home_screen/home_screen.dart';
import 'package:lazy_chair/screens/login_screen/login_screen.dart';
import 'package:lazy_chair/screens/login_screen/phone_login.dart';
import 'package:lazy_chair/screens/my_cart/my_cart.dart';
import 'package:lazy_chair/screens/oders/order_details.dart';
import 'package:lazy_chair/screens/oders/orders.dart';
import 'package:lazy_chair/screens/settings_screen/setting_screen.dart';
import 'package:lazy_chair/screens/shipping/shipping.dart';
import 'package:lazy_chair/screens/splash_screen/splash_screen.dart';
import 'package:lazy_chair/screens/terms_conditions/terms_conditions_page.dart';
import 'package:lazy_chair/localization/demo_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lazy_chair/localization/language_constants.dart';
import 'package:lazy_chair/screens/language_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    if (this._locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800]!)),
        ),
      );
    }
    else{
    return MaterialApp(
      theme: ThemeData(
      ),
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: [
        Locale("en", "US"),
        Locale("zh", "CN"),
        Locale("ms", "MY"),
      ],
      localizationsDelegates: [
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return locale;
          }
        }
        return supportedLocales.first;
      },
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
        'Coupons':(context)=> Coupon(),
        'AboutUs':(context)=> AboutUsScreen(),
        'TermsConditions':(context)=> TermsAndConditionScreen(),
        'PhoneLogin':(context)=> PhoneLoginScreen(),
        'LanguageScreen':(context)=> LanguagePage()
      },
      home: SplashScreen(),
    );}
  }
}





