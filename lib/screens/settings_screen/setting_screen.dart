import 'package:flutter/material.dart';
import 'package:lazy_chair/localization/language_constants.dart';
import 'package:lazy_chair/screens/home_screen/home_screen.dart';

import '../global.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalData.orange,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
            getTranslated(context, 'settings'),
          style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * .045,
              fontWeight: FontWeight.w500),
        ),


        elevation: 0,
      ),

      body: Container(
        child:  Column(
          children: [

            Container(
             height: 100,
              decoration: BoxDecoration(
                color: Colors.orange.shade200,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.height*.08,
                      height: MediaQuery.of(context).size.height*.08,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(Icons.add_a_photo_outlined,),onPressed: (){},
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*.05,
                    ),
                    Text(GlobalData.firstName+" "+GlobalData.lastName,style: TextStyle(
                        color: GlobalData.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                    ),),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [

                  DrawerItem(
                    icon: Icons.info_outline,
                    title: getTranslated(context, 'about_us'),
                    click: (){
                      GlobalData.activePage=GlobalData.aboutUsPage;
                      Navigator.pushNamed(context, 'AboutUs');

                    },
                  ),
                  DrawerItem(
                    icon: Icons.policy,
                    title: getTranslated(context, "terms_conditions"),
                    click: (){
                      GlobalData.activePage=GlobalData.termsConditions;
                      Navigator.pushNamed(context, 'TermsConditions');

                    },
                  ),
                  DrawerItem(
                      icon: Icons.inventory,
                      title: getTranslated(context, "view_orders"),
                      click: (){
                        Navigator.pushNamed(context, 'ViewOrders');

                      }

                  ),
                  DrawerItem(
                    icon: Icons.shopping_cart,
                    title: getTranslated(context, "view_cart"),
                    click: (){
                      GlobalData.isAdded=true;
                      Navigator.pushNamed(context, 'MyCart');
                    },
                  ),
                  DrawerItem(
                    icon: Icons.favorite,
                    title: getTranslated(context, "my_wishList"),
                    click: (){
                      //Navigator.pushNamed(context, 'MyCart');
                    },
                  ),
                  DrawerItem(
                    icon: Icons.card_giftcard,
                    title: getTranslated(context, "my_coupons"),
                    click: (){
                      Navigator.pushNamed(context, 'Coupons');
                    },
                  ),
                  DrawerItem(
                    icon: Icons.language,
                    title: getTranslated(context, "change_language"),

                    click: (){
                      Navigator.pushNamed(context, 'LanguageScreen');
                    },
                  ),
                  DrawerItem(
                    icon: Icons.exit_to_app_sharp,
                    title: getTranslated(context, "sign_out"),
                    click: (){
                      LogoutFunction(context);
                    },
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
