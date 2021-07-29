import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttooler/pageRoutebuilder/customPageRouteBuilder.dart';
import 'package:ttooler/screens/homePage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
            top: mediaQuery.size.height / 10,
            left: mediaQuery.size.width / 10,
            right: mediaQuery.size.width / 10),

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
                height: 20,
              ),
              const Text(
                "Ttooler",
                style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              SizedBox(
                height: 40,
              ),
              const Text(
                "Welcome",
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 35,
                ),
              ),
              SizedBox(
                height: 10,
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
                height: 40,
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
    );
  }
}
