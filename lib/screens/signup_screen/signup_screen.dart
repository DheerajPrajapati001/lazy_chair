import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lazy_chair/config/config.dart';
import 'package:lazy_chair/screens/bottom_navigation/bottom_navigation.dart';
import 'package:lazy_chair/screens/home_screen/home_screen.dart';
import 'package:lazy_chair/screens/login_screen/login_screen.dart';
import 'package:lazy_chair/screens/login_screen/phone_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

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
  TextEditingController phoneNo = new TextEditingController();

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  bool _obscureText = true;
  Country countryCode = Country.MY;


  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      print(countryCode.dialingCode+phoneNo.text);
      return;
    }
    //SignUp();
    //register();
    print("+"+countryCode.dialingCode+phoneNo.text);
    createCustomer();
    //saving(context);
   // Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryPage()));

    _formKey.currentState.save();
  }
  SharedPreferences prefs;
  /*login() async {
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
        //Navigator.pop(loadContext);
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
    *//*.catchError( (error){
        print(error);
        print("Not Allowed");

      });*//*


  }


  registerCustomer()async{
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
    isLoading = true;
    setState(() {

    });
    Map data = {

      'email':email.text,
      'password':password.text,
      'username':userName.text,
      "phone_no": "+"+countryCode.dialingCode+phoneNo.text,

    };
    //encode Map to JSON
    var body = json.encode(data);
    bool ret = false;
    await http.post(Uri.parse("https://beta.saurabhenterprise.com/wp-json/wp/v2/users/register"),
      body: body,
      headers: {"Content-Type": "application/json"},
    ).then((response) async {
      var status = jsonDecode(response.body);
      print(response.body.toString());



      print(response.statusCode);
      if (response.statusCode == 201)
      {

        print("CUSTOMER REGISTERED");
        GlobalData.phoneNumber="+"+countryCode.dialingCode+phoneNo.text.toString();
        Navigator.pop(loadContext);
        //saving(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
        Show_toast_Now("Registered Successfully", Colors.green);


      } else {
        Navigator.pop(loadContext);
        var document =parse(status['message']);
        final String parsedString = parse(document.body.text).documentElement.text;
        print(parsedString);

        Show_toast_Now(parsedString, Colors.red);
      }

    });

    setState(() {

    });
    isLoading = false;
    setState(() {

    });
    return ret;
  }*/


  createCustomer()async{
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
    isLoading = true;
    setState(() {

    });
    Map data = {

      'email':email.text,
      'first_name':firstName.text,
      'last_name':lastName.text,
      'password':password.text,
      'username':userName.text,
      "billing": {
        "email": email.text,
        "phone": "+"+countryCode.dialingCode+phoneNo.text
      },

    };
    //encode Map to JSON
    var body = json.encode(data);
    bool ret = false;
    await http.post(Uri.parse(Config.jsonUrl+Config.customerUrl+"?"+"consumer_key="+Config.key+"&"+"consumer_secret="+Config.secret),
      body: body,
      headers: {"Content-Type": "application/json"},
    ).then((response) async {
      var status = jsonDecode(response.body);
      print(response.body.toString());



      print(response.statusCode);
      if (response.statusCode >= 200 && response.statusCode < 300)
      {

        print("LOGIN DONEEEEEEEEEEEEEEEE");
        GlobalData.phoneNumber="+"+countryCode.dialingCode+phoneNo.text.toString();
        GlobalData.password=password.text.toString();
        GlobalData.emailId=email.text;
        GlobalData.userName=userName.text;
        /*Navigator.pop(loadContext);
        await registerCustomer();
        await login();*/
        Navigator.pop(loadContext);
        //saving(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen()));
        Show_toast_Now("Registered Successfully", Colors.green);


      } else {
        Navigator.pop(loadContext);
        var document =parse(status['message']);
        final String parsedString = parse(document.body.text).documentElement.text;
        print(parsedString);

        Show_toast_Now(parsedString, Colors.red);
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
        backgroundColor: Colors.orange.shade50,
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
                        Center(child: Image.asset("assets/logo.png",height: 100,)),


                        //Text("Username"),
                        CustomTextField(
                          title: "Username",
                          controller: userName,
                          hintText: "Enter Username",
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Enter Username';
                            }
                            return null;

                          },
                        ),

                        SizedBox(height: 10,),
                        //Text("First Name"),
                        CustomTextField(
                          title: "First Name",

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
                        //Text("Last Name"),
                        CustomTextField(
                          title: "Last Name",

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
                        //Text("Email"),
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
                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text("Phone Number"),
                                SizedBox(height: 10,),
                                CountryPicker(
                                  dense: false,
                                  showFlag: true,
                                  showDialingCode: true,
                                  showCurrency: false,
                                  showCurrencyISO: false,
                                  showName: false,
                                  onChanged: (Country country) {
                                    setState(() {
                                      countryCode = country;
                                    });
                                  },
                                  selectedCountry: countryCode,
                                ),
                              ],
                            ),
                            Expanded(
                              child: CustomTextField(
                                title: "",
                                keyboardType: TextInputType.number,
                                controller: phoneNo,
                                hintText: "Enter Phone Number",
                                validator: (value){
                                  if (value == null || value.isEmpty) {
                                    return 'Enter Phone Number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: GestureDetector(
                            onTap: (){


                               if(phoneNo.text.length==11||phoneNo.text.length==10||phoneNo.text.length==9||phoneNo.text.length==8)
                               {
                                 _submit();
                               }
                             else{
                               Show_toast_Now("Invalid Phone Number", Colors.red);
                             }

                              },
                            child: SizedBox(
                              width: double.infinity,
                              child: Container(

                                decoration: BoxDecoration(

                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(8),

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                                  child: Text("Sign Up",style: TextStyle(fontSize: 16,color: Colors.white),
                                    textAlign: TextAlign.center,),
                                ),
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
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneLoginScreen()));
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



class OtpScreen extends StatefulWidget {
  const OtpScreen({Key key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //authStatus="";
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  String _verificationId;
  final SmsAutoFill _autoFill = SmsAutoFill();
  SharedPreferences prefs;
  Country countryCode = Country.IN;
  var isLoading = false;
  /*void showSnackbar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }*/
  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    print(GlobalData.emailId);
    print(GlobalData.password);
    print(GlobalData.userName);
    print(GlobalData.phoneNumber);
    signInWithPhoneNumber();
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
      "username": GlobalData.emailId,
      "password": GlobalData.password,

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
        //Navigator.pop(loadContext);
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


  registerCustomer()async{
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
    isLoading = true;
    setState(() {

    });
    Map data = {

      'email':GlobalData.emailId,
      'password':GlobalData.password,
      'username':GlobalData.userName,
      "phone_no": GlobalData.phoneNumber,

    };
    //encode Map to JSON
    var body = json.encode(data);
    bool ret = false;
    await http.post(Uri.parse("https://beta.saurabhenterprise.com/wp-json/wp/v2/users/register"),
      body: body,
      headers: {"Content-Type": "application/json"},
    ).then((response) async {
      var status = jsonDecode(response.body);
      print(response.body.toString());



      print(response.statusCode);
      if (response.statusCode == 201)
      {

        print("CUSTOMER REGISTERED");
        //GlobalData.phoneNumber="+"+countryCode.dialingCode+phoneNo.text.toString();
        Navigator.pop(loadContext);
        //saving(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
        Show_toast_Now("Registered Successfully", Colors.green);


      } else {
        Navigator.pop(loadContext);
        var document =parse(status['message']);
        final String parsedString = parse(document.body.text).documentElement.text;
        print(parsedString);

        Show_toast_Now(parsedString, Colors.red);
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
  void initState() {
    // TODO: implement initState
    verifyPhoneNumber();
    super.initState();
  }

  int resendToken;

  sendOtp() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: GlobalData.phoneNumber,
        forceResendingToken: resendToken,
        timeout: const Duration(seconds: 15),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _auth.signInWithCredential(phoneAuthCredential);
          print("Phone number automatically verified and user signed in: ${_auth.currentUser.uid}");
          //showSnackbar("Phone number automatically verified and user signed in: ${_auth.currentUser.uid}");
        },
        verificationFailed: (FirebaseAuthException authException) {
          if (authException.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
          Show_toast_Now('too-many-requests. We have blocked all requests from this device due to unusual activity.', Colors.red);

          print('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
          //showSnackbar('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
        },
        codeSent: (String verificationId, int forceResendingToken) async {
          resendToken = forceResendingToken;
          String smsCode = _smsController.text;

          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await _auth.signInWithCredential(credential);
          print('Please check your phone for the verification code.');
          //showSnackbar('Please check your phone for the verification code.');
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout:  (String verificationId) {
          print("verification code: " + verificationId);
          Show_toast_Now("OTP Sent Successfully", Colors.green);
          //showSnackbar("verification code: " + verificationId);
          _verificationId = verificationId;
        },);
    } catch (e) {
      print("Failed to Verify Phone Number: ${e}");
      //showSnackbar("Failed to Verify Phone Number: ${e}");
    }
  }
  void verifyPhoneNumber()async{
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: GlobalData.phoneNumber,
        timeout: const Duration(seconds: 15),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _auth.signInWithCredential(phoneAuthCredential);
          print("Phone number automatically verified and user signed in: ${_auth.currentUser.uid}");
         // showSnackbar("Phone number automatically verified and user signed in: ${_auth.currentUser.uid}");
        },
        verificationFailed: (FirebaseAuthException authException) {
          if (authException.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
          Show_toast_Now('too-many-requests. We have blocked all requests from this device due to unusual activity.', Colors.red);
          print('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
          //showSnackbar('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
        },
        codeSent: (String verificationId, int forceResendingToken) async {
          String smsCode = _smsController.text;

          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await _auth.signInWithCredential(credential);
          print('Please check your phone for the verification code.');
          //showSnackbar('Please check your phone for the verification code.');
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout:  (String verificationId) {
          print("verification code: " + verificationId);
          Show_toast_Now("OTP Sent Successfully", Colors.green);
          //showSnackbar("verification code: " + verificationId);
          _verificationId = verificationId;
        },);
    } catch (e) {
      print("Failed to Verify Phone Number: ${e}");
      //showSnackbar("Failed to Verify Phone Number: ${e}");
    }
  }

  void signInWithPhoneNumber() async {
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
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsController.text,
      );

      final User user = (await _auth.signInWithCredential(credential)).user;
      prefs = await SharedPreferences.getInstance();

      //Navigator.pop(loadContext);
      await registerCustomer();
      await login();


      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
      Show_toast_Now("Registered Successfully", Colors.green);

      //showSnackbar("Successfully signed in UID: ${user.uid}");
    } catch (e) {
      //showSnackbar("Failed to sign in: " + e.toString());
      print(e.toString());
    }
  }

  /*phoneVerificationDone(){
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      showSnackbar("Phone number automatically verified and user signed in: ${_auth.currentUser.uid}");
    };
  }
  phoneVerificationFailed(){
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      showSnackbar('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    };
  }
  phoneCodeSent(){
    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      showSnackbar('Please check your phone for the verification code.');
      _verificationId = verificationId;
    };
  }
  phoneCodeRetrieval(){
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      showSnackbar("verification code: " + verificationId);
      _verificationId = verificationId;
    };
  }*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange.shade50,
        key: _scaffoldKey,
        //resizeToAvoidBottomPadding: false,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(padding: const EdgeInsets.all(8),
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(child: Image.asset("assets/logo.png",height: 100,)),
                        SizedBox(height: 30,),
                        CustomTextField(
                          controller: _smsController,
                          title: "Enter the OTP sent on "+GlobalData.phoneNumber,
                          hintText: 'Enter OTP here',
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Enter OTP';
                            }
                            return null;
                          },
                        ),

                       /*
                        ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                              sendOtp();
                            }, child: Text("Resend Code")),*/

                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: ()async{
                            _submit();
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: GlobalData.white)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                                child: Text("Continue",style: TextStyle(fontSize: 16,color: Colors.white),textAlign: TextAlign.center,),
                              ),
                            ),
                          ),
                        ),

                      ],
                    )
                ),
              ),
            ),
          ),
        )
    );
  }
}