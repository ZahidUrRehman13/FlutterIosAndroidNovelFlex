import 'dart:convert';
import 'dart:io';

import 'package:app_version_update/app_version_update.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:new_version_plus/new_version_plus.dart';
// import 'package:parallax_animation/parallax_area.dart';
// import 'package:parallax_animation/parallax_widget.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import '../Drawer/drawer_screen.dart';
import '../MixScreens/AuthorViewByUserScreen.dart';
import '../MixScreens/BookDetailScreen.dart';
import '../MixScreens/SeeAllBooksScreen.dart';
import '../MixScreens/notification_screen.dart';
import '../Models/DashBoardModelMain.dart';
import '../Provider/UserProvider.dart';
import '../Utils/ApiUtils.dart';
import '../Utils/Constants.dart';
import '../localization/Language/languages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final globalKey = GlobalKey<ScaffoldState>();

  // AppUpdateInfo? _updateInfo;
  //
  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> checkForUpdate() async {
  //   InAppUpdate.checkForUpdate().then((info) {
  //     setState(() {
  //       _updateInfo = info;
  //     });
  //   }).catchError((e) {
  //     showSnack(e.toString());
  //   });
  // }

  // void showSnack(String text) {
  //   if (globalKey.currentContext != null) {
  //     ScaffoldMessenger.of(globalKey.currentContext!)
  //         .showSnackBar(SnackBar(content: Text(text)));
  //   }
  // }



  //check version
  // String? version = '';
  // String? storeVersion = '';
  // String? storeUrl = '';
  // String? packageName = '';


  DashBoardModelMain? _dashBoardModelMain;
  bool _isLoading = false;
  DioCacheManager? _dioCacheManager;
  late final translator;

  // final versionCheck = VersionCheck(
  //   packageName: Platform.isIOS
  //       ? 'com.tachyonfactory.iconFinder'
  //       : 'com.eshtisharati.flutter_novel_flex',
  //   packageVersion: '1.0.1',
  //   showUpdateDialog: customShowUpdateDialog,
  //   country: 'kr',
  // );
  //
  // Future checkVersion() async {
  //   await versionCheck.checkVersion(context);
  //   setState(() {
  //     version = versionCheck.packageVersion;
  //     packageName = versionCheck.packageName;
  //     storeVersion = versionCheck.storeVersion;
  //     storeUrl = versionCheck.storeUrl;
  //   });
  // }

  final appleId = '1234567890';
  final playStoreId = 'com.appcom.estisharati.novel.flex';
  final country = 'us';


  checkUpdate()async{
    await AppVersionUpdate.checkForUpdates(
        appleId: appleId, playStoreId: playStoreId, country: country)
        .then((data) async {
      print(data.storeUrl);
      print(data.storeVersion);
      if(data.canUpdate!){
        //showDialog(... your custom widgets view)
        //or use our widgets
        // AppVersionUpdate.showAlertUpdate
        // AppVersionUpdate.showBottomSheetUpdate
        // AppVersionUpdate.showPageUpdate
        AppVersionUpdate.showAlertUpdate(
            appVersionResult: data, context: context,
          content: 'Would you like to update your application?',
          cancelButtonStyle: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.redAccent)),


        );
      }


    });
  }


  @override
  void initState() {
    super.initState();
    checkUpdate();
    // checkVersion();
    // _checkVersionnew();
    // checkForUpdate();
    // _updateInfo?.updateAvailability == UpdateAvailability.updateAvailable
    //     ? InAppUpdate.performImmediateUpdate()
    //     .catchError((e) => showSnack(e.toString()))
    //     : null;


    translator = GoogleTranslator();
    _callDashboardDioAPI();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffebf5f9),
      key: globalKey,
      appBar: AppBar(
        elevation: 0.2,
        toolbarHeight: _height * 0.07,
        backgroundColor: const Color(0xFF256D85),
        leading: IconButton(
          onPressed: () {
            globalKey.currentState!.openDrawer();
          },
          icon: SizedBox(
              height: _height * 0.07,
              width: _width * 0.07,
              child: Image.asset(
                "assets/hamburger_img.png",
              )),
        ),
        actions: [
          SizedBox(
            width: _width * 0.14,
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: _height * 0.02,
                ),
              ],
            ),
          ),
          SizedBox(
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationScreen()));
                // MaterialPageRoute(
                //     builder: (context) => AnotherHomeScreen()));
              },
              icon: const Icon(
                Icons.notifications,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 5.0,
          )
        ],
      ),
      body: _isLoading
          ? const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFF256D85),
                ),
              ),
            )
          : Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Visibility(
                  visible: Provider.of<InternetConnectionStatus>(context) ==
                      InternetConnectionStatus.disconnected,
                  child: Constants.InternetNotConnected(_height * 0.03)),
              Container(
                height: _height*0.24,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlayCurve: Curves.easeInSine,
                      autoPlay: true
                    ),
                    items:  _dashBoardModelMain!
                        .data![0].books!.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffebf5f9),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: _width*0.03,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                          "Most Popular",
                                          style: const TextStyle(
                                              color:  const Color(0xff2a2a2a),
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Alexandria",
                                              fontStyle:  FontStyle.normal,
                                              fontSize: 16.0
                                          ),

                                      ),
                                      Container(
                                        width: _width*0.25,
                                        height: _height*0.15,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(_dashBoardModelMain!
                                                .data![2].books![0].bookImage.toString(),
                                            ),
                                            fit: BoxFit.cover

                                          )
                                        ),
                                      ),
                                      SizedBox()
                                    ],
                                  ),
                                  SizedBox(
                                    width: _width*0.05,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(),
                                        SizedBox(),
                                        SizedBox(),
                                        SizedBox(),
                                        Text(
                                            "Novel Title",
                                            style: const TextStyle(
                                                color:  const Color(0xff2a2a2a),
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Alexandria",
                                                fontStyle:  FontStyle.normal,
                                                fontSize: 14.0
                                            ),

                                        ),
                                        Padding(
                                          padding: context.watch<UserProvider>().SelectedLanguage=='English' ? EdgeInsets.only(right: _width*0.02):EdgeInsets.only(left: _width*0.02),
                                          child: Text(
                                              "Pellentesque habitant morbi tristique senectus et netus et"
                                                  " malesuada fames ac turpis egestas. Ut arcu libero, "
                                                  "pulvinar non massa sed, accumsan scelerisque dui. "
                                                  "Morbi purus mauris, vulputate quis felis nec, "
                                                  "fermentum aliquam orci."
                                                  " Quisque ornare iaculis placerat."
                                                  " Class aptent taciti sociosqu ad"
                                                  " litora torquent per conubia nostra"
                                                  ", per inceptos himenaeos. In commodo"
                                                  " sem arcu, sed fermentum tortor "
                                                  "consequat vel. Phasellus lacinia"
                                                  " quam quis leo tincidunt vehicula.",

                                              style: const TextStyle(
                                                  color:  const Color(0xff676767),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Lato",
                                                  fontStyle:  FontStyle.normal,
                                                  fontSize: 12.0
                                              ),
                                             textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 5,
                                          ),
                                        ),
                                        Text(
                                            "#Manga",
                                            style: const TextStyle(
                                                color:  const Color(0xff3a6c83),
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Lato",
                                                fontStyle:  FontStyle.normal,
                                                fontSize: 12.0
                                            ),

                                        ),
                                        SizedBox(),
                                        SizedBox(),
                                      ],
                                    ),
                                  )
                                ],
                              )
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
              Expanded(
                child: Scaffold(
                  body: RefreshIndicator(
                    onRefresh: () async {
                      _callDashboardDioAPI();
                    },
                    child: ListView.builder(
                      shrinkWrap: true, // outer ListView
                      // reverse: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _dashBoardModelMain!.data!.length,
                      itemBuilder: (_, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context
                                                    .read<UserProvider>()
                                                    .SelectedLanguage ==
                                                "English" ||
                                            context
                                                    .read<UserProvider>()
                                                    .SelectedLanguage ==
                                                null
                                        ? _dashBoardModelMain!
                                            .data![index].categoryTitle!
                                        : _dashBoardModelMain!
                                            .data![index].titleAr!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Constants.fontfamily,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SeeAllBookScreen(
                                                    categoriesId:
                                                        '${_dashBoardModelMain!.data![index].categoryId}',
                                                  )));
                                    },
                                    child: Text(
                                      Languages.of(context)!.seeAll,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        fontFamily: Constants.fontfamily,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: _height*0.23,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: _dashBoardModelMain!
                                    .data![index].books!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index1) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             BookDetailScreen(
                                      //               BookID:
                                      //               _dashBoardModelMain!.data![index].books![index1].id!,
                                      //             )));
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                      AuthorViewByUserScreen()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            // width: _width*0.45,
                                            margin: const EdgeInsets.all(3.0),
                                            width: _width*0.27,
                                            height: _height*0.15,
                                            decoration: BoxDecoration(
                                              // color: Color(0xff3a6c83),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: CachedNetworkImage(
                                              filterQuality: FilterQuality.high,
                                              imageBuilder: (context, imageProvider) => Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius: BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      image: imageProvider, fit: BoxFit.cover),
                                                ),
                                              ),
                                              imageUrl:
                                              _dashBoardModelMain!
                                                  .data![index]
                                                  .books![index1]
                                                  .bookImage!,
                                              fit: BoxFit.cover,

                                              placeholder: (context,
                                                  url) =>
                                                  const Center(
                                                      child:
                                                      CupertinoActivityIndicator(
                                                        color: Color(0xFF256D85),
                                                      )),
                                              errorWidget:
                                                  (context, url, error) =>
                                                  const Center(child: Icon(Icons.error_outline)),
                                            ),
                                          ),
                                          Text(
                                            _dashBoardModelMain!
                                                .data![index]
                                                .books![index1]
                                                .bookTitle!,
                                            overflow:
                                            TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color:  const Color(0xff2a2a2a),
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Alexandria",
                                                fontStyle:  FontStyle.normal,
                                                fontSize: 10.0
                                            ),
                                          ),
                                          Text(
                                              "Randy Woodkin",
                                              style: const TextStyle(
                                                  color:  const Color(0xff676767),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Lato",
                                                  fontStyle:  FontStyle.normal,
                                                  fontSize: 8.0
                                              ),
                                              textAlign: TextAlign.left
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )



                              // CarouselSlider.builder(
                              //     itemCount: _dashBoardModelMain!
                              //         .data![index].books!.length,
                              //     options: CarouselOptions(
                              //         aspectRatio: 1.5,
                              //         // disableCenter: true,
                              //         scrollPhysics:
                              //             BouncingScrollPhysics(),
                              //         viewportFraction: 0.58,
                              //         scrollDirection: Axis.horizontal,
                              //         // viewportFraction: 0.43,
                              //         // aspectRatio: 1.8,
                              //         // reverse: true,
                              //         // autoPlay: true,
                              //         enableInfiniteScroll: false),
                              //     itemBuilder:
                              //         (context, index1, realIndex) {
                              //       return GestureDetector(
                              //         onTap: () {
                              //           Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                   builder: (context) =>
                              //                       BookDetailScreen(
                              //                         BookID:
                              //                             '${_dashBoardModelMain!.data![index].books![index1].id!}',
                              //                       )));
                              //         },
                              //         child: Stack(
                              //           children: [
                              //             Container(
                              //               height: _height * 0.4,
                              //               width: _width * 0.5,
                              //               child: ClipRRect(
                              //                 borderRadius:
                              //                     BorderRadius.circular(
                              //                         1.0),
                              //                 child: CachedNetworkImage(
                              //                   imageUrl:
                              //                       _dashBoardModelMain!
                              //                           .data![index]
                              //                           .books![index1]
                              //                           .bookImage!,
                              //                   fit: BoxFit.cover,
                              //                   placeholder: (context,
                              //                           url) =>
                              //                       Center(
                              //                           child:
                              //                               CupertinoActivityIndicator(
                              //                     color: Color(0xFF256D85),
                              //                   )),
                              //                   errorWidget:
                              //                       (context, url, error) =>
                              //                           Icon(Icons.error),
                              //                 ),
                              //               ),
                              //             ),
                              //             Positioned(
                              //                 top: _height * 0.29,
                              //                 left: _width * 0.035,
                              //                 right: _width * 0.05,
                              //                 child: Text(
                              //                   _dashBoardModelMain!
                              //                       .data![index]
                              //                       .books![index1]
                              //                       .bookTitle!,
                              //                   overflow:
                              //                       TextOverflow.ellipsis,
                              //                   style: TextStyle(
                              //                     color: Colors.white,
                              //                     fontSize: 15,
                              //                     fontWeight:
                              //                         FontWeight.bold,
                              //                     fontFamily:
                              //                         Constants.fontfamily,
                              //                   ),
                              //                 ))
                              //           ],
                              //         ),
                              //       );
                              //     }),
                            ),

                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
      drawer: DrawerCode(),
    );
  }

  Future _callDashboardDioAPI() async {
    setState(() {
      _isLoading = true;
    });
    _dioCacheManager = DioCacheManager(CacheConfig());

    Options _cacheOptions =
        buildCacheOptions(const Duration(days: 7), forceRefresh: true);
    Dio _dio = Dio();
    _dio.interceptors.add(_dioCacheManager!.interceptor);
    Response response =
        await _dio.get(ApiUtils.HOME_SCREEN_API, options: _cacheOptions);
    if (response.statusCode == 200) {
      print('dashboard_screen_response ${response.data}');
      var jsonData = response.data;
      _dashBoardModelMain = DashBoardModelMain.fromJson(jsonData);
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _checkVersionnew()async{
    final newVersion=NewVersionPlus(
      androidId: "com.eshtisharati.flutter_novel_flex",
    );
    final status=await newVersion.getVersionStatus();
    if(status?.canUpdate==true){
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status!,
        allowDismissal: false,
        dialogTitle: "UPDATE",
        dialogText: "Please update the app from ${status.localVersion} to ${status.storeVersion}",
      );}}


}

// void customShowUpdateDialog(BuildContext context, VersionCheck versionCheck) {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (context) => AlertDialog(
//       title: Text('NEW Update Available'),
//       content: SingleChildScrollView(
//         child: ListBody(
//           children: <Widget>[
//             Text(
//                 'Do you REALLY want to update to ${versionCheck.storeVersion}?'),
//             Text('(current version ${versionCheck.packageVersion})'),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         TextButton(
//           child: Text('Update'),
//           onPressed: () async {
//             await versionCheck.launchStore();
//             Navigator.of(context).pop();
//           },
//         ),
//         TextButton(
//           child: Text('Close'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ],
//     ),
//   );
// }
