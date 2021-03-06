import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttooler/modals/reminderProvier.dart';
import 'package:ttooler/modals/timetableProvider.dart';
import 'package:ttooler/modals/todoProvider.dart';
import 'package:ttooler/modals/userInfo.dart';
import 'package:ttooler/pages/landing.dart';
import 'package:ttooler/pages/splashPage.dart';

import 'notification/notifications.dart';

Future<bool> isNewUser() async{
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool newUser = sp.getBool("newUser") ?? true;
  print("This is new user "+newUser.toString());
  if(newUser == true){
    await sp.setBool("newUser", false);
  }
  return newUser;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //this will prevent to change orientation of app.
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  bool notificationOpensApp = await Notifications.init();
  bool newUser = await isNewUser();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(new MyApp(newUser: newUser, notificationOpensApp: notificationOpensApp,));
  });
}

class MyApp extends StatelessWidget {
  final bool newUser;
  final bool notificationOpensApp;
  const MyApp({required this.newUser, required this.notificationOpensApp, Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xff181920)
    )); //this will set color of status bar

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoProvider(),),
        ChangeNotifierProvider(create: (context) => ReminderProvider()),
        ChangeNotifierProvider(create: (context) => TimeTableProvider()),
        ChangeNotifierProvider(create: (context) => UserInfo()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          home: newUser ? LandingPage() : SplashPage(),
        theme: ThemeData(
          primaryColor:Color(0xff181920),
          accentColor: Color(0xffb1acfa),
          backgroundColor: Color(0xff262A3D),
          canvasColor: Color(0xff181920),
          // canvasColor: Colors.white,
          fontFamily: "OpenSans",
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: Colors.white,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor:Color(0xff181920),
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
          ),
          inputDecorationTheme: InputDecorationTheme(
            // contentPadding: EdgeInsets.all(15),
              labelStyle: TextStyle(
                  color: Colors.white
              ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff363a55),
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              )
            )
          ),

          sliderTheme: SliderThemeData(// This is what you are asking for// Custom Gray Color
            overlayColor: Colors.white,  // Custom Thumb overlay Color
            // activeColor: Theme.of(context).backgroundColor,
            // inactiveColor: Theme.of(context).backgroundColor,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
            valueIndicatorShape: PaddleSliderValueIndicatorShape(),

          ),

          dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.1, color: Colors.white),
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 10
          ),

          timePickerTheme: TimePickerThemeData(
            backgroundColor: Color(0xffb1acfa),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            hourMinuteColor: Color(0xff262A3D),
            hourMinuteTextColor: Colors.white,
            dialHandColor: Color(0xffb1acfa),
            dialBackgroundColor:Color(0xff262A3D) ,
            dialTextColor: Colors.white,
            dayPeriodTextColor: Colors.black,
            dayPeriodShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            dayPeriodBorderSide: BorderSide(width: 1),
            helpTextStyle: TextStyle(
              fontSize: 15,
              color: Color(0xff262A3D),
              fontStyle: FontStyle.italic,
            ),
            dayPeriodTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            )
          ),

            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),

        ),


      ),
    );
  }
}

