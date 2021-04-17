import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lazy_chair/chairs.dart';
import 'package:lazy_chair/images.dart';
import 'package:woocommerce/models/cart_item.dart';
import 'package:http/http.dart' as http;
import 'package:woocommerce/woocommerce_error.dart';

import '../global.dart';

class MyCart extends StatefulWidget {

  final WooCartItem cartItem;

  const MyCart({Key key, this.cartItem}) : super(key: key);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  int _counter = 1;

  List<WooCartItem> cartItems =new List();

  var totalPrice=0;
  viewCartItems() async {

    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer '+GlobalData.tokenId,
      'X-WC-Store-API-Nonce': GlobalData.nonceKey
    };
    /* if (variations != null)
      {data['variations'] = variations;}
    else{
      data['variations'] ="";
    }*/

    http.get(
        'https://beta.saurabhenterprise.com/wp-json/wc/store/cart/items',

        headers: requestHeaders).then((response) async{

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonStr = json.decode(response.body);

        print('response gotten : '+response.toString());

        for(var p in jsonStr){
          var prod = WooCartItem.fromJson(p);
          print('prod gotten here : '+prod.name.toString());
          cartItems.add(prod);
          GlobalData.itemKey=prod.key;
          GlobalData.productId=prod.id.toString();


          print("price");
          print(GlobalData.itemKey);
          setState(() {

          });
        }



        for (var i = 0; i < cartItems.length; i++) {
          totalPrice += int.parse(cartItems[i].prices.price);
        }

        print("Sum : ${totalPrice}");

        print('account user fetch : '+jsonStr.toString());


        return cartItems;

        // return WooCartItem.fromJson(jsonStr);
      } else {
        WooCommerceError err =
        WooCommerceError.fromJson(json.decode(response.body));
        throw err;
      }
    });


  }


  Future DeleteCartItems(
      {@required String key,}) async {

    Map<String, dynamic> data = {
      'key':key,

    };
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer '+GlobalData.tokenId,
      'X-WC-Store-API-Nonce': GlobalData.nonceKey
    };
    /*if (variations != null)
    {data['variations'] = variations;}
    else{
      data['variations'] = "";
    }*/

    await http.post(
        'https://beta.saurabhenterprise.com/wp-json/wc/store/cart/remove-item/',
        body: data,
        headers: requestHeaders).then((response) async{

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonStr = json.decode(response.body);
        print('Item Deleted: ' + jsonStr.toString());

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



  Future UpdateCartItems(
      {@required String key, @required String itemId,
        @required String quantity,
        List variations}) async {

    Map<String, dynamic> data = {
      'key':key,
      'id': itemId,
      'quantity': quantity,
    };
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer '+GlobalData.tokenId,
      'X-WC-Store-API-Nonce': GlobalData.nonceKey
    };
    /*if (variations != null)
    {data['variations'] = variations;}
    else{
      data['variations'] = "";
    }*/

    await http.post(
        'https://beta.saurabhenterprise.com/wp-json/wc/store/cart/update-item/',
        body: data,
        headers: requestHeaders).then((response) async{

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonStr = json.decode(response.body);
        print('Cart Updated: ' + jsonStr.toString());
        GlobalData.isAdded=true;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    viewCartItems();
    setState(() {

    });
  }

  String disp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5,right: 10,top: 10),
              child: Row(
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
                    'My Cart',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * .05),
                  ),
                  Spacer(),
                 /* Text(
                    'Edit',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * .05),
                  ),*/
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItems.length.toString()+" "+'Items',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize:
                          MediaQuery.of(context).size.height * .025),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.02,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (c,index){
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height*.15,
                                    width: MediaQuery.of(context).size.height*.15,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFDBF3FA),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Image.network(cartItems[index].images[0].src,height: MediaQuery.of(context).size.height*.1,),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*.02,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        cartItems[index].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height*.005,
                                      ),
                                     /* Text(
                                        'By Daud',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize:
                                            MediaQuery.of(context).size.height * .02),
                                      ),*/
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height*.02,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Qty:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*.08,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: (){
                                                  cartItems[index].quantity--;

                                                  setState(() {

                                                  });
                                                },
                                                child: Text('-',style: TextStyle(fontSize: MediaQuery.of(context).size.height*.07,color: Colors.red),),),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width*.04,
                                              ),
                                              Text(cartItems[index].quantity.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*.05),),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width*.04,
                                              ),
                                              GestureDetector(
                                                  onTap: (){
                                                    cartItems[index].quantity++;


                                                    setState(() {

                                                    });
                                                  },
                                                  child: Icon(Icons.add,color: Colors.red,))
                                            ],
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height*.06,
                                      ),
                                      Text(cartItems[index].prices.currencySymbol+
                                          ((int.parse(cartItems[index].prices.price)/100)*(cartItems[index].quantity)).toStringAsFixed(2),
                                        style: TextStyle(
                                            fontSize:14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10,)
                            ],
                          );
                        },

                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.02,
                    ),
                    Row(
                      children: [
                        Text(
                          'Subtotal',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize:
                              MediaQuery.of(context).size.height * .02),
                        ),
                        Spacer(),
                        Text("\$"+
                          ((int.parse(totalPrice.toString())/100)).toStringAsFixed(2),
                          style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.height * .025,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.01,
                    ),
                    Row(
                      children: [
                        Text(
                          'Shipping Fee',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize:
                              MediaQuery.of(context).size.height * .02),
                        ),
                        Spacer(),
                        Text(
                          '\$0',
                          style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.height * .025,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.03,
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Row(
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize:
                              MediaQuery.of(context).size.height * .02),
                        ),
                        Spacer(),
                        Text("\$"+
                          ((int.parse(totalPrice.toString())/100)).toStringAsFixed(2),
                          style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.height * .025,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.05,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
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
                              'Proceed To Buy',
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
