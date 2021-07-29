import 'package:flutter/material.dart';

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
            const DrawerItem(iconAddress: "assets/images/icon_images/home.png", title: "Home"),
            const DrawerItem(iconAddress: "assets/images/icon_images/todo_icon.png", title: "Todo"),
            const DrawerItem(iconAddress: "assets/images/icon_images/reminder1.png", title: "Reminder"),
            const DrawerItem(iconAddress: "assets/images/icon_images/home.png", title: "TimeTable"),
            const Divider(height: 20, thickness: 1, color: Colors.white,),
            const DrawerItem(iconAddress: "assets/images/icon_images/home.png", title: "BookShelf"),
            const Divider(height: 20, thickness: 1, color: Colors.white,),
            const DrawerItem(iconAddress: "assets/images/icon_images/mug_.png", title: "About"),
          ],
        )
      )
    );
  }
}

class DrawerItem extends StatelessWidget {

  final String iconAddress;
  final String title;

  const DrawerItem({required this.iconAddress, required this.title});

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
        onTap: (){},
        child: ListTile(
          leading: Container(
            height: 40,
            width: 40,
            child : Image.asset(iconAddress),
          ),
          title: Text(title, style: TextStyle(
            fontSize: 15,
          ),),
        ),
      ),
    );
  }
}

