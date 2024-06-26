import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:lazy_chair/chairs.dart';
import 'package:lazy_chair/localization/language_constants.dart';
import 'package:lazy_chair/models/products.dart';
import 'package:lazy_chair/models/shipping_zone.dart';
import 'package:lazy_chair/models/shipping_zone_method.dart';
import 'package:lazy_chair/screens/chair_details/chair_details.dart';
import 'package:lazy_chair/screens/global.dart';
import 'package:lazy_chair/config/config.dart';
import 'package:lazy_chair/screens/my_cart/my_cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:lazy_chair/models/banner_data.dart';
import '../../woocommerce.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _onProductPressed(WooProduct products, BuildContext context) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) {
          return ProductDetails(
            productDetails: products,
          );
        },
      ),
    );
  }
  SharedPreferences? prefs;

  Future Getnonse(String tokenId, {String? token}) async {
    prefs = await SharedPreferences.getInstance();

    Map<String, String> requestHeaders = {'Authorization': "Bearer "+token!};
    final response = await http.get(Uri.parse(Config.baseUrl+'wp-json/nonceapi/v1/get'),
        headers: requestHeaders);

    var j = json.decode(response.body);
    print(j);
    print(j['nonce']);
    prefs!.setString("NonceKey", j['nonce']);
    GlobalData.nonceKey=j['nonce'];
    print(GlobalData.nonceKey);

    return j['nonce']; //later u can save this nonce vai sharedpreference or etc i am using shared preference
  }

  List<WooProduct> featuredProducts = [];
  List<WooProduct> searchProducts = [];
  List<WooShippingZone> shippingZone = [];
  List<WooShippingZoneMethod> shippingZoneMethodId = [];
  List<BannerData> banner =[];
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
        GlobalData.shippingZoneName = shippingZone[i].name!;
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
      GlobalData.shippingMethodId=shippingZoneMethodId[i].methodId!;
      GlobalData.shippingMethodTitle=shippingZoneMethodId[i].methodTitle!;
      GlobalData.shippingMethodTotalPrice=shippingZoneMethodId[i].settings!.cost!.value.toString();


      print("Shipping Method Id: "+GlobalData.shippingMethodId);
      print("Shipping Method Title: "+GlobalData.shippingMethodTitle);
      print("Shipping Method Total Price: "+GlobalData.shippingMethodTotalPrice);
      //print("Shipping Zone Id: "+GlobalData.shippingZoneId);
    }
    setState(() {

    });
    //print(shippingZone.toString());
  }

  getProducts() async{

    GlobalData.isLoading=true;
    setState(() {

    });
    featuredProducts = await wooCommerce.getProducts(featured: true);
    setState(() {
    });
    GlobalData.isLoading=false;
    setState(() {

    });
    print(featuredProducts.toString());
  }

  TextEditingController searchItems = new TextEditingController();
  getSearchProducts() async{

    searchProducts.clear();

    GlobalData.isLoading=true;
    setState(() {

    });
    searchProducts = await wooCommerce.getProducts(search: searchItems.text);
    setState(() {
    });
    GlobalData.isLoading=false;
    setState(() {

    });
    print("Products in search Products : ${searchProducts.length} ");
    print(searchProducts.toString());
  }

  getBanner()async{

    GlobalData.isLoading=true;
    setState(() {

    });
    await http.post(
        Uri.parse('https://beta.saurabhenterprise.com/wp-json/wp/v2/users/banner'),
    ).then((response) async{

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonStr = json.decode(response.body);
        print('Banner: ' + jsonStr.toString());


        for(var p in jsonStr){
          var prod = BannerData.fromJson(p);
          print('product gotten here : '+prod.id!);
          GlobalData.bannerUrl=prod.pic!;
          print("Banner Url"+GlobalData.bannerUrl);
          banner.add(prod);
        }
        setState(() {
        });
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
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBanner();
    getProducts();
    getShippingZone();
    //getShippingZoneMethodId();
    Getnonse(GlobalData.tokenId);

    setState(() {
    });
  }

  String disp = '';
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: GlobalData.orange,
          title: Text(
            getTranslated(context, "welcome")!+" "+GlobalData.niceName,
            style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * .045,
                fontWeight: FontWeight.w500),
          ),
          actions: [
            Row(
              children: [
                Icon(Icons.notifications_none),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ],
          elevation: 0,
        ),
        /*drawer: Drawer(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*.25,
                color: GlobalData.orange,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.height*.1,
                          height: MediaQuery.of(context).size.height*.1,
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
                          height: MediaQuery.of(context).size.height*.01,
                        ),
                        Text(GlobalData.firstName+" "+GlobalData.lastName,style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                        ),)
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*.1),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.04,
                    ),
                    DrawerItem(
                      icon: Icons.info_outline,
                      title: 'About Us',
                    ),
                    DrawerItem(
                      icon: Icons.policy,
                      title: 'Terms & Conditions',
                    ),
                    DrawerItem(
                      icon: Icons.inventory,
                      title: 'View Orders',
                      click: (){
                        Navigator.pushNamed(context, 'ViewOrders');

                      }

                    ),
                    DrawerItem(
                      icon: Icons.shopping_cart,
                      title: 'View Cart',
                      click: (){
                        GlobalData.isAdded=true;
                        Navigator.pushNamed(context, 'MyCart');
                      },
                    ),
                    DrawerItem(
                      icon: Icons.exit_to_app_sharp,
                      title: 'Sign Out',
                      click: (){
                        LogoutFunction(context);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),*/
        /*bottomNavigationBar: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                offset: Offset(0, 0),
                spreadRadius: 10,
                blurRadius: 10)
          ]),
          child: CurvedNavigationBar(
            animationDuration: Duration(milliseconds: 300),
            color: Colors.white,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: GlobalData.orange,
            index: 0,
            items: <Widget>[
              Icon(Icons.home),
              Icon(Icons.category),
              Icon(Icons.shopping_cart_sharp),
              Icon(Icons.settings),
            ],
            onTap: (index) {
              setState(() {
                if(index==0){
                  disp = 'home';
                  HomeScreen();
                }else if(index==1){
                  disp = 'categories';
                  var color = Colors.red;
                }else if(index==2){
                  disp = 'Cart';
                  var color = Colors.yellow;
                  MyCart();
                }else{
                  disp = 'Settings';
                  var color = Colors.green;
                }
              });
            },
          ),
        ),*/
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              // Row(
              //   children: [
              //     Icon(Icons.menu_open),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         Text(
              //           'Hey, Masrafi!',
              //           style: TextStyle(
              //               color: Colors.grey,
              //               fontSize: MediaQuery.of(context).size.width * .04),
              //         ),
              //         Text(
              //           'You Choice Cute Chair',
              //           style: TextStyle(
              //               color: Colors.black,
              //               fontSize: MediaQuery.of(context).size.width * .045,
              //               fontWeight: FontWeight.w500),
              //         )
              //       ],
              //     ),
              //     Spacer(),
              //     Icon(Icons.notifications_none)
              //   ],
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .08,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: searchItems,
                      onChanged: (String value) async{
                        if(value.length>2){
                          getSearchProducts();
                        }
                      },
                      //enabled: false,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: getTranslated(context, "search"),
                          suffixIcon: GestureDetector(
                              onTap:(){
                                if(searchItems.text==""){
                                  Show_toast_Now("Enter Search Item", Colors.red);
                                }
                                else if(searchItems.text.length>3){
                                  getSearchProducts();
                                }
                              },child: Icon(Icons.search))),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CarouselSlider.builder(
                        options: CarouselOptions(
                          height: 180.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                          initialPage: 0,
                          /*onScrolled: (index){
                            setState(() {
                              _current=index;
                            });
                          },*/
                        ),
                          itemCount: banner.length,
                        itemBuilder: (context, itemIndex, realIndex)
                        {
                          return GlobalData.isLoading==true?
                          Container(height: 300,
                            width: MediaQuery.of(context).size.width,
                            child: Center(child: Text("Loading...")),


                          ):Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(height: 300,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: NetworkImage(banner[itemIndex].pic!),
                                  fit: BoxFit.cover,
                                ),
                              ),


                            ),
                          );
                        },




                          /*Container(height: 300,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage("https://beta.saurabhenterprise.com/wp-content/uploads/2021/03/pexels-bess-hamiti-35188.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),




                          ),


                          Container(height: 300,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage("https://beta.saurabhenterprise.com/wp-content/uploads/2021/03/pexels-bess-hamiti-35188.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),


                          ),



                          Container(height: 300,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage("https://beta.saurabhenterprise.com/wp-content/uploads/2021/03/pexels-bess-hamiti-35188.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),

                          ),
                        ],*/

                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),


                      searchItems.text==""?SizedBox():Row(
                        children: [
                          Text(
                          getTranslated(context, "searched_products")!,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width * .05),
                          ),
                          Spacer(),
                          /* Text(
                        'See All',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width * .04),
                      ),*/
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                      GlobalData.isLoading==true&&searchItems.text!=""?Center(child: Text("Loading...")):
                          searchItems.text==""?SizedBox():
                      searchProducts.isEmpty?Text(getTranslated(context, "products_unavailable")!,):
                      Container(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          //physics: NeverScrollableScrollPhysics(),
                          itemCount: searchProducts.length,
                          padding: EdgeInsets.only(right: 10),
                          itemBuilder: (context, index) {
                            final product = searchProducts[index];
                            return ChairItem(
                              products: product,
                              onTap: () {
                                GlobalData.productId=searchProducts[index].id.toString();
                                print(GlobalData.productId);
                                _onProductPressed(product, context);
                              },
                            );
                          },
                        ),
                      ),
                      searchItems.text==""?SizedBox():SizedBox(
                        height: 15,
                      ),



                      Row(
                        children: [
                          Text(
                            getTranslated(context, "featured_products")!,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width * .05),
                          ),
                          Spacer(),
                          /* Text(
                        'See All',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width * .04),
                      ),*/
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                      GlobalData.isLoading==true && searchItems.text==""?Center(child: Text("Loading...")):
                      featuredProducts.isEmpty?Text(getTranslated(context, "no_featured_products")!,):
                      Container(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          //physics: NeverScrollableScrollPhysics(),
                          itemCount: featuredProducts.length,
                          padding: EdgeInsets.only(right: 10),
                          itemBuilder: (context, index) {
                            final product = featuredProducts[index];
                            return ChairItem(
                                products: product,
                                onTap: () {
                                  GlobalData.productId=featuredProducts[index].id.toString();
                                  print(GlobalData.productId);
                                  _onProductPressed(product, context);
                                },
                              );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

class ChairItem extends StatelessWidget {
  final WooProduct? products;
  final VoidCallback? onTap;

  const ChairItem({Key? key, this.products, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            height: MediaQuery.of(context).size.height * .05,
            width: MediaQuery.of(context).size.width * .55,
            decoration: BoxDecoration(
                color:  Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),*/
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        products!.images==null?"https://ronakfabricatorworks.com/wp-content/uploads/2021/02/download.jpg":products!.images[0].src,
                        height: MediaQuery.of(context).size.height*.15,
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    products!.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * .025),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  /*Text(
                    products.by.toString(),
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: MediaQuery.of(context).size.height * .02),
                  ),*/
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: GlobalData.orange,
                      ),
                      Text(
                        products!.averageRating,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * .02),
                      ),
                      Spacer(),
                      Text(
                        "\$"+products!.price,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * .03,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class DrawerItem extends StatelessWidget {

  final String? title;
  final IconData? icon;
  final VoidCallback? click;

  const DrawerItem({Key? key, this.title, this.icon,this.click}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: click,
          child: Container(
            child: Row(
              children: [
                Icon(icon,color: Colors.grey,size: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width*.04,
                ),
                Text(title!,style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),)
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*.03,
        )
      ],
    );
  }
}

