import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/konstant/konstant.dart';
import 'package:ttooler/modals/reminderProvier.dart';
import 'package:ttooler/modals/timetableProvider.dart';
import 'package:ttooler/modals/todoProvider.dart';
import 'package:ttooler/pageRoutebuilder/customPageRouteBuilder.dart';
import 'package:ttooler/pages/aboutPage.dart';
import 'package:ttooler/pages/bookshelfPage.dart';
import 'package:ttooler/pages/reminderPage.dart';
import 'package:ttooler/pages/timetablePage.dart';
import 'package:ttooler/pages/todoPage.dart';
import 'package:ttooler/widgets/drawer.dart';
import 'package:ttooler/widgets/buttons/hamburgerButton.dart';
import 'package:ttooler/widgets/home/glances/reminderGlance.dart';
import 'package:ttooler/widgets/home/glances/timetableGlance.dart';
import 'package:ttooler/widgets/home/glances/todoGlance.dart';
import 'package:ttooler/widgets/home/info_greeting.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/HomePage";
  const HomePage({Key? key}) : super(key: key);

  void pushPage(PageName name, BuildContext context) {
    switch (name) {
      case PageName.Todo:
        Navigator.of(context).push(
            CustomPageRouteBuilder(enterPage: TodoPage(), exitPage: this));
        break;
      case PageName.Reminder:
        Navigator.of(context).push(
            CustomPageRouteBuilder(enterPage: ReminderPage(), exitPage: this));
        break;
      case PageName.TimeTable:
        Navigator.of(context).push(
            CustomPageRouteBuilder(enterPage: TimetablePage(), exitPage: this));
        break;
      case PageName.BookShelf:
        Navigator.of(context).push(
            CustomPageRouteBuilder(enterPage: BookshelfPage(), exitPage: this));
        break;
      case PageName.About:
        Navigator.of(context).push(
            CustomPageRouteBuilder(enterPage: AboutPage(), exitPage: this));
        break;
      default:
        break;
    }
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //we can use this key to trigger the drawer without using appBar

  int _bottomNavigationSelectedIndex = 0;

  void pushPageUtil(PageName name) {
    //this function is used to push page on basis of press from drawer
    widget.pushPage(name, context);
  }

  GlanceType _glanceType = GlanceType.Todo;

  void setGlaceType(int index) {
    _bottomNavigationSelectedIndex = index;
    if (index == 0) {
      setState(() {
        _glanceType = GlanceType.Todo;
      });
    } else if (index == 1) {
      setState(() {
        _glanceType = GlanceType.Reminder;
      });
    } else if (index == 2) {
      setState(() {
        _glanceType = GlanceType.TimeTable;
      });
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    Timer.periodic(Duration(minutes: 5), (timer) {
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child:Scaffold(
          extendBody: true,
          key: _scaffoldKey,
          drawer: DrawerWidget(
            pushPage: pushPageUtil,
          ),
          appBar: AppBar(
            toolbarHeight: 45,
            elevation: 1,
            leading: InkWell(
              child: const HamburgerButton(),
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              borderRadius: BorderRadius.circular(10),
              highlightColor: Colors
                  .transparent, //this line will remove the highlight color of inkwell
            ),
          ),
          //here added bottom navigation bar
          bottomNavigationBar: CurvedNavigationBar(
            height: 55,
            animationDuration: Duration(milliseconds: 500),
            backgroundColor: Colors.transparent,
            index: _bottomNavigationSelectedIndex,
            buttonBackgroundColor: Color(0xffb1acfa),
            color: Color(0xff464D65),
            items: [
              Container(
                height: 35,
                child: Image.asset(
                  "assets/images/icon_images/todo_icon.png",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 35,
                child: Image.asset(
                  "assets/images/icon_images/reminder1.png",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 35,
                child: Image.asset(
                  "assets/images/icon_images/calender.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
            onTap: setGlaceType,
          ),

          body: Container(
              height: mediaQuery.height,
              width: mediaQuery.width,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                    children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         InfoGreeting(),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "At Glance",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _glanceType == GlanceType.Todo ? true : false,
                    child: TodoGlance(),
                    maintainState: true,
                  ),
                  Visibility(
                    visible: _glanceType == GlanceType.Reminder ? true : false,
                    child: ReminderGlance(),
                    maintainState: true,
                  ),
                  Visibility(
                    visible: _glanceType == GlanceType.TimeTable ? true : false,
                    child: TimetableGlance(),
                    maintainState: true,
                  ),
                ]),
              ),
            ),
          ),
        );
  }
}
