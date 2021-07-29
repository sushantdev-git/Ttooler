import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttooler/pages/landingPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //this will prevent to change orientation of app.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xff181920)
    )); //this will set color of status bar

    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: LandingPage(),
      theme: ThemeData(
        primaryColor:Color(0xff181920),
        accentColor: Colors.white,
        backgroundColor: Color(0xff262A3D),
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            tapTargetSize: MaterialTapTargetSize.padded,
          )
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.white,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            )
        )
      ),
      routes: {

      },
    );
  }
}

