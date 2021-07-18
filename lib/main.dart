import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:baazaru/cons.dart';
import 'package:baazaru/Providers/product.dart';
import 'package:baazaru/Modules/Splash/index.dart';
import 'package:baazaru/Modules/Home/index.dart';
import 'package:baazaru/Modules/Search/index.dart';
import 'package:baazaru/Modules/Product/trending.dart';
import 'package:baazaru/Modules/Login/index.dart';
import 'package:baazaru/Modules/Forget/index.dart';
import 'package:baazaru/Modules/Signup/index.dart';
import 'package:baazaru/Modules/Welcome/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProductProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: true,
          title: 'Welcome to Baazaru',
          theme: ThemeData(primaryColor: Colors.orange[200]),
          routes: <String, WidgetBuilder>{
            SPLASH_PAGE: (BuildContext context) => SplashPage(),
            HOME_PAGE: (BuildContext context) => HomePage(),
            SEARCH_PAGE: (BuildContext context) => SearchPage(),
            TRENDING_PAGE: (BuildContext context) => TrendingPage(),
            LOGIN_PAGE: (BuildContext context) => LoginPage(),
            SIGNUP_PAGE: (BuildContext context) => SignupPage(),
            FORGET_PAGE: (BuildContext context) => ForgetPage(),
            WELCOME_PAGE: (BuildContext context) => WelcomePage(),
          },
          initialRoute: HOME_PAGE,
        ));

    // return MaterialApp(
    //   debugShowCheckedModeBanner: true,
    //   title: 'Welcome to Baazaru',
    //   theme: ThemeData(primaryColor: Colors.orange[200]),
    //   routes: <String, WidgetBuilder>{
    //     HOME_PAGE: (BuildContext context) => HomePage(),
    //     SPLASH_PAGE: (BuildContext context) => SplashPage(),
    //     TRENDING_PAGE: (BuildContext context) => TrendingPage(),
    //   },
    //   initialRoute: TRENDING_PAGE,
    // );
  }
}
