import 'package:flutter/material.dart';
import 'package:lazy_chair/models/language.dart';
import '../main.dart';
import 'package:lazy_chair/localization/language_constants.dart';


class LanguagePage extends StatefulWidget {
  LanguagePage({Key key}) : super(key: key);

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  void _changeLanguage(Language language) async {
    Locale _temp = await setLocale(language.languageCode);
   
    //Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _temp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'settings')),
      ),
      body: Container(
        child: Center(
            child: DropdownButton<Language>(
              iconSize: 30,
              hint: Text(getTranslated(context, 'change_language')),
              onChanged: (Language language) {
                _changeLanguage(language);
                setState(() {

                });
              },
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                  value: e,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        e.flag,
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(e.name)
                    ],
                  ),
                ),
              )
                  .toList(),
            )),
      ),
    );
  }
}