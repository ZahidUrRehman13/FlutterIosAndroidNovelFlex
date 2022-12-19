import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/UserModel.dart';
import '../Provider/UserProvider.dart';
import '../Utils/ApiUtils.dart';
import '../Utils/Constants.dart';
import '../Utils/toast.dart';
import '../Widgets/reusable_button.dart';
import '../Widgets/reusable_button_small.dart';
import '../localization/Language/languages.dart';
import 'ForgetPasswordScreen.dart';
import 'SignUpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const String id = 'login_screen';

  final _emailFocusNode = new FocusNode();
  final _passwordFocusNode = new FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _passwordKey = GlobalKey<FormFieldState>();
  final _emailKey = GlobalKey<FormFieldState>();

  TextEditingController? _controllerEmail;
  TextEditingController? _controllerPassword;

  bool _autoValidate = false;

  bool _isLoading = false;

  UserModel? _userModel;

  String _errorMsg = "";

  @override
  void initState() {
    super.initState();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
  }

  @override
  void dispose() {
    _controllerEmail!.dispose();
    _controllerPassword!.dispose();
    super.dispose();
  }

  void handleLoginUser() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (_formKey.currentState!.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState!.save();
      //Call api
      // _checkInternetConnection();
      _checkInternetConnection();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
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
      Fluttertoast.showToast(
        msg: "Internet Not Connected",
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
        backgroundColor: Colors.black,
        fontSize: 14,
      );
      _errorMsg = "No internet connection.";
      if (this.mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      _callLoginAPI();
    }
  }

  _navigateAndRemove() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _controllerEmail!.clear();
      _controllerPassword!.clear();
      Navigator.of(context).pushNamedAndRemoveUntil(
          'tab_screen', (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   toolbarHeight: height*0.1,
      //   title: Text(Languages.of(context)!.login,style: TextStyle(color: const Color(0xFF256D85),fontWeight: FontWeight.w600,fontSize: width*0.05),),
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      //   elevation: 0.0,
      // ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              currentFocus.focusedChild!.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.8), BlendMode.dstATop),
                  opacity: 100.0,
                  image: AssetImage("assets/manga_books.jpg"),
                ),
              ),
              child: Form(
                key: _formKey,
                // autovalidate: _autoValidate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        // mainText(width),
                        // mainSmallText(height),
                        SizedBox(
                          height: height * 0.1,
                        ),

                        mainText2(width),
                        SizedBox(
                          height: height * 0.1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: height * 0.02,
                              horizontal: width * 0.04),
                          child: TextFormField(
                            key: _emailKey,
                            controller: _controllerEmail,
                            focusNode: _emailFocusNode,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.black,
                            validator: validateEmail,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode);
                            },
                            decoration: InputDecoration(
                                errorMaxLines: 3,
                                counterText: "",
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.white12,
                                  ),
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFF256D85),
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFF256D85),
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 1,
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.red,
                                    )),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.red,
                                  ),
                                ),
                                hintText: Languages.of(context)!.email,
                                // labelText: Languages.of(context)!.email,
                                hintStyle: const TextStyle(
                                  fontFamily: Constants.fontfamily,
                                )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: height * 0.02,
                              horizontal: width * 0.04),
                          child: TextFormField(
                            key: _passwordKey,
                            controller: _controllerPassword,
                            focusNode: _passwordFocusNode,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.black,
                            validator: validatePassword,
                            obscureText: true,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_emailFocusNode);
                            },
                            decoration: InputDecoration(
                                errorMaxLines: 3,
                                counterText: "",
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.black12,
                                  ),
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.black12,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFF256D85),
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 1,
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.red,
                                    )),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.red,
                                  ),
                                ),
                                hintText: Languages.of(context)!.password,
                                // labelStyle: TextStyle(
                                //   color: Colors.red
                                // ),
                                // labelText: Languages.of(context)!.password,
                                hintStyle: const TextStyle(
                                  fontFamily: Constants.fontfamily,
                                )),
                          ),
                        ),

                        GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetPasswordScreen()),
                                  ModalRoute.withName("forgetPassword_screen"));
                            },
                            child: forgetPassword(height)),
                        Container(
                          margin: EdgeInsets.only(top: height * 0.05),
                          child: ResuableMaterialButtonSmall(
                            onpress: () {
                              handleLoginUser();
                            },
                            buttonname: Languages.of(context)!.login,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Visibility(
                      visible: _isLoading == true,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF256D85),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          top: height * 0.1,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            Languages.of(context)!.donthaveanaccountSignUp,
                            style: TextStyle(
                                color: Colors.white, fontSize: width * 0.04),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget mainText(var width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Languages.of(context)!.welcomenovelflex,
          style: TextStyle(
            color: Colors.black87,
            fontSize: width * 0.05,
            fontWeight: FontWeight.w800,
            fontFamily: Constants.fontfamily,
          ),
          textAlign: TextAlign.center,
        ),
        // const SizedBox(width: 10.0,),
        // Text(
        //   'Novel Flex',style: TextStyle(
        //     color: const Color(0xFF256D85),
        //     fontSize: width*0.05,
        //     fontWeight: FontWeight.w800
        // ),
        //   textAlign: TextAlign.center,
        // ),
      ],
    );
  }

  Widget mainSmallText(double height) {
    return Container(
      margin: EdgeInsets.only(top: height * 0.02),
      child: Text(
        Languages.of(context)!.socailtext,
        style: TextStyle(
          color: Colors.black26,
          fontSize: height * 0.02,
          fontFamily: Constants.fontfamily,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget mainText2(var width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Languages.of(context)!.login,
          style: TextStyle(
            color: Colors.white,
            fontSize: width * 0.06,
            fontWeight: FontWeight.w800, fontFamily: Constants.fontfamily,),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget forgetPassword(double height) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: height * 0.03, right: height * 0.04,left: height * 0.04),
              child: Text(
                Languages.of(context)!.forgetPassword,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.w500,
                  fontFamily: Constants.fontfamily,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: height * 0.04,left: height * 0.04),
              child: SizedBox(
                width: width * 0.3,
                child: const Divider(
                  color: Colors.white,
                  thickness: 2.0,
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please Enter Email';
    }

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    // RegExp regex = new RegExp(pattern);
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else
      return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) return 'Please enter password';

    if (value.length < 6) {
      return 'Password should be more than 6 characters';
    } else
      return null;
  }

  Future _callLoginAPI() async {
    setState(() {
      _isLoading = true;
    });

    var map = Map<String, dynamic>();
    map['email'] = _controllerEmail!.text.trim();
    map['password'] = _controllerPassword!.text.trim();

    final response = await http.post(
      Uri.parse(ApiUtils.URL_LOGIN_USER_API),
      body: map,
    );

    var jsonData;

    switch (response.statusCode) {
      case 200:
        //Success

        var jsonData = json.decode(response.body);
        print('loginSuccess_data: $jsonData');
        if (jsonData['status'] == 200) {
          _userModel = UserModel.fromJson(jsonData);
          saveToPreferencesUserDetail(_userModel);
          _navigateAndRemove();

          ToastConstant.showToast(context, "Login Successfully");
        } else {
          ToastConstant.showToast(context, "Invalid Credential!");
          setState(() {
            _isLoading = false;
          });
        }

        break;
      case 401:
        jsonData = json.decode(response.body);
        print('jsonData 401: $jsonData');
        break;
      case 400:
        jsonData = json.decode(response.body);
        print('jsonData 400: $jsonData');

        ToastConstant.showToast(context, "Invalid email or password");

        break;
      case 404:
        jsonData = json.decode(response.body);
        print('jsonData 404: $jsonData');
        break;
      case 405:
        jsonData = json.decode(response.body);
        print('jsonData 405: $jsonData');
        break;
      case 422:
        //Unprocessable Entity
        jsonData = json.decode(response.body);
        print('jsonData 422: $jsonData');
        break;
      case 500:
        jsonData = json.decode(response.body);
        print('jsonData 500: $jsonData');
        break;
      default:
        jsonData = json.decode(response.body);
        print('jsonData failed: $jsonData');
        ToastConstant.showToast(context, "Login Failed Try Again");
    }

    if (this.mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void saveToPreferencesUserDetail(UserModel? _userModel) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    userProvider.setUserEmail(_userModel!.data.email);
    userProvider.setUserToken(_userModel.data.accessToken);
    userProvider.setUserName(_userModel.data.fname);
    // userProvider.setUserImage(_userModel.data.img);
    userProvider.setUserID(_userModel.data.id.toString());
    userProvider.setLanguage("English");
  }
}
