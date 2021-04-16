import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lazy_chair/config/config.dart';
import 'package:lazy_chair/screens/home_screen/home_screen.dart';
import 'package:lazy_chair/screens/login_screen/login_screen.dart';

import '../global.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController userName = new TextEditingController();
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  bool _obscureText = true;

  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    //SignUp();
    //register();
    createCustomer();
    //saving(context);
   // Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryPage()));

    _formKey.currentState.save();
  }

  createCustomer()async{

    isLoading = true;
    setState(() {

    });
    bool ret = false;
    await http.post(Config.jsonUrl+Config.customerUrl+"?"+"consumer_key="+Config.key+"&"+"consumer_secret="+Config.secret, body: {
      'email':email.text,
      'first_name':firstName.text,
      'last_name':lastName.text,
      'password':password.text,
      'username':userName.text

    },).then((response) async {
      var status = jsonDecode(response.body);
      print(response.body.toString());


      print(response.statusCode);
      if (response.statusCode == 201)
      {
        saving(context);
        Show_toast_Now("Registered Successfully", Colors.green);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));


      } else {
        Show_toast_Now(status['message'].toString().split("<").toString(), Colors.red);
        print(status['message'].toString().replaceAll("<a href='#' class='showlogin'>","").toString());
      }

    });

    setState(() {

    });
    isLoading = false;
    setState(() {

    });
    return ret;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Text("Username"),
                        CustomTextField(
                          controller: userName,
                          hintText: "Enter Username",
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Enter Username';
                            }
                            return null;

                          },
                        ),


                        Text("First Name"),
                        CustomTextField(
                          controller: firstName,
                          hintText: "Enter First Name",
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Enter first name';
                            }
                            return null;

                          },
                        ),
                        SizedBox(height: 10,),
                        Text("Last Name"),
                        CustomTextField(
                          controller: lastName,
                          hintText: "Enter First Name",
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Enter last name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10,),
                        Text("Email"),
                        CustomTextField(
                          controller: email,
                          hintText: "Enter Email",
                          validator: (value){
                            if (value.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return 'Enter a valid email!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10,),
                        Text("Password"),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0, top: 5,bottom: 5),
                        child: TextFormField(
                          obscureText: _obscureText,
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Enter password';
                            }
                            return null;
                          },
                          controller: password,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            hintText: "Enter Password",
                            suffixIcon: IconButton(
                              icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: GlobalData.black),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            hintStyle: TextStyle(fontSize: 14),
                          ),


                        ),
                      ),
                    ),

                        SizedBox(height: 20,),
                        Center(
                          child: GestureDetector(
                            onTap: (){

                              _submit();},
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                                child: Text("Sign Up",style: TextStyle(fontSize: 16,color: Colors.black),),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: RichText(
                            text: TextSpan(
                                text: "Already created an account? ",
                                style: TextStyle(
                                    fontSize: 14,color: GlobalData.black
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "Login",
                                      style: TextStyle(
                                          fontSize: 14,color: GlobalData.black,decoration: TextDecoration.underline
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                                        }
                                  )
                                ]
                            ),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
