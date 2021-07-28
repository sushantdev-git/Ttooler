import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttooler/widgets/hamburgerButton.dart';
import 'package:ttooler/widgets/home/info_greeting.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Container(
        height: mediaQuery.height,
        width: mediaQuery.width,
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(child: HamburgerButton(), onTap: (){
                Navigator.of(context).pop();
              },
              borderRadius: BorderRadius.circular(5),
              ),
              InfoGreeting()
            ],
          ),
        ),
      )),
    );
  }
}
