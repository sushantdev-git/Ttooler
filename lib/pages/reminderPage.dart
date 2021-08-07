import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/modals/reminderProvier.dart';
import 'package:ttooler/widgets/reminder/reminderFAB.dart';
import 'package:ttooler/widgets/timelineBuilder.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {

  bool isSameMonth(DateTime prev, DateTime next) {
    return prev.month != next.month;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _reminder = Provider.of<ReminderProvider>(context).items;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
                height: 30,
                width: 30,
                child: Image.asset(
                  "assets/images/icon_images/reminder1.png",
                  fit: BoxFit.cover,
                )),
            SizedBox(
              width: 5,
            ),
            Text(
              "Reminder",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ReminderFloatingAB(),
      body: _reminder.length == 0 ? Center(
        child : Text("You don't have any reminder ⏰", style: TextStyle(
          fontSize: 20,color: Colors.white,
        ),)
      ): TimelineBuilder(items: _reminder, isSameMonth: isSameMonth, leftPadding: 20, rightPadding: 20, where: "main",),
    );
  }
}
