import 'package:flutter/material.dart';
import 'package:ttooler/widgets/buttons/iconButton.dart';

class TodoCard extends StatelessWidget {

  final String title;
  final String subtitle;
  final String description;

  TodoCard({required this.title, required this.subtitle, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        color:  Color(0xff262A3D),
        image: DecorationImage(
          image: AssetImage("assets/images/icon_images/mug_.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Color(0xff262A3D).withOpacity(0.6), BlendMode.darken)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ),
        ]
      ),
      child: Theme(
        //This will remove the highlight color from expansion tile.
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent
        ),
        child: ExpansionTile(

          childrenPadding: EdgeInsets.all(20),
          collapsedIconColor: Colors.white,
          collapsedTextColor: Colors.white,
          textColor: Colors.white,
          iconColor: Colors.white,
          title: Text(title, style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700
          ),),
          subtitle: Text(subtitle),
          leading: Icon(Icons.book),
          children: [
            Text(description, textAlign: TextAlign.start,),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BorderIconButton(icon: Icons.check, onPress: (){}),
                SizedBox(width: 10,),
                BorderIconButton(icon: Icons.edit, onPress: (){}),
                SizedBox(width: 10,),
                BorderIconButton(icon: Icons.delete, onPress: (){}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
