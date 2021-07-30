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
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';


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
  final _swiperController = SwiperController();

  int _bottomNavigationSelectedIndex = 0;

  void pushPageUtil(PageName name) {
    widget.pushPage(name, context);
  }

  GlanceType _glanceType = GlanceType.Todo;

  void setGlaceType(int index) async {
    print(index);
    _swiperController.move(index);
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

  void setGlaceSwiper(int index){
    setState(() {
      _bottomNavigationSelectedIndex = index;
    });
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
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          leading:
          InkWell(
            child:const HamburgerButton(),
            onTap: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            borderRadius: BorderRadius.circular(10),
            highlightColor: Colors.transparent, //this line will remove the highlight color of inkwell
          ),
        ),
        drawer: DrawerWidget(
          pushPage: pushPageUtil,
        ),
        //here added bottom navigation bar
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xff464D65),
          currentIndex: _bottomNavigationSelectedIndex,
          selectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: _bottomNavigationSelectedIndex == 0 ? 40 : 30,
                  width: _bottomNavigationSelectedIndex == 0 ? 40 : 30,
                  child: Image.asset(
                    "assets/images/icon_images/todo_icon.png",
                    fit: BoxFit.cover,
                  ),
                ),
                label: "Todo"),
            BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: _bottomNavigationSelectedIndex == 1 ? 40 : 30,
                  width: _bottomNavigationSelectedIndex == 1 ? 40 : 30,
                  child: Image.asset(
                    "assets/images/icon_images/reminder1.png",
                    fit: BoxFit.cover,
                  ),
                ),
                label: "Reminder"),
            BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: _bottomNavigationSelectedIndex == 2 ? 40 : 30,
                  width: _bottomNavigationSelectedIndex == 2 ? 40 : 30,
                  child: Image.asset(
                    "assets/images/icon_images/bookIcon.png",
                    fit: BoxFit.cover,
                  ),
                ),
                label: "TimeTable"),
          ],
          onTap: setGlaceType,
        ),

        body: Container(
          height: mediaQuery.height,
          width: mediaQuery.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const InfoGreeting(),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("At Glance,",),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*(2/3),
                  width: double.infinity,
                  child: Swiper(
                    loop: false,
                    onIndexChanged:setGlaceSwiper,
                    controller:_swiperController,
                    itemBuilder: (BuildContext context,int index){
                      return  index == 0 ? TodoGlance(glanceType: GlanceType.Todo) : index == 1 ? TodoGlance(glanceType: GlanceType.Reminder) : TodoGlance(glanceType: GlanceType.TimeTable);
                    },
                    itemCount: 3,
                    pagination: new SwiperPagination(),
                  ),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}

class TodoGlance extends StatelessWidget {

  final GlanceType glanceType;
  TodoGlance({required this.glanceType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      width: double.infinity,
      child: Column(
        children: [
          GlanceHeader(glanceType: glanceType,),
          Text("I am todo"),
        ],
      ),
    );
  }
}
