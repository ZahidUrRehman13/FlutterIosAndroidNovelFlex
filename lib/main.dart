

import 'dart:async';
import 'package:app_version_update/app_version_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:novelflex/tab_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Provider/UserProvider.dart';
import 'TabScreens/profile_screen.dart';
import 'UserAuthScreen/login_screen.dart';
import 'localization/locale_constants.dart';
import 'localization/localizations_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(Phoenix(child: MyApp(sharedPreferences: prefs)));
}

class MyApp extends StatefulWidget {
  late SharedPreferences sharedPreferences;

  MyApp({super.key, required this.sharedPreferences});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<InternetConnectionStatus>(
      initialData: InternetConnectionStatus.connected,
      create: (_) {
        return InternetConnectionCheckerPlus().onStatusChange;
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
              create: (context) => UserProvider(widget.sharedPreferences)),
          // ChangeNotifierProvider<VariableProvider>(
          //     create: (context) => VariableProvider()),
        ],
        child: MaterialApp(
          locale: _locale,
          supportedLocales: const [
            Locale('en', ''),
            Locale('ar', ''),
          ],
          localizationsDelegates:  const [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode &&
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          debugShowCheckedModeBanner: false,
          home: SplashPage(),
          routes: {
            // 'slider_screen': (context) => SliderScreen(),
            'tab_screen': (context) => TabScreen(),
            'login_screen': (context) => LoginScreen(),
            'profile_screen': (context) => Profile_Screen(),
          },
        ),
      ),
    );
  }
}



class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (context.read<UserProvider>().UserToken == '' ||
          context.read<UserProvider>().UserToken == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TabScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF256D85),
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: Image.asset('assets/icon_mine.png'),
          ),
          Positioned(
              top: _height*0.8,
              left: _width*0.5,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.black12,
                ),
              )),
          // Positioned(
          //     top: _height*0.2,
          //     left: _width*0.3,
          //     child: Center(
          //       child: Text(Languages.of(context)!.welcomenovelflex,style: TextStyle(
          //         fontFamily: Constants.fontfamily,
          //         fontSize: 20.0,
          //         color: Colors.white,
          //         fontWeight: FontWeight.bold
          //       ),),
          //     ))
        ],
      ),
    );
  }
}
