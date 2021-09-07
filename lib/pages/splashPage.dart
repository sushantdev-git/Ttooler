import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/modals/reminderProvier.dart';
import 'package:ttooler/modals/timetableProvider.dart';
import 'package:ttooler/modals/todoProvider.dart';
import 'package:ttooler/pageRoutebuilder/customPageRouteBuilder.dart';

import 'homePage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  Future<void> fetchData(BuildContext context) async {
    await Provider.of<TodoProvider>(context, listen:  false).fetchAndSetData();
    await Provider.of<ReminderProvider>(context, listen:  false).fetchAndSetData();
    await Provider.of<TimeTableProvider>(context, listen: false).fetchAndSetData();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return FutureBuilder(
      future: fetchData(context),
      builder:(context, snapshot) => Scaffold(
          body: Container(
            margin: EdgeInsets.only(
                top: mediaQuery.size.height / 10,
                left: mediaQuery.size.width / 10,
                right: mediaQuery.size.width / 10,
                bottom: mediaQuery.size.height/10,
            ),

            height: mediaQuery.size.height,
            width: mediaQuery.size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: mediaQuery.size.height / 3,
                    width: mediaQuery.size.height / 3,
                    child: Center(
                      child: Image.asset(
                        "assets/images/tree.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mediaQuery.size.height/40,
                  ),
                  const Text(
                    "Ttooler",
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: mediaQuery.size.height/30,
                  ),
                  const Text(
                    "Welcome",
                    style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 35,
                    ),
                  ),
                  SizedBox(
                    height: mediaQuery.size.height/30,
                  ),
                  const Text(
                    "Ttooler is powerful management app for students.",
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 21,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: mediaQuery.size.height/40,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CustomPageRouteBuilder(
                          enterPage: HomePage(),
                          exitPage: this,
                        ),
                      );
                    },
                    child: Container(
                      width: mediaQuery.size.width / 3,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Get started",
                          ),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
