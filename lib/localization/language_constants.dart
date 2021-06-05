import 'package:flutter/material.dart';
import 'package:lazy_chair/localization/demo_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String LAGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String CHINESE = 'zh';
const String MALAYSIA = 'ms';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? ENGLISH;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  Locale _temp;
  switch (languageCode) {
    case ENGLISH:
      _temp = Locale(languageCode, "US");
      break;
    case CHINESE:
      _temp = Locale(languageCode, "CN");
      break;
    case MALAYSIA:
      _temp = Locale(languageCode, "MY");
      break;

    default:
      _temp = Locale(languageCode, "US");

  }
  return _temp;

}

String getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context).translate(key);
}