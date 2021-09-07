import 'package:flutter/material.dart';
import 'package:ttooler/konstant/konstant.dart';



class DrawerWidget extends StatelessWidget {
  final Function pushPage;
  const DrawerWidget({required this.pushPage,Key? key}) : super(key: key);

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
            // Container(
            //   height: 150,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     color: Color(0xffA1B1DC),
            //     borderRadius: BorderRadius.circular(15),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black38,
            //         offset: Offset(0.0, 1.0), //(x,y)
            //         blurRadius: 5.0,
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 10,),
            // DrawerItem(page: PageName.HomePage, iconAddress: "assets/images/icon_images/home.png", title: "Home", pushPage: pushPage,),
            DrawerItem(page: PageName.Todo, iconAddress: "assets/images/icon_images/todo_icon.png", title: "Todo", pushPage: pushPage,),
            DrawerItem(page: PageName.Reminder, iconAddress: "assets/images/icon_images/reminder1.png", title: "Reminder", pushPage: pushPage,),
            DrawerItem(page: PageName.TimeTable,iconAddress: "assets/images/icon_images/calender.png", title: "TimeTable", pushPage: pushPage,),
            // Divider(height: 20, thickness: 1, color: Colors.white,),
            // DrawerItem(page: PageName.BookShelf,iconAddress: "assets/images/icon_images/bookIcon.png", title: "BookShelf", pushPage: pushPage,),
            // Divider(height: 20, thickness: 1, color: Colors.white,),
            DrawerItem(page: PageName.About, iconAddress: "assets/images/illustration/mug_.png", title: "About", pushPage: pushPage,),
          ],
        )
      )
    );
  }
}

class DrawerItem extends StatelessWidget {

  final String iconAddress;
  final String title;
  final PageName ? page;
  final Function pushPage;

  const DrawerItem( {required this.page, required this.iconAddress, required this.title, required this.pushPage});

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
          pushPage(page);
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

