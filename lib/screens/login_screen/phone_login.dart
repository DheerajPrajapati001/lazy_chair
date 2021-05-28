


/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneLoginScreen extends StatefulWidget {
  static String route = "MyLogin";

  @override
  _PhoneLoginScreenState createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  TextEditingController phoneController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;




  String phoneNumber, verificationId;
  String otp, authStatus = "";

  Future<void> verifyPhoneNumber(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${phoneController.text}",
      timeout: const Duration(seconds: 20),
      verificationCompleted: (AuthCredential authCredential) {
        FirebaseAuth.instance.signInWithCredential(authCredential).then((value) async {
          if(value.user!=null && value.user.uid!=null){

          }
        });

      },
      verificationFailed: (authException) {
        setState(() {
          authStatus = "Authentication failed";
        });
      },
      codeSent: (String verId, [int forceCodeResent]) {
        verificationId = verId;
        setState(() {
          authStatus = "OTP has been successfully send";
        });
        otpDialogBox(context).then((value) {});
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
        setState(() {
          authStatus = "TIMEOUT";
        });
      },
    );
  }

  otpDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter your OTP'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  otp = value;

                },
              ),
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  signIn(otp);
                },
                child: Text(
                  'Submit',
                ),
              ),
            ],
          );
        });
  }

  Future<void> signIn(String otp) async {
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    ))
        .then((value) async {

      print("User Logged");

    }).catchError((onError) {
      if (onError != null && onError.message != null) {
        print(onError.message);

      }
    });
  }



  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Container(
              height: MediaQuery.of(context).size.height * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  TextField(

                    keyboardType: TextInputType.phone,
                    controller: phoneController,

                    onChanged: (v) {
                      phoneNumber = v;
                    },

                  ),

                  RaisedButton(
                      child: Text("Get OTP"),
                      onPressed: () {
                        print(phoneNumber);
                        verifyPhoneNumber(context);

                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }




}*/



import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lazy_chair/screens/bottom_navigation/bottom_navigation.dart';
import 'package:lazy_chair/screens/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../global.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //authStatus="";
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  String _verificationId;
  final SmsAutoFill _autoFill = SmsAutoFill();
  SharedPreferences prefs;
  void showSnackbar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    // TODO: implement initState
    verifyPhoneNumber();
    super.initState();
  }
 void verifyPhoneNumber()async{
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: "+91"+GlobalData.phoneNumber,
          timeout: const Duration(seconds: 5),
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
            await _auth.signInWithCredential(phoneAuthCredential);
            showSnackbar("Phone number automatically verified and user signed in: ${_auth.currentUser.uid}");
          },
        verificationFailed: (FirebaseAuthException authException) {
          if (authException.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
          showSnackbar('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
        },
        codeSent: (String verificationId, int forceResendingToken) async {
          String smsCode = _smsController.text;

          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await _auth.signInWithCredential(credential);
          showSnackbar('Please check your phone for the verification code.');
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout:  (String verificationId) {
          showSnackbar("verification code: " + verificationId);
          _verificationId = verificationId;
        },);
    } catch (e) {
      showSnackbar("Failed to Verify Phone Number: ${e}");
    }
  }

  void signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsController.text,
      );

      final User user = (await _auth.signInWithCredential(credential)).user;
      prefs = await SharedPreferences.getInstance();

        await http.post(Uri.parse("https://beta.saurabhenterprise.com/wp-json/jwt-auth/v1/token"),
            body: {
          "username": GlobalData.emailId,
          "password": GlobalData.password,

        }).then((response) async {
          var status = jsonDecode(response.body);
          print(response.body.toString());

          if (status['success']==false) {
            print("Not Allowed");
            print("Not Allowed");
            //Navigator.pop(loadContext);

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
Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
      Show_toast_Now("Login Successfully", Colors.green);

      showSnackbar("Successfully signed in UID: ${user.uid}");
    } catch (e) {
      showSnackbar("Failed to sign in: " + e.toString());
    }
  }

  phoneVerificationDone(){
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        key: _scaffoldKey,
        //resizeToAvoidBottomPadding: false,
        body: Padding(padding: const EdgeInsets.all(8),
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /*TextFormField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(labelText: 'Phone number (+xx xxx-xxx-xxxx)'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.center,
                    child: RaisedButton(child: Text("Get current number"),
                        onPressed: () async => {
                          _phoneNumberController.text = await _autoFill.hint
                        },
                        color: Colors.greenAccent[700]),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.center,
                    child: RaisedButton(
                      color: Colors.greenAccent[400],
                      child: Text("Verify Number"),
                      onPressed: () async {
                        verifyPhoneNumber();
                      },
                    ),
                  ),*/
                  TextFormField(
                    controller: _smsController,
                    decoration: const InputDecoration(labelText: 'Verification code'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16.0),
                    alignment: Alignment.center,
                    child: RaisedButton(
                        color: Colors.greenAccent[200],
                        onPressed: () async {
                          signInWithPhoneNumber();
                        },
                        child: Text("Sign in")),
                  ),
                ],
              )
          ),
        )
    );
  }
}




class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({Key key}) : super(key: key);

  @override
  _PhoneLoginScreenState createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  TextEditingController phoneController = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  bool _obscureText = true;
  SharedPreferences prefs;
  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    phoneLogin();
    _formKey.currentState.save();
  }


  phoneLogin() async {
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
    Map data = {

      "phone_no": phoneController.text.toString(),

    };
    //encode Map to JSON
    var body = json.encode(data);
    await http.post(Uri.parse("https://beta.saurabhenterprise.com/wp-json/wp/v2/users/login"),
        body: body,
      headers: {"Content-Type": "application/json"},
    ).then((response) async {
      var status = jsonDecode(response.body);
      print(response.body.toString());

      if (status['success']==false) {
        print("FALSE");
        print("Not Allowed");
        print("Not Allowed");
        Navigator.pop(loadContext);

        Show_toast_Now("Invalid Phone Number", Colors.red);

      }
      else
      {
        print("TRUE");
        print(status['email']);
        //Navigator.pop(loadContext);
        //saving(context);

        //Show_toast_Now("Login Successfully", Colors.green);

        GlobalData.phoneNumber=status['ph_no'];
        GlobalData.emailId=status['email'];
        GlobalData.password=status['password'];
        print(GlobalData.phoneNumber);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen()));
        /*prefs = await SharedPreferences.getInstance();

        await http.post(Uri.parse("https://beta.saurabhenterprise.com/wp-json/jwt-auth/v1/token"),
            body: {
          "username": status['email'],
          "password": status['password'],

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
        });*/

      }
    });
    /*.catchError( (error){
        print(error);
        print("Not Allowed");

      });*/


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Login"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: CustomTextField(
                  controller: phoneController,
                  title: "Phone Number",
                  keyboardType: TextInputType.number,
                  validator: (value){
                    if (value == null || value.isEmpty) {
                      return 'Enter phone number';
                    }
                    return null;
                  },
                ),

              ),
            ),
            GestureDetector(
              onTap: (){
                _submit();
              },
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
          ],
        ),
      ),
    );
  }
}
