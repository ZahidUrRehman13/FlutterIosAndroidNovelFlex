import 'package:flutter/material.dart';
import 'package:novelflex/localization/Language/languages.dart';

class MyCorner extends StatefulWidget {
  const MyCorner({Key? key}) : super(key: key);

  @override
  State<MyCorner> createState() => _MyCornerState();
}

class _MyCornerState extends State<MyCorner> {
  bool saved = true;
  bool liked = false;
  bool history = false;
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffebf5f9),
      appBar: AppBar(
        title: Text(Languages.of(context)!.myCorner,
            style: const TextStyle(
                color: const Color(0xff2a2a2a),
                fontWeight: FontWeight.w700,
                fontFamily: "Alexandria",
                fontStyle: FontStyle.normal,
                fontSize: 16.0),
            textAlign: TextAlign.end),
        backgroundColor: const Color(0xffebf5f9),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      saved = true;
                      liked = false;
                      history = false;
                    });
                  },
                  child: Container(
                      width: _width * 0.25,
                      height: _height * 0.04,
                      child: Center(
                        child: Text(
                          Languages.of(context)!.saved,
                          style: _widgetTextStyle(),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(17)),
                          color: saved ? Color(0xff3a6c83) : Colors.black54)),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      saved = false;
                      liked = true;
                      history = false;
                    });
                  },
                  child: Container(
                      width: _width * 0.25,
                      height: _height * 0.04,
                      child: Center(
                        child: Text(
                          Languages.of(context)!.liked,
                          style: _widgetTextStyle(),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(17)),
                          color: liked ? Color(0xff3a6c83) : Colors.black54)),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      saved = false;
                      liked = false;
                      history = true;
                    });
                  },
                  child: Container(
                      width: _width * 0.25,
                      height: _height * 0.04,
                      child: Center(
                        child: Text(
                          Languages.of(context)!.history,
                          style: _widgetTextStyle(),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(17)),
                          color: history ? Color(0xff3a6c83) : Colors.black54)),
                )
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: _height * 0.02),
              width: _width,
              height: 1,
              decoration: BoxDecoration(color: const Color(0xffbcbcbc))),
          Expanded(
            child: Padding(
              padding:  EdgeInsets.only(top: _height*0.02,left: _width*0.03,right: _width*0.01),
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 0.78,
                mainAxisSpacing: _height*0.01,
                children: List.generate(100, (index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: _width*0.27,
                          height: _height*0.12,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                              ),
                            image: DecorationImage(
                              image: AssetImage("assets/bg_image.jpeg"),
                              fit: BoxFit.cover
                            ),
                            color: Colors.green
                          )
                      ),
                      SizedBox(height: _height*0.01,),
                      Expanded(
                        child: Text(
                            "Vivamu posuere ",
                            style: const TextStyle(
                                color:  const Color(0xff2a2a2a),
                                fontWeight: FontWeight.w500,
                                fontFamily: "Alexandria",
                                fontStyle:  FontStyle.normal,
                                fontSize: 12.0
                            ),
                            textAlign: TextAlign.left
                        ),
                      ),
                      Expanded(
                          child: Text(
                          "Tom Schneider",
                          style: const TextStyle(
                              color:  const Color(0xff676767),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Lato",
                              fontStyle:  FontStyle.normal,
                              fontSize: 12.0
                          ),
                          textAlign: TextAlign.left
                      )),
                    ],
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }

  _widgetTextStyle() {
    return const TextStyle(
        color: const Color(0xffffffff),
        fontWeight: FontWeight.w400,
        fontFamily: "Alexandria",
        fontStyle: FontStyle.normal,
        fontSize: 12.0);
  }
}
