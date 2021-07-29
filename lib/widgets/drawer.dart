import 'package:flutter/material.dart';
import 'package:ttooler/konstant/konstant.dart';
import 'package:ttooler/pageRoutebuilder/customPageRouteBuilder.dart';
import 'package:ttooler/pages/aboutPage.dart';
import 'package:ttooler/pages/bookshelfPage.dart';
import 'package:ttooler/pages/homePage.dart';
import 'package:ttooler/pages/reminderPage.dart';
import 'package:ttooler/pages/timetablePage.dart';
import 'package:ttooler/pages/todoPage.dart';


class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Color(0xff464D65)
        ),
        child: ListView(
          physics:  ClampingScrollPhysics(), //this will remove the expand scroll to top animation in list view
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffA1B1DC),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 5.0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            const DrawerItem(PageName.HomePage, iconAddress: "assets/images/icon_images/home.png", title: "Home", enterPage: HomePage(),),
            const DrawerItem(PageName.NotHomePage, iconAddress: "assets/images/icon_images/todo_icon.png", title: "Todo", enterPage: TodoPage(),),
            const DrawerItem(PageName.NotHomePage, iconAddress: "assets/images/icon_images/reminder1.png", title: "Reminder", enterPage: ReminderPage(),),
            const DrawerItem(PageName.NotHomePage,iconAddress: "assets/images/icon_images/reminder.png", title: "TimeTable", enterPage: TimetablePage(),),
            const Divider(height: 20, thickness: 1, color: Colors.white,),
            const DrawerItem(PageName.NotHomePage,iconAddress: "assets/images/icon_images/bookIcon.png", title: "BookShelf", enterPage: BookshelfPage(),),
            const Divider(height: 20, thickness: 1, color: Colors.white,),
            const DrawerItem(PageName.NotHomePage, iconAddress: "assets/images/icon_images/mug_.png", title: "About", enterPage: AboutPage(),),
          ],
        )
      )
    );
  }
}

class DrawerItem extends StatelessWidget {

  final String iconAddress;
  final String title;
  final Widget enterPage;
  final PageName ? page;

  const DrawerItem(this.page, {required this.iconAddress, required this.title, required this.enterPage});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff262A3D),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius:BorderRadius.circular(15),
        splashColor: Colors.white.withOpacity(0.2),
        highlightColor: Colors.transparent,
        onTap: (){
          Navigator.of(context).pop();
          if(page == PageName.HomePage){
            return;
          }
          Navigator.of(context).push(CustomPageRouteBuilder(enterPage: enterPage, exitPage: HomePage()));
        },
        child: ListTile(
          leading: Container(
            height: 40,
            width: 40,
            child : Image.asset(iconAddress),
          ),
          title: Text(title, style: TextStyle(
            fontSize: 17,
          ),),
        ),
      ),
    );
  }
}

