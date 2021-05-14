import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:http/http.dart' as http;
import 'package:lazy_chair/config/config.dart';
import 'package:lazy_chair/models/page_data.dart';

import '../../woocommerce_error.dart';
import '../global.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {


  List<AllPageData> aboutData = [];

  getAbout() async {
    GlobalData.isLoading=true;
    setState(() {

    });
    http.get(
        Config.aboutUsUrl,
        ).then((response) async{
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonStr = json.decode(response.body);
        print('response gotten : '+response.body);
        GlobalData.aboutUsPage =AllPageData.fromJson(jsonStr);
        GlobalData.isLoading=false;
        setState(() {

        });

        // return WooCartItem.fromJson(jsonStr);
      } else {
        WooCommerceError err =
        WooCommerceError.fromJson(json.decode(response.body));
        throw err;
      }
    });
    /*setState(() {

    });
    GlobalData.isLoading=false;
    setState(() {

    });*/

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAbout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalData.orange,
        centerTitle: true,
        title: Text(
          "About Us",
          style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * .045,
              fontWeight: FontWeight.w500),
        ),

        elevation: 0,
      ),
      body: GlobalData.isLoading==true?Center(child: Text("Loading...")):Column(
        children: [
          SizedBox(height: 10,),

          SizedBox(height: 10,),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(

                  width: MediaQuery.of(context).size.width,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      new Html(data:
                      GlobalData.activePage.content.rendered??"Dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages,\n \n and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        style: {
                          "p": Style(
                              textAlign: TextAlign.justify,
                              fontSize: FontSize.large

                          ),
                        },

                      ),
                    ],
                  ),
                ),
              ),
            ),
          )


        ],
      ),

    );
  }
}
