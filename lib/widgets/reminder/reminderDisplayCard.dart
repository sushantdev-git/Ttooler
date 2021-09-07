import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/konstant/konstant.dart';
import 'package:ttooler/modals/reminderProvier.dart';
import 'package:ttooler/pageRoutebuilder/heroPageRouteBuilder.dart';
import 'package:ttooler/widgets/buttons/iconButton.dart';
import 'package:ttooler/widgets/popUpCard.dart';
import 'package:ttooler/widgets/reminder/reminderInputCard.dart';

class ReminderCard extends StatelessWidget {

  final String title;
  final String description;
  final int index;
  final DateTime dateTime;
  final String id;
  final TypeCategory category;

  ReminderCard({required this.title,required this.description, required this.dateTime, required this.index, required this.id, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:  Color(0xff262A3D),
          image: DecorationImage(
              image: AssetImage(getTypeCategoryAddress(category)),
              alignment: Alignment.topRight,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Color(0xff262A3D).withOpacity(0.8), BlendMode.darken)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ]
      ),
      clipBehavior: Clip.antiAlias,
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
              Text(DateFormat("EEEE, hh:mm a").format(dateTime),style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w100
              ),),
              Text(title, style: TextStyle(
                  fontSize: 18,
                  // fontWeight: FontWeight.w700
              ),),
            ],
          ),
          children: [
            Text(description, softWrap: true,),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BorderIconButton(icon: Icons.edit, onPress: (){
                  Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                    return AddReminderPopupCard(
                        title: title,
                        datetime: dateTime,
                      description: description,
                      cardTitle: "Edit",
                      id: id,
                      category: category,
                    );
                  },));
                },),
                SizedBox(width: 10,),
                BorderIconButton(icon: Icons.delete, onPress: (){
                  Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                    return PopUpCard(
                        title: "Delete Reminder",
                        subtitle: "Do you want to delete Reminder?",
                        content: "$title\n${DateFormat.yMMMMEEEEd().format(dateTime)}",
                        icon: Icons.delete,
                        onPress: (){
                          final _reminder = Provider.of<ReminderProvider>(context, listen: false);
                          _reminder.deleteReminder(key: id, where: "main");
                        });
                  },));
                },),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
