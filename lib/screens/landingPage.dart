import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQeury = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
            top: mediaQeury.size.height / 10,
            left: mediaQeury.size.width / 10,
            right: mediaQeury.size.width / 10),
        height: mediaQeury.size.height,
        width: mediaQeury.size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: mediaQeury.size.height / 3,
                width: mediaQeury.size.height / 3,
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
              Text(
                "Ttooler",
                style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Welcome",
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 35,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
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
                onPressed: () {},
                child: Container(
                  width: mediaQeury.size.width / 3,
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
