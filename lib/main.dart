import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:baazaru/Constants/constants.dart';
import 'package:baazaru/Providers/product.dart';
import 'package:baazaru/Pages/index.dart';
import 'package:baazaru/Pages/home.dart';
import 'package:baazaru/Pages/trending.dart';

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
          title: 'Flutter Classified App Clone',
          theme: ThemeData(primaryColor: Colors.orange[200]),
          routes: <String, WidgetBuilder>{
            HOME_PAGE: (BuildContext context) => HomePage(),
            INDEX_PAGE: (BuildContext context) => IndexPage(),
            TRENDING_PAGE: (BuildContext context) => TrendingPage(),
          },
          initialRoute: HOME_PAGE,
        ));

    // return MaterialApp(
    //   debugShowCheckedModeBanner: true,
    //   title: 'Flutter Classified App Clone',
    //   theme: ThemeData(primaryColor: Colors.orange[200]),
    //   routes: <String, WidgetBuilder>{
    //     HOME_PAGE: (BuildContext context) => HomePage(),
    //     INDEX_PAGE: (BuildContext context) => IndexPage(),
    //     TRENDING_PAGE: (BuildContext context) => TrendingPage(),
    //   },
    //   initialRoute: TRENDING_PAGE,
    // );
  }
}
