import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kazakh_invest/src/provider/base_provider.dart';
import 'package:kazakh_invest/src/provider/home_provider.dart';
import 'package:kazakh_invest/src/provider/web_view_provider.dart';
import 'package:kazakh_invest/src/screens/home_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<BaseProvider>(
            create: (_) => BaseProvider(),
          ),
          ChangeNotifierProvider<HomeProvider>(
            create: (_) => HomeProvider(),
          ),
          ChangeNotifierProvider<WebProvider>(
            create: (_) => WebProvider(),
          ),
        ],
        child: Consumer<HomeProvider>(builder: (context, provider, child) {
          return MaterialApp(
            title: 'Kazak Invest',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Montserrat',
              platform:
                  Platform.isIOS ? TargetPlatform.iOS : TargetPlatform.android,
              appBarTheme: AppBarTheme(
                color: Colors.white,
                actionsIconTheme: IconThemeData(
                  color: Color.fromRGBO(35, 35, 35, 1),
                ),
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: IntroMainScreen(),
          );
        }));
  }
}
