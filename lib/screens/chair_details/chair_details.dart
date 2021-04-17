import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:lazy_chair/chairs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce/models/products.dart';
import 'package:http/http.dart' as http;
import 'package:woocommerce/woocommerce_error.dart';
import '../global.dart';

class ProductDetails extends StatefulWidget {
  final WooProduct productDetails;
  const ProductDetails({Key key, @required this.productDetails}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _counter = 1;

  Future addToMyCartfix({@required String itemId, @required String quantity, List variations})
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jwt = await prefs.getString('jwt');
    var nonc = await prefs.getString('nonce');
    Map<String, dynamic> data = {
      'id': itemId,
      'quantity': quantity,
    };
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer '+GlobalData.tokenId,
      'X-WC-Store-API-Nonce': GlobalData.nonceKey
    };
   /* if (variations != null)
    {data['variations'] = variations;}
    else{
      data['variations'] = "";
    }*/

   http.post(
        'https://beta.saurabhenterprise.com/wp-json/wc/store/cart/add-item',
        body: data,
        headers: requestHeaders).then((response) async{

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonStr = json.decode(response.body);
        print('added to my cart : ' + jsonStr.toString());
        Show_toast_Now("Product Added Successfully", Colors.green);
        GlobalData.isAdded=true;

        setState(() {

        });
        // return WooCartItem.fromJson(jsonStr);
      } else {
        Show_toast_Now("Something went wrong", Colors.red);
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
    GlobalData.isAdded=false;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      print('$_counter');
    });
  }
  void __incrementCounter() {
    setState(() {
      _counter--;
      print('$_counter');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          "Product Details",
          style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * .045,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                  icon: Icon(Icons.shopping_bag_outlined),
                  onPressed: () {
                    Navigator.pushNamed(context, 'MyCart');
                  }),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Stack(
            children: [
              Column(
                children: [
                  /*Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        'Details',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * .05),
                      ),
                      Spacer(),
                      IconButton(
                          icon: Icon(Icons.shopping_bag_outlined),
                          onPressed: () {})
                    ],
                  ),*/
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.greenAccent),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                        Row(
                          children: [
                            Text(
                              widget.productDetails.name.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.height *
                                      .025),
                            ),
                            Spacer(),
                            Text(
                              '\$${widget.productDetails.price}',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * .03,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                       /* SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Text(
                          widget.productDetails.by.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize:
                                  MediaQuery.of(context).size.height * .02),
                        ),*/
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.orangeAccent,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.productDetails.averageRating,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.height * .02),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            /*Text(
                              '(500+ Review)',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize:
                                      MediaQuery.of(context).size.height * .02),
                            ),*/
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                       /* Row(
                          children: [
                            Text(
                              'Color:',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: MediaQuery.of(context).size.height *
                                      .025),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ChairColors(
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .05,
                            ),
                            ChairColors(
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .05,
                            ),
                            ChairColors(
                              color: Colors.green,
                            ),
                            Spacer(),
                            Container(
                              height: MediaQuery.of(context).size.height * .07,
                              width: MediaQuery.of(context).size.width * .3,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.withOpacity(0.1)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                      onTap: __incrementCounter,
                                      child: Text('-',style: TextStyle(fontSize: MediaQuery.of(context).size.height*.07),)),
                                  Text('$_counter'),
                                  GestureDetector(
                                      onTap: _incrementCounter,
                                      child: Icon(Icons.add))
                                ],
                              ),
                            )
                          ],
                        ),*/
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Text(
                          'Details:',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize:
                                  MediaQuery.of(context).size.height * .025),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .015,
                        ),
                        Html(
                          data: widget.productDetails.description,
                          style: {
                            "p":Style(
                              textAlign: TextAlign.justify,fontSize: FontSize.large,
                            )
                          },
                        ),
                       /* Text(
                          widget.productDetails.description,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * .025),
                        ),*/
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .4,
                              height: MediaQuery.of(context).size.height * .08,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.5))),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    print(GlobalData.nonceKey);
                                    print(GlobalData.tokenId);
                                    print(GlobalData.productId);
                                    GlobalData.isAdded==true?
                                    Navigator.pushNamed(context, 'MyCart'):
                                    addToMyCartfix(itemId: GlobalData.productId, quantity: "1",);
                                    setState(() {

                                    });


                                    /*Navigator.pushNamed(context, 'MyCart');*/
                                  },
                                  child: Center(
                                    child: Text(
                                      GlobalData.isAdded==true?"View Cart":'Add To Cart',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: MediaQuery.of(context).size.width * .4,
                              height: MediaQuery.of(context).size.height * .08,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange,
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.5))),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, 'Shipping');
                                  },
                                  splashColor: Colors.black.withOpacity(0.1),
                                  child: Center(
                                    child: Text(
                                      'Buy Now',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * .2,
                right: MediaQuery.of(context).size.width * .2,
                top: MediaQuery.of(context).size.height * .1,
                child:  Image.network(
                  widget.productDetails.images==null?"https://ronakfabricatorworks.com/wp-content/uploads/2021/02/download.jpg":widget.productDetails.images[0].src,
                  height: MediaQuery.of(context).size.height*.20,
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * .08,
                top: MediaQuery.of(context).size.height * .1,
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                  size: MediaQuery.of(context).size.width * .06,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class ChairColors extends StatelessWidget {
  final Color color;

  const ChairColors({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
