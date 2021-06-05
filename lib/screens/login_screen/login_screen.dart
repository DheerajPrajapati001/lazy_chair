import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lazy_chair/screens/bottom_navigation/bottom_navigation.dart';
import 'package:lazy_chair/screens/home_screen/home_screen.dart';
import 'package:lazy_chair/screens/login_screen/phone_login.dart';
import 'package:lazy_chair/screens/signup_screen/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global.dart';
import 'package:lazy_chair/localization/language_constants.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  bool _obscureText = true;
  SharedPreferences prefs;


  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    login();
    _formKey.currentState.save();
  }


  login() async {
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
    prefs = await SharedPreferences.getInstance();

    await http.post(Uri.parse("https://beta.saurabhenterprise.com/wp-json/jwt-auth/v1/token"), body: {
      "username": email.text.toString().trim(),
      "password": password.text.toString(),

    }).then((response) async {
      var status = jsonDecode(response.body);
      print(response.body.toString());

      if (status['success']==false) {
        print("Not Allowed");
        print("Not Allowed");
        Navigator.pop(loadContext);

        Show_toast_Now("Invalid Username or Password", Colors.red);

      }
      else
        {
          Navigator.pop(loadContext);
          //saving(context);

        GlobalData.userId= status['data']['id'];
        print(status['data']['id']);
        print(GlobalData.userId);
        prefs.setInt("Id", GlobalData.userId);
        prefs.setString("TokenId", status['data']['token']);
        prefs.setString("Email", status['data']['email']);
        prefs.setString("NiceName", status['data']['nicename']);
        prefs.setString("FirstName", status['data']['firstName']);
        prefs.setString("LastName", status['data']['lastName']);


        GlobalData.tokenId=status['data']['token'];
        GlobalData.userId= status['data']['id'];
        GlobalData.emailId= status['data']['email'];
        GlobalData.firstName = status['data']['firstName'];
        GlobalData.lastName = status['data']['lastName'];
        GlobalData.niceName = status['data']['nicename'];
        print("Id: "+GlobalData.userId.toString());
        print("Token Id: "+GlobalData.tokenId);
        print("Email Id: "+GlobalData.emailId);
        print("First Name: "+GlobalData.firstName);
        print("Last Name: "+GlobalData.lastName);
        print("Nice Name: "+GlobalData.niceName);
        print("Allowed");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
          Show_toast_Now("Login Successfully", Colors.green);
      }
    });
    /*.catchError( (error){
        print(error);
        print("Not Allowed");

      });*/


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange.shade50,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Center(child: Image.asset("assets/logo.png",height: 100,)),
                      CustomTextField(
                        title: "Email",
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
                              hintText: "Enter valid password",
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
                      /*CustomTextField(
                        controller: password,
                        hintText: "Enter valid password",
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return 'Enter password';
                          }
                          return null;
                        },
                      ),*/

                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                            text: getTranslated(context, "don't_have_an_account"),
                                style: TextStyle(
                                    fontSize: 12,color: GlobalData.black
                                ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Create Account",
                                  style: TextStyle(
                                      fontSize: 12,color: GlobalData.black,decoration: TextDecoration.underline
                                  ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                                      }
                                )
                              ]
                          ),),

                        ],
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: GestureDetector(
                          onTap: (){

                            _submit();},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: GlobalData.white)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                              child: Text("Login",style: TextStyle(fontSize: 16,color: Colors.black),),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Center(
                          child: GestureDetector(
                              onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneLoginScreen()));
                              },
                              child: Text("Phone Login",style: TextStyle(color: GlobalData.black,fontSize: 14),)
                          )
                      ),
                      SizedBox(height: 20,),
                      Center(
                          child: GestureDetector(
                              onTap:(){
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>UserSignup()));
                                },
                              child: Text("Forgot Password?",style: TextStyle(color: GlobalData.black,fontSize: 14),)
                          )
                      )
                    ],
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
