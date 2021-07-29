import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttooler/konstant/konstant.dart';
import 'package:ttooler/widgets/drawer.dart';
import 'package:ttooler/widgets/buttons/hamburgerButton.dart';
import 'package:ttooler/widgets/home/glanceHeader.dart';
import 'package:ttooler/widgets/home/info_greeting.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/HomePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //we can use this key to trigger the drawer without using appBar

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

