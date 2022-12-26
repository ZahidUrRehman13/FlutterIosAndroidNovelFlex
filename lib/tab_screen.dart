import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MixScreens/MyCorner.dart';
import 'TabScreens/home_screen.dart';
import 'TabScreens/profile_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int pageIndex = 0;

  final Screen = [
    HomeScreen(),
    MyCorner(),
    Profile_Screen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      height: _height * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            iconSize: 55,
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home,
                    color: Color(0xFF256D85),
                    size: 35,
                  )
                : const Icon(
                    Icons.home,
                    color: Colors.black,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? Image.asset(
                    "assets/quotes_data/icon_home_my_corner.png",
                    height: _height*0.07,
                    width: _width*0.07,
                    color: Color(0xFF256D85),
                  )
                : Image.asset(
                    "assets/quotes_data/icon_home_my_corner.png",
                    color: Colors.black,
              height: _height*0.07,
              width: _width*0.07,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.person_pin,
                    color: Color(0xFF256D85),
                    size: 35,
                  )
                : const Icon(
                    Icons.person_pin,
                    color: Colors.black,
                    size: 35,
                  ),
          ),
        ],
      ),
    );
  }
}
