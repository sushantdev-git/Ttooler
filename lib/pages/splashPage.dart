import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/modals/reminderProvier.dart';
import 'package:ttooler/modals/timetableProvider.dart';
import 'package:ttooler/modals/todoProvider.dart';
import 'package:ttooler/modals/userInfo.dart';
import 'package:ttooler/pages/homePage.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  Future<void> fetchData(BuildContext context) async {
    await Provider.of<UserInfo>(context, listen: false).fetchUserInfo();
    await Provider.of<TodoProvider>(context, listen:  false).fetchAndSetData();
    await Provider.of<ReminderProvider>(context, listen:  false).fetchAndSetData();
    await Provider.of<TimeTableProvider>(context, listen: false).fetchAndSetData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(context),
        builder: (context, snapshot) {
          Widget child;
          if(snapshot.connectionState == ConnectionState.waiting) {
            child = SplashScreen(key: ValueKey(0),);
          } else {
            child = HomePage(key: ValueKey(1),);
          }
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            switchInCurve: Curves.easeInExpo,
            switchOutCurve: Curves.easeOutCubic,
            // transitionBuilder: (Widget child, Animation<double> animation) {
            //   final  offsetAnimation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, -1.0)).animate(animation);
            //   return SlideTransition(position: offsetAnimation);
            // },
            child: child,
          );
        }
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/illustration/tree.png", height: MediaQuery.of(context).size.height/3,),
      ),
    );
  }
}

