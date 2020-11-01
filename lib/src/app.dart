import 'package:flutter/material.dart';
import 'package:kazakh_invest/src/screens/intro_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kazak Invest',
      theme: ThemeData(
        fontFamily: 'Montserrat',
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
  }
}
