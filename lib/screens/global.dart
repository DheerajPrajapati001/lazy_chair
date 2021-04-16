import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class GlobalData{
  static String categoryId;
  static String productId;
  static String tokenId;
  static String userId;
  static String emailId;
  static String firstName;
  static String lastName;
  static String niceName;
  static String nonceKey;
  static bool isAdded = false;
  static String itemKey;
  static Color white = Colors.white;
  static Color black = Colors.black;


}
Show_toast_Now(String msg,Color color){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb	: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0
  );
}



class CustomTextField extends StatelessWidget {
  final Color hintColor;
  final String hintText;
  final TextEditingController controller;
  final TextStyle hintStyle;
  final keyboardType;
  final FormFieldValidator validator;
  final bool password;
  final IconButton suffixIcon;


  CustomTextField(
      {this.controller,
        this.validator,
        this.hintColor,
        this.hintText,
        this.hintStyle,
        this.keyboardType,
        this.password,
        this.suffixIcon
      });

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 5,bottom: 5),
        child: Theme(
          data: ThemeData(hintColor: hintColor),
          child: TextFormField(keyboardType: keyboardType,
            obscureText: password == null?false:true,

            validator: validator,
            controller: controller,style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              hintText: hintText,
              suffixIcon: suffixIcon,
              hintStyle: TextStyle(fontSize: 14),
            ),


          ),
        ),
      ),
    );
  }
}



void saving(BuildContext context)  {

  bool isSelected = false;

  showDialog(barrierDismissible: false,
      context: context,
      builder: (_) => new Dialog(
        child: new Container(
          alignment: FractionalOffset.center,
          height: 80.0,
          padding: const EdgeInsets.all(20.0),
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Padding(
                padding: new EdgeInsets.only(left: 10.0),
                child: new Text("Loading..."),
              ),
            ],
          ),
        ),
      ));
}