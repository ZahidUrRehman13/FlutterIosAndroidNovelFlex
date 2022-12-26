import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../Models/UserUploadHistoryModel.dart';
import '../Provider/UserProvider.dart';
import '../Utils/ApiUtils.dart';
import '../Utils/Constants.dart';
import '../Utils/toast.dart';
import '../localization/Language/languages.dart';
import 'BookDetailsAuthor.dart';

class AuthorViewByUserScreen extends StatefulWidget {
  const AuthorViewByUserScreen({Key? key}) : super(key: key);

  @override
  State<AuthorViewByUserScreen> createState() => _AuthorViewByUserScreenState();
}

class _AuthorViewByUserScreenState extends State<AuthorViewByUserScreen> {
  UserUploadHistoryModel? _userUploadHistoryModel;

  bool _isLoading = false;
  bool _isInternetConnected = true;
  bool _isHistoryLoading = false;
  bool _emtyFlag = false;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
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
      setState(() {
        _isLoading = false;
        _isInternetConnected = false;
      });
      _callUploadHistoryAPI();
    }
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF256D85),
        elevation: 0.0,
      ),
      body: Container(
        child: _isInternetConnected
            ? _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF256D85),
                    ),
                  )
                : Stack(
                    children: [
                      Positioned(
                          child: Container(
                        height: _height * 0.9,
                        color: const Color(0xffebf5f9),
                      )),
                      Positioned(
                        child: Container(
                          height: _height * 0.175,
                          width: _width,
                          color: Color(0xFF256D85),
                        ),
                      ),
                      Positioned(
                        left: _width * 0.05,
                        top: _height * 0.13,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 2,color:  Color(0xFF256D85),),
                              ),
                              child: Icon(
                                Icons.person_pin,
                                size: _height * _width * 0.0003,
                              ),
                            ),
                            SizedBox(
                              width: _width * 0.03,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: _height * 0.06),
                              child: Column(
                                children: [
                                  Text(
                                    context.read<UserProvider>().UserName!,
                                    style: const TextStyle(
                                        color: const Color(0xff2a2a2a),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Neckar",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14.0),
                                  ),
                                  SizedBox(
                                    height: _height*0.01,
                                  ),
                                  Text(Languages.of(context)!.subscriber,
                                    style: const TextStyle(
                                        color:  const Color(0xff3a6c83),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Lato",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 10.0
                                    ),),
                                  SizedBox(
                                    height: _height*0.005,
                                  ),
                                  Text("12",
                                    style: const TextStyle(
                                        color:  const Color(0xff3a6c83),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Lato",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 10.0
                                    ),),
                                ],
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(top: _height*0.03,left: _width*0.1),
                              child: Container(
                                  width: _width*0.23,
                                  height: _height*0.04,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)
                                      ),
                                      border: Border.all(
                                          color: const Color(0xff3a6c83),
                                          width: 1
                                      ),
                                      color: const Color(0xffebf5f9)
                                  ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(Icons.person_add,color: const Color(0xff3a6c83),),
                                    Text(
                                        "Subscribe",
                                        style: const TextStyle(
                                            color:  const Color(0xff3a6c83),
                                            fontWeight: FontWeight.w800,
                                            fontFamily: "Lato",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: 10.0
                                        ),
                                        textAlign: TextAlign.left
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: _height * 0.28,
                        left: _width*0.1,
                        right:_width*0.1,
                        child: Opacity(
                          opacity : 0.20000000298023224,
                          child:   Container(
                              width: 368,
                              height: 1,
                              decoration: BoxDecoration(
                                  color: const Color(0xff3a6c83)
                              )
                          ),
                        ),
                      ),
                      Positioned(
                        top: _height * 0.33,
                        child: Container(
                          margin: EdgeInsets.all(16.0),
                          height: _height*0.2,
                          width: _width*0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white
                          ),
                          child: Padding(
                            padding:  EdgeInsets.only(left: _width*0.05,top: _height*0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "About Author",
                                    style: const TextStyle(
                                        color:  const Color(0xff2a2a2a),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Alexandria",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 16.0
                                    ),
                                    textAlign: TextAlign.left
                                ),
                                SizedBox(
                                  height: _height*0.01,
                                ),
                                Text(
                                    "Pellentesque habitant morbi tristique senectus et netus et"
                                        " malesuada fames ac turpis egestas. Ut arcu libero,"
                                        " pulvinar non massa sed, accumsan scelerisque dui "
                                     ,
                                    style: const TextStyle(
                                        color:  const Color(0xff676767),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Lato",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 14.0
                                    ),
                                    overflow: TextOverflow.fade,
                                    maxLines: 6,

                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: _height * 0.58,
                        left: _width * 0.05,
                        child: Container(
                          height: _height * 0.3,
                          width: _width,
                          child: Text(Languages.of(context)!.novels,
                            style: const TextStyle(
                                color:  const Color(0xff2a2a2a),
                                fontWeight: FontWeight.w700,
                                fontFamily: "Alexandria",
                                fontStyle:  FontStyle.normal,
                                fontSize: 16.0
                            ),),
                        ),
                      ),
                      Positioned(
                        top: _height * 0.6,
                        child: _isHistoryLoading
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: _height * _width * 0.0006,
                                    top: _height * _width * 0.0004),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFF256D85),
                                    ),
                                  ),
                                ),
                              )
                            : _emtyFlag
                                ? Padding(
                                    padding: EdgeInsets.all(
                                        _height * _width * 0.0004),
                                    child: Center(
                                      child: Text(
                                        Languages.of(context)!
                                            .nouploadhistory,
                                        style: const TextStyle(
                                            fontFamily: Constants.fontfamily,
                                            color: Colors.black54),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: _height * 0.3,
                                    width: _width,
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: _userUploadHistoryModel!
                                          .data!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index1) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                            BookDetailAuthor(
                                              bookID: _userUploadHistoryModel!
                                                  .data![index1].id.toString(),
                                            )));
                                          },
                                          child: Column(
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    width: _width * 0.22,
                                                    height: _height * 0.12,
                                                    margin: EdgeInsets.all(
                                                        _width * 0.05),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(5.0),
                                                      color: Colors.black,
                                                      image: DecorationImage(
                                                          image: _userUploadHistoryModel!
                                                                      .data![
                                                                          index1]
                                                                      .bookImage ==
                                                                  ""
                                                              ? const AssetImage(
                                                                  "assets/quotes_data/manga image.png")
                                                              : NetworkImage(_userUploadHistoryModel!
                                                                      .data![
                                                                          index1]
                                                                      .bookImage
                                                                      .toString())
                                                                  as ImageProvider),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top: _height * 0.12,
                                                      left: _width * 0.07,
                                                      child: Icon(
                                                        Icons.remove_red_eye,
                                                        color: Colors.white,
                                                        size: _height *
                                                            _width *
                                                            0.00005,
                                                      )),
                                                  Positioned(
                                                      top: _height * 0.122,
                                                      left: _width * 0.13,
                                                      child: Text(
                                                        _userUploadHistoryModel!
                                                            .data![index1]
                                                            .views
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 10.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                            fontFamily:
                                                                "Lato",
                                                            fontStyle:
                                                                FontStyle
                                                                    .normal,
                                                            color:
                                                                Colors.white),
                                                      ))
                                                ],
                                              ),
                                              Text(
                                                _userUploadHistoryModel!
                                                    .data![index1].bookTitle
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontFamily: 'Lato',
                                                  color: Color(0xff313131),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                                overflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )),
                      ),
                    ],
                  )
            : Center(
                child: Constants.InternetNotConnected(_height * 0.03),
              ),
      ),
    );
  }

  Future _callUploadHistoryAPI() async {
    setState(() {
      _isHistoryLoading = true;
      _isInternetConnected = true;
    });
    var map = new Map<String, String>();
    map['accesstoken'] = context.read<UserProvider>().UserToken.toString();
    final response =
        await http.get(Uri.parse(ApiUtils.UPLOAD_HISTORY_API), headers: map);

    if (response.statusCode == 200) {
      print('upload_history_response under 200 ${response.body}');
      var jsonData = response.body;
      //var jsonData = response.body;
      var jsonData1 = json.decode(response.body);
      if (jsonData1['status'] == 200) {
        _userUploadHistoryModel = userUploadHistoryModelFromJson(jsonData);
        setState(() {
          _isHistoryLoading = false;
        });
      } else {
        ToastConstant.showToast(context, jsonData1['message'].toString());
        setState(() {
          _isHistoryLoading = false;
          _emtyFlag = true;
        });
      }
    }
  }

  Future _callSubscribeAPI() async {
    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);

    print("user_id: ${userProvider.UserID}");

    var map = new Map<String, dynamic>();
    map['reader_id'] = userProvider.UserID;
    // map['writer_id'] = _bookDetailsModel!.data!.author!.id;

    final response = await http.post(
      Uri.parse(ApiUtils.SUBSCRIBE_API),
      body: map,
    );

    var jsonData;

    switch (response.statusCode) {
      case 200:
      //Success

        var jsonData = json.decode(response.body);
        print('subscribe_data: $jsonData');
        if (jsonData['status'] == 200) {

          ToastConstant.showToast(context,jsonData['message']);
        } else {
          ToastConstant.showToast(context,jsonData['message']);
        }
    }
  }
}
