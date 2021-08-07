import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ttooler/pageRoutebuilder/heroPageRouteBuilder.dart';
import 'package:ttooler/widgets/buttons/iconButton.dart';
import 'package:ttooler/widgets/reminder/reminderInputCard.dart';

class ReminderCard extends StatelessWidget {

  final String title;
  final String subtitle;
  final String description;
  final int index;
  final DateTime dateTime;
  final String heroKey;

  ReminderCard({required this.title, required this.subtitle, required this.description, required this.dateTime, required this.index, required this.heroKey});

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
          tilePadding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          childrenPadding: EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 15),
          collapsedIconColor: Colors.white,
          collapsedTextColor: Colors.white,
          textColor: Colors.white,
          iconColor: Colors.white,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat("hh:mm a").format(dateTime),style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w100
              ),),
              Text(title, style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700
              ),),
            ],
          ),
          subtitle: Text(subtitle, style: TextStyle(
            fontSize: 18,
          ),),
          children: [
            Text(description, softWrap: true,),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BorderIconButton(icon: Icons.edit, onPress: (String heroTag){
                  Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                    return AddReminderPopupCard(
                        heroTag: heroTag,
                        title: title,
                        subtitle: subtitle,
                        datetime: dateTime,
                      description: description,
                      cardTitle: "Edit",
                    );
                  },));
                }, belongTo: heroKey, type: "Edit", index : index),
                SizedBox(width: 10,),
                BorderIconButton(icon: Icons.delete, onPress: (){}, belongTo: heroKey,type: "Delete" ,index : index),
              ],
            ),
          ],
        ),
      ),
    );
  }
}