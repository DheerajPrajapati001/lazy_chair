import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lazy_chair/config/config.dart';
import 'package:lazy_chair/model/cart_products.dart';
import 'package:woocommerce/models/cart_item.dart';
import 'package:woocommerce/woocommerce_error.dart';
import '../global.dart';

class Shipping extends StatefulWidget {

  @override
  _ShippingState createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {

  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController country = new TextEditingController();
  TextEditingController state = new TextEditingController();
  TextEditingController city = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController pinCode = new TextEditingController();
  TextEditingController phoneNo = new TextEditingController();
  TextEditingController emailId = new TextEditingController();
  TextEditingController notes = new TextEditingController();

  var _formKey = GlobalKey<FormState>();

  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    placeOrder(productList: GlobalData.cartProductList);
    _formKey.currentState.save();
  }

  placeOrder({List productList})async{
    BuildContext loadContext;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          loadContext = ctx;
          return AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Container(
                child: Center(child: CircularProgressIndicator()),
              )
            //Center(child: CircularProgressIndicator())
          );
        });
    Map data = {

      "payment_method": "cod",
      "payment_method_title": "Cash on delivery",
      "set_paid": "false",
      "customer_note":notes.text,
      "customer_id":GlobalData.userId,
      "billing": {
        "first_name": firstName.text,
        "last_name": lastName.text,
        "company": "",
        "address_1": address.text,
        "address_2": "",
        "city": city.text,
        "state": state.text,
        "postcode": pinCode.text,
        "country": country.text,
        "email": emailId.text,
        "phone": phoneNo.text
      },
      "shipping": {
        "first_name": firstName.text,
        "last_name": lastName.text,
        "company": "",
        "address_1": address.text,
        "address_2": "",
        "city": city.text,
        "state": state.text,
        "postcode": pinCode.text,
        "country": country.text
      },



      "line_items": productList/*[
        {
          "product_id": "10",
          "quantity":"5"
        },
        {
          "product_id": "18",
          "quantity":"4"
        }
      ]*/,
      "shipping_lines": [
        {
          "method_id": "flat_rate",
          "method_title":"Flat Rate",
          "total":"0"
        }
      ]

    };
    //encode Map to JSON
    var body = json.encode(data);
    await http.post(Config.jsonUrl+"orders"+"?"+"consumer_key=ck_b41339e6bc5df240cc4d02427ea1cd68f4736f85&consumer_secret=cs_89828f212a6e0b99c1be5cdf0e7fff7f880face6",
      body: body,
      headers: {"Content-Type": "application/json"},

    ).then((response) {
      var status = jsonDecode(response.body);
      print(body);
      print("breakkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
      print(response.body.toString());
      print("111111111111111222222222222222222222");

      print(status['id']);
      print(status['shipping_total']);
      print(status['total']);
      GlobalData.orderId=status['id'];
      GlobalData.orderShippingTotal=status['shipping_total'];
      GlobalData.orderTotal= status['total'];
      print("111111111111111222222222222222222222");
      print(GlobalData.userId);
      GlobalData.cartProductList.clear();
      Navigator.pop(loadContext);

      Navigator.pushNamed(context, 'Confirmation');

    });
  }


  List<CartProducts> cartList= [];
  List<WooCartItem> cartItems = [];
  var totalPrice=0;
  /*viewCartItems() async {
    GlobalData.isLoading=true;
    setState(() {

    });
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer '+GlobalData.tokenId,
      'X-WC-Store-API-Nonce': GlobalData.nonceKey
    };
    *//* if (variations != null)
      {data['variations'] = variations;}
    else{
      data['variations'] ="";
    }*//*

    http.get(
        'https://beta.saurabhenterprise.com/wp-json/wc/store/cart/items',
        headers: requestHeaders).then((response) async{
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonStr = json.decode(response.body);
        print('response gotten : '+response.statusCode.toString());



        cartList = (jsonStr as List).map((data) =>
            CartProducts.fromJson(data)).toList();
        //print(cartList[0].productId);
        //print(cartList[0].quantity);
        //List<Map<String,dynamic>> cartProductList=[];
        for(int  i =0;i<cartList.length;i++)
        {
          GlobalData.cartProductList.add({
            "product_id":cartList[i].productId,
            "quantity":cartList[i].quantity
          });

          print(cartList[i].productId);
          print(cartList[i].quantity);
        }
        print("cartlist");
        // GlobalData.cartItemsList=jsonEncode(cartList);
        print(jsonEncode(cartList));
        print("List");
        print(GlobalData.cartItemsList);



        //print(jsonStr["id"]);
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

        GlobalData.isLoading=false;
        setState(() {

        });
       // await calculateTotalPrice();
        print('account user fetch : '+jsonStr.toString());
        return cartItems;

        // return WooCartItem.fromJson(jsonStr);
      } else {
        WooCommerceError err =
        WooCommerceError.fromJson(json.decode(response.body));
        throw err;
      }
    });
    *//*setState(() {

    });
    GlobalData.isLoading=false;
    setState(() {

    });*//*

  }*/

  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalData.orange,
        centerTitle: true,
        title: Text(
          "Shipping",
          style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * .045,
              fontWeight: FontWeight.w500),
        ),

        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(
                  height: MediaQuery.of(context).size.height*.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              title: 'First Name',
                              controller: firstName,
                              hintText: "Enter First Name",
                              validator: (value){
                                if (value == null || value.isEmpty) {
                                  return 'Enter first name';
                                }
                                return null;

                              },                          ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*.05,
                          ),
                          Expanded(
                            child: CustomTextField(
                              title: 'Last Name',
                              controller: lastName,
                              hintText: "Enter Last Name",
                              validator: (value){
                                if (value == null || value.isEmpty) {
                                  return 'Enter last name';
                                }
                                return null;

                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*.02,
                      ),
                      CustomTextField(
                        title: 'Address',
                        controller: address,
                        hintText: "Enter Address",
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return 'Enter address';
                          }
                          return null;

                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*.02,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              title: 'City',
                              controller: city,
                              hintText: "Enter City",
                              validator: (value){
                                if (value == null || value.isEmpty) {
                                  return 'Enter city';
                                }
                                return null;

                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*.05,
                          ),
                          Expanded(
                            child: CustomTextField(
                              title: 'ZIP Code',
                              controller: pinCode,
                              hintText: "Enter Zip Code",
                              validator: (value){
                                if (value == null || value.isEmpty) {
                                  return 'Enter zip code';
                                }
                                return null;

                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*.02,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              title: 'Country',
                              controller: country,
                              hintText: "Enter Country",
                              validator: (value){
                                if (value == null || value.isEmpty) {
                                  return 'Enter country';
                                }
                                return null;

                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*.05,
                          ),
                          Expanded(
                            child: CustomTextField(
                              title: 'State',
                              controller: state,
                              hintText: "Enter State",
                              validator: (value){
                                if (value == null || value.isEmpty) {
                                  return 'Enter state';
                                }
                                return null;

                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*.02,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              title: 'Email',
                              controller: emailId,
                              hintText: "Enter Email",
                              validator: (value){
                                if (value.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                  return 'Enter email';
                                }
                                return null;

                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*.05,
                          ),
                          Expanded(
                            child: CustomTextField(
                              title: 'Phone',
                              controller: phoneNo,
                              hintText: "Enter Phone Number",
                              validator: (value){
                                if (value == null || value.isEmpty) {
                                  return 'Enter phone number';
                                }
                                return null;

                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*.02,
                      ),
                      CustomTextField(
                        title: 'Notes',
                        controller: notes,
                        hintText: "Enter Notes",
                        /*validator: (value){
                          if (value == null || value.isEmpty) {
                            return 'Enter phone number';
                          }
                          return null;

                        }*/
                      )
                    ],
                  ),
                ),
                /*Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Row(
                    children: [
                      Checkbox(
                          activeColor: Colors.black,
                          value: check, onChanged: (a){
                        setState(() {
                          check=a;
                        });
                      }),
                      Text('Save for faster checkout next time',style: TextStyle(color: Colors.black.withOpacity(0.5)),)
                    ],
                  ),
                ),*/
                SizedBox(
                  height: MediaQuery.of(context).size.height*.06,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0,0),
                          spreadRadius: 5,
                          blurRadius: 5
                        )
                      ],
                      borderRadius: BorderRadius.only(topRight: Radius.circular(0),topLeft: Radius.circular(0))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 30),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height*.01,
                        ),
                       /* Row(
                          children: [
                            Text(
                              'Additional Shipping Charge',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize:
                                  MediaQuery.of(context).size.height * .02),
                            ),
                            Spacer(),
                            Text(
                              '\$5.50',
                              style: TextStyle(
                                  fontSize:
                                  MediaQuery.of(context).size.height * .025,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),*/
                       /* Divider(
                          color: Colors.black,
                        ),*/

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
                            Text(
                              "\$"+
                              ((GlobalData.totalPrice/100)).toStringAsFixed(2),

                              style: TextStyle(
                                color: GlobalData.orange,
                                  fontSize:
                                  MediaQuery.of(context).size.height * .025,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: GlobalData.orange,
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5))),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                //cartList.clear();
                                //cartItems.clear();
                                //GlobalData.cartProductList.clear();
                                print("cartItems: "+cartItems.length.toString());
                                print(cartList.length);
                                GlobalData.cartTotal=((GlobalData.totalPrice/100)).toStringAsFixed(2);
                                print("cart total "+GlobalData.cartTotal);
                                _submit();
                                print(GlobalData.cartProductList);
                                //Navigator.pushNamed(context, 'Confirmation');
                              },
                              splashColor: Colors.black.withOpacity(0.1),
                              child: Center(
                                child: Text(
                                  'Place Order',
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
        ),
      ),
    );
  }
}

/*
class CustomTextField extends StatelessWidget {
  final String title;
  final Color hintColor;
  final String hintText;
  final TextEditingController controller;
  final TextStyle hintStyle;
  final FormFieldValidator validator;


  const CustomTextField({Key key, this.title,this.controller,this.hintColor,this.hintStyle,this.hintText,this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: TextStyle(
          fontSize: MediaQuery.of(context).size.width*.04,
          color: Colors.black.withOpacity(0.5)
        ),),
        SizedBox(
          height: MediaQuery.of(context).size.height*.01,
        ),
        Container(
          height: MediaQuery.of(context).size.height*.065,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.3)
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Theme(
                data: ThemeData(hintColor: hintColor),
                child: TextFormField(
                  validator: validator,
                  controller: controller,style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),

                    hintText: hintText,
                    hintStyle: TextStyle(fontSize: 12),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}*/

