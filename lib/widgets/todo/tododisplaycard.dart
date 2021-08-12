import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttooler/pageRoutebuilder/heroPageRouteBuilder.dart';
import 'package:ttooler/widgets/buttons/iconButton.dart';
import 'package:ttooler/widgets/todo/todoinputcard.dart';

class TodoCard extends StatelessWidget {

  final String title;
  final String subtitle;
  final String description;
  final int index;
  final int priority;
  final String heroKey;
  final String? todoKey;

  TodoCard({required this.title, required this.subtitle, required this.description, required this.index, required this.priority, required this.heroKey, required this.todoKey});

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
          tilePadding: EdgeInsets.only(left: 20, right: 20, top: 10),
          childrenPadding: EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 15),
          collapsedIconColor: Colors.white,
          collapsedTextColor: Colors.white,
          textColor: Colors.white,
          iconColor: Colors.white,
          title: Text(title, style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
              // color: Colors.white70
          ),),
          subtitle: Text(subtitle, style: TextStyle(
            fontSize: 17,
              // color: Colors.white70
          ),),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description, softWrap: true, style: TextStyle(
              // color: Colors.white70
            ),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BorderIconButton(icon: Icons.check, onPress: (){}, belongTo: heroKey, type: "Check"),
                SizedBox(width: 10,),
                BorderIconButton(icon: Icons.edit, onPress: (String heroTag){
                  Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                    return AddTodoPopupCard(heroTag: heroTag, cardTitle: "Edit", title: title, subtitle:  subtitle, description:  description, priority:  priority.toDouble(), todoKey: todoKey,);
                  },));
                }, belongTo: heroKey, type: "Edit",),
                SizedBox(width: 10,),
                BorderIconButton(icon: Icons.delete, onPress: (){}, belongTo: heroKey, type: "Delete"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
