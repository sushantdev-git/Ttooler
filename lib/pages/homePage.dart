import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttooler/konstant/konstant.dart';
import 'package:ttooler/pageRoutebuilder/customPageRouteBuilder.dart';
import 'package:ttooler/pages/aboutPage.dart';
import 'package:ttooler/pages/bookshelfPage.dart';
import 'package:ttooler/pages/reminderPage.dart';
import 'package:ttooler/pages/timetablePage.dart';
import 'package:ttooler/pages/todoPage.dart';
import 'package:ttooler/widgets/drawer.dart';
import 'package:ttooler/widgets/buttons/hamburgerButton.dart';
import 'package:ttooler/widgets/home/glanceHeader.dart';
import 'package:ttooler/widgets/home/info_greeting.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/HomePage";
  const HomePage({Key? key}) : super(key: key);

  void pushPage(PageName name, BuildContext context){
    switch(name){
      case PageName.Todo:
        Navigator.of(context).push(CustomPageRouteBuilder(enterPage: TodoPage(), exitPage: this));
        break;
      case PageName.Reminder:
        Navigator.of(context).push(CustomPageRouteBuilder(enterPage: ReminderPage(), exitPage: this));
        break;
      case PageName.TimeTable:
        Navigator.of(context).push(CustomPageRouteBuilder(enterPage: TimetablePage(), exitPage: this));
        break;
      case PageName.BookShelf:
        Navigator.of(context).push(CustomPageRouteBuilder(enterPage: BookshelfPage(), exitPage: this));
        break;
      case PageName.About:
        Navigator.of(context).push(CustomPageRouteBuilder(enterPage: AboutPage(), exitPage: this));
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

  void pushPageUtil(PageName name){
    widget.pushPage(name, context);
  }

  GlanceType _glanceType = GlanceType.Todo;

  void setGlanceType(GlanceType type){
    setState(() {
      _glanceType = type;
    });
  }



  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerWidget(pushPage: pushPageUtil,),
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
                  borderRadius: BorderRadius.circular(10),
                  highlightColor: Colors
                      .transparent, //this line will remove the highlight color of inkwell
                ),
                InfoGreeting(),
                SizedBox(
                  height: 20,
                ),
                Text("At Glance,"),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Stack(
                    children: [
                      GlanceHeader(glanceType: _glanceType, changeGlance: setGlanceType,),
                      TodoGlance(),
                    ],
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

class TodoGlance extends StatelessWidget {
  const TodoGlance({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [

        ],
      ),
    );
  }
}

