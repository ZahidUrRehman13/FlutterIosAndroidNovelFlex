import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/BookDetailsModel.dart';
import '../Utils/ApiUtils.dart';
import '../Utils/Constants.dart';
import 'BookDetailScreen.dart';

class BookDetailAuthor extends StatefulWidget {
  String bookID;
  BookDetailAuthor({required this.bookID});

  @override
  State<BookDetailAuthor> createState() => _BookDetailAuthorState();
}

class _BookDetailAuthorState extends State<BookDetailAuthor> {
  bool _isLoading = false;
  bool _isInternetConnected = true;
  BookDetailsModel? _bookDetailsModel;
  var token;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffebf5f9),
      appBar: AppBar(
        backgroundColor: Color(0xFF256D85),
        elevation: 0.0,
      ),
      body: _isInternetConnected == false
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "INTERNET NOT CONNECTED",
                    style: TextStyle(
                      fontFamily: Constants.fontfamily,
                      color: Color(0xFF256D85),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.019,
                  ),
                  InkWell(
                    child: Container(
                      width: _width * 0.40,
                      height: _height * 0.058,
                      decoration: BoxDecoration(
                        color: const Color(0xFF256D85),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            40.0,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "No Internet Connected",
                          style: TextStyle(
                            fontFamily: Constants.fontfamily,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      _checkInternetConnection();
                    },
                  ),
                ],
              ),
            )
          : _isLoading
              ? const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF256D85)),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width: _width * 0.6,
                            height: _height * 0.35,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: const Color(0xffebf5f9),
                            image: DecorationImage(
                              image:NetworkImage(
                                  _bookDetailsModel!.data!.bookImage.toString()
                              )
                            )),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Author",
                                  style: const TextStyle(
                                      color: const Color(0xff3a6c83),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Alexandria",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16.0),
                                  textAlign: TextAlign.left),
                              Container(
                                  width: _width * 0.17,
                                  height: _height * 0.12,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: const Color(0xff3a6c83),
                                          width: 1),
                                      image: DecorationImage(
                                          image:NetworkImage(
                                              _bookDetailsModel!.data!.author!.img.toString()
                                          )
                                      ))),
                              Text(_bookDetailsModel!.data!.author!.name.toString(),
                                  style: const TextStyle(
                                      color: const Color(0xff2a2a2a),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Lato",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.left),
                              SizedBox(
                                height: _height * 0.03,
                              ),
                              Container(
                                width: _width * 0.27,
                                height: _height * 0.035,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(
                                        color: const Color(0xff3a6c83), width: 1),
                                    color: const Color(0xffebf5f9)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Views: ",
                                      style: const TextStyle(
                                          color: const Color(0xff3a6c83),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Lato",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12.0),
                                    ),
                                    Text("856",
                                        style: const TextStyle(
                                            color: const Color(0xff3a6c83),
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Lato",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 12.0),
                                        textAlign: TextAlign.left)
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: _height * 0.03,
                              ),
                              Container(
                                width: 110,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: const Color(0xffffffff)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "850",
                                      style: const TextStyle(
                                          color: const Color(0xff00bb23),
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Lato",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 10.0),
                                    ),
                                    Icon(Icons.thumb_up,
                                        color: const Color(0xff00bb23))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: _height * 0.03,
                              ),
                              Container(
                                width: 110,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: const Color(0xffffffff)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "850",
                                      style: const TextStyle(
                                          color: const Color(0xff00bb23),
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Lato",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 10.0),
                                    ),
                                    Icon(Icons.thumb_down,
                                        color: const Color(0xff00bb23))
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(_bookDetailsModel!.data!.bookTitle!,
                            style: const TextStyle(
                                color: const Color(0xff2a2a2a),
                                fontWeight: FontWeight.w700,
                                fontFamily: "Alexandria",
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0),
                            textAlign: TextAlign.left),
                        Text("#Manga",
                            style: const TextStyle(
                                color: const Color(0xff3a6c83),
                                fontWeight: FontWeight.w700,
                                fontFamily: "Lato",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            textAlign: TextAlign.left),
                        SizedBox(),
                        SizedBox()
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: _width * 0.05, top: _height * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("About the book",
                              style: const TextStyle(
                                  color: const Color(0xff2a2a2a),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Alexandria",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0),
                              textAlign: TextAlign.left),
                          SizedBox(
                            height: _height * 0.01,
                          ),
                          Text(
                            _bookDetailsModel!.data!.description!,
                            style: const TextStyle(
                                color: const Color(0xff676767),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Lato",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0),
                            overflow: TextOverflow.fade,
                            maxLines: 6,
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BookDetailScreen(
                                          BookID:
                                          _bookDetailsModel!.data!.id.toString(),
                                        )));
                          },
                          child: Container(
                            width: _width * 0.7,
                            height: _height * 0.06,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0x24000000),
                                      offset: Offset(0, 7),
                                      blurRadius: 14,
                                      spreadRadius: 0)
                                ],
                                color: const Color(0xff3a6c83)),
                            child: Center(
                              child: Text("READ",
                                  style: const TextStyle(
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Lato",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0),
                                  textAlign: TextAlign.center),
                            ),
                          ),
                        ),
                        Container(
                          width: _width * 0.13,
                          height: _height * 0.13,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: const Color(0xff3a6c83), width: 1),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0x12000000),
                                    offset: Offset(0, 7),
                                    blurRadius: 14,
                                    spreadRadius: 0)
                              ],
                              color: const Color(0xfffafcfd)),
                          child: Icon(Icons.bookmark_border_outlined),
                        ),
                      ],
                    ),
                    SizedBox()
                  ],
                ),
    );
  }

  Future _checkInternetConnection() async {
    if (this.mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (!(connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi)) {
      Constants.showToastBlack(context, "Internet not connected");
      if (this.mounted) {
        setState(() {
          _isLoading = false;
          _isInternetConnected = false;
        });
      }
    } else {
      _callBookDetailsAPI();
    }
  }

  Future _callBookDetailsAPI() async {
    setState(() {
      _isLoading = true;
      _isInternetConnected = true;
    });

    final response = await http.get(
      Uri.parse(ApiUtils.BOOK_DETAIL_API + widget.bookID.toString()),
    );

    if (response.statusCode == 200) {
      print('BookDetail_response under 200 ${response.body}');
      var jsonData = json.decode(response.body);
      //var jsonData = response.body;
      _bookDetailsModel = BookDetailsModel.fromJson(jsonData);
      print(_bookDetailsModel!.message.toString());
      setState(() {
        _isLoading = false;
      });
    } else {
      Constants.showToastBlack(context, "Some things went wrong");
      setState(() {
        _isLoading = false;
      });
    }
  }
}
