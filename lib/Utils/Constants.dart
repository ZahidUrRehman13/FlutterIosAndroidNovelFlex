import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constants {
  static const fontfamily = 'ProximaNovaAlt';

  static void showToastBlack(BuildContext context, String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      backgroundColor: Colors.black,
      fontSize: 14,
    );
  }

  static Widget  InternetNotConnected(double height) {
    return Container(
      height:height,
      alignment: Alignment.center,
      color: Color(0xFF256D85),
      // padding: EdgeInsets.all(16.0),
      child: Text(
        "Check your Internet Connection",
        style: TextStyle(color: Colors.white, fontSize: 12.0),
      ),
    );
  }


}
