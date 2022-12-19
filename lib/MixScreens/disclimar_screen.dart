import 'package:flutter/material.dart';

import '../Utils/Constants.dart';
import '../localization/Language/languages.dart';
class DisclimarScreen extends StatelessWidget {
  const DisclimarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _height * 0.07,
        elevation: 0.0,
        backgroundColor: Color(0xFF256D85),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 35,
            color: Colors.white,
          ),
        ),
        actions: [
          SizedBox(
            width: _width * 0.0,
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: _height * 0.02,
                ),
                Text(
                  Languages.of(context)!.discliamr_bar,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                )
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(top:_height*0.02,left: _height*0.03,right:_height*0.03 ),
          child: Center(
            child: Text(Languages.of(context)!.disclaimer,style: TextStyle(
              fontSize: 23.0,
              fontFamily: Constants.fontfamily
            ),),
          ),
        ),
      ),
    );
  }
}
