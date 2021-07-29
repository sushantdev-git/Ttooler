import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttooler/widgets/buttons/iconButton.dart';
import 'package:ttooler/widgets/drawer.dart';
import 'package:ttooler/widgets/buttons/hamburgerButton.dart';
import 'package:ttooler/widgets/home/info_greeting.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //we can use this key to trigger the drawer without using appBar

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          drawer: DrawerWidget(),
          body: Container(
            height: mediaQuery.height,
            width: mediaQuery.width,
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: HamburgerButton(),
                    onTap: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    borderRadius: BorderRadius.circular(5),
                  ),
                  InfoGreeting(),
                  SizedBox(
                    height: 10,
                  ),
                  Text("At Glance,"),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      child: Image.asset(
                                          "assets/images/icon_images/todo_icon.png"),
                                    ),
                                    SizedBox(width: 10,),
                                    Text(
                                      "Todo",
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  ],
                                ),
                                BorderIconButton(icon: Icons.east, onPress: (){})
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
