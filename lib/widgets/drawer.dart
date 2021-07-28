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
            const DrawerItem(icon: Icons.home, title: "Home"),
            const DrawerItem(icon: Icons.task_alt, title: "Todo"),
            const DrawerItem(icon: Icons.schedule, title: "Reminder"),
            const DrawerItem(icon: Icons.date_range, title: "TimeTable"),
            const Divider(height: 20, thickness: 1, color: Colors.white,),
            const DrawerItem(icon: Icons.book, title: "BookShelf"),
            const Divider(height: 20, thickness: 1, color: Colors.white,),
            const DrawerItem(icon: Icons.engineering, title: "About"),
          ],
        )
      )
    );
  }
}

class DrawerItem extends StatelessWidget {

  final IconData icon;
  final String title;

  const DrawerItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff262A3D),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: Colors.white,),
        title: Text(title, style: TextStyle(
          fontSize: 15,
        ),),
      ),
    );
  }
}

