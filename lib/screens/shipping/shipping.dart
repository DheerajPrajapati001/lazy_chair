import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lazy_chair/config/config.dart';
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
    placeOrder();
    _formKey.currentState.save();
  }

  placeOrder()async{

    Map data = {

      "payment_method": "cod",
      "payment_method_title": "Cash on delivery",
      "set_paid": "false",
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



      "line_items": [
        {
          "product_id": "10",
          "quantity":"5"
        },
        {
          "product_id": "18",
          "quantity":"4"
        }
      ],
      "shipping_lines": [
        {
          "method_id": "flat_rate",
          "method_title":"Flat Rate",
          "total":"200"
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
      print(GlobalData.userId);
      Navigator.pushNamed(context, 'Confirmation');

    });
  }

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
                                _submit();
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

