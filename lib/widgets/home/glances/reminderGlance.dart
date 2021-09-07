import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/konstant/konstant.dart';
import 'package:ttooler/modals/reminderProvier.dart';
import 'package:ttooler/pageRoutebuilder/customPageRouteBuilder.dart';
import 'package:ttooler/pages/homePage.dart';
import 'package:ttooler/pages/reminderPage.dart';
import 'package:ttooler/widgets/home/glanceHeader.dart';
import 'package:ttooler/widgets/reminder/timelineBuilder.dart';

class ReminderGlance extends StatelessWidget {
  bool isSameMonth(DateTime prev, DateTime next) {
    return prev.month != next.month;
  }

  @override
  Widget build(BuildContext context) {
    final _reminder = Provider.of<ReminderProvider>(context).items;
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      margin: EdgeInsets.only(bottom: 100),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlanceHeader(
            glanceType: GlanceType.Reminder,
          ),
          if (_reminder.length == 0)
            Container(
              height: MediaQuery.of(context).size.height/2,
              child: Center(
                child: Text(
                  "You don't have any reminder ⏰",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          if (_reminder.length <= 3)
            TimelineBuilder(items: _reminder, isSameMonth: isSameMonth, leftPadding: 0, rightPadding: 0, where: "glance",),
          if (_reminder.length > 3)
            TimelineBuilder(
                items: _reminder.sublist(0, 3), isSameMonth: isSameMonth, leftPadding: 0, rightPadding: 0, where: "glance"),
          if(_reminder.length != 0)TextButton(onPressed: (){
            Navigator.of(context).push(CustomPageRouteBuilder(enterPage: ReminderPage(), exitPage: HomePage()));
          }, child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("See all", style: TextStyle(
                fontSize: 20,
              ),),
              SizedBox(width: 10,),
              Icon(Icons.east, color: Colors.white,)
            ],
          ))
        ],
      ),
    );
  }
}
