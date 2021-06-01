import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/country.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:lazy_chair/screens/bottom_navigation/bottom_navigation.dart';
import 'package:lazy_chair/screens/global.dart';
import 'package:lazy_chair/screens/signup_screen/signup_screen.dart';
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

  /*void showSnackbar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }*/

  @override
  void initState() {
    // TODO: implement initState
    verifyPhoneNumber();
    super.initState();
  }
  var _formKey = GlobalKey<FormState>();

  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    signInWithPhoneNumber();
    _formKey.currentState.save();
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
          Show_toast_Now("OTP Sent Successfully", Colors.green);
          print("verification code: " + verificationId);
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
          Show_toast_Now("OTP Sent Successfully", Colors.green);
          print("verification code: " + verificationId);
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
      print("Successfully signed in UID: ${user.uid}");
                  //showSnackbar("Successfully signed in UID: ${user.uid}");
    } catch (e) {
      Show_toast_Now(e.toString(),Colors.red);
      print("Failed to sign in: " + e.toString());
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

                        /*ElevatedButton(
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
                                child: Text("Login",style: TextStyle(fontSize: 16,color: Colors.white),textAlign: TextAlign.center,),
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
  Country countryCode = Country.MY;

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

      "phone_no": "+"+countryCode.dialingCode+phoneController.text.toString(),

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
        Show_toast_Now("User Not Registered", Colors.red);
        Navigator.pop(loadContext);



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
      backgroundColor: Colors.orange.shade50,
      
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Center(child: Image.asset("assets/logo.png",height: 100,)),
                  SizedBox(height: 30,),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text("Phone Login"),
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
                            controller: phoneController,
                            title: "",
                            keyboardType: TextInputType.number,
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

                  ),

                  SizedBox(height: 20,),

                  GestureDetector(
                    onTap: (){
                      print("+"+countryCode.dialingCode+phoneController.text);
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
                          child: Text("Send OTP",style: TextStyle(fontSize: 16,color: Colors.white),textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Spacer(),
                      RichText(
                        text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                                fontSize: 13,color: GlobalData.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Create Account",
                                  style: TextStyle(
                                      fontSize: 13,color: GlobalData.black,decoration: TextDecoration.underline
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context)=>SignUpScreen()));
                                    }
                              )
                            ]
                        ),),
                      Spacer(),

                    ],
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
