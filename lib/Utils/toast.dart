 import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastConstant{

 static void showToast(BuildContext context, String msg) {
   Fluttertoast.showToast(
       msg: msg,
       toastLength: Toast.LENGTH_SHORT,
       backgroundColor: Colors.black,
       textColor: Colors.white,
   );
 }
 static String ERROR_MSG_401 = "401 Unauthorized";
 static String ERROR_MSG_404 = "404 Page Not Found";
 static String ERROR_MSG_405 = "405 Method Not Allowed";
 static String ERROR_MSG_422 = "422 Unprocessable Entity";
 static String ERROR_MSG_500 = "500 Internal Server Error";
 static String ERROR_MSG_400 = "400 Bad Request Exception";
 static String ERROR_MSG_DEFAULT = "Error api failed";
 static String ERROR_MSG_EMAIL_NOT_EXIST = "Email doest not Exist!";

 static int countNotifications = 2;

}