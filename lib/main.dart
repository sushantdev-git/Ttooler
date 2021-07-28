import 'package:flutter/material.dart';
import 'package:ttooler/screens/landingPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: LandingPage(),
      theme: ThemeData(
        primaryColor:Colors.white,
        canvasColor: Color(0xff181920),
        fontFamily: "OpenSans",
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: Colors.white,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: Colors.white,
            side: BorderSide(width: 1, color: Colors.white),
          )
        )
      ),
      routes: {

      },
    );
  }
}

