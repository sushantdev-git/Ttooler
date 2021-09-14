import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/konstant/konstant.dart';
import 'package:ttooler/modals/timetableProvider.dart';
import 'package:ttooler/pageRoutebuilder/customPageRouteBuilder.dart';
import 'package:ttooler/pages/homePage.dart';
import 'package:ttooler/pages/timetablePage.dart';
import 'package:ttooler/widgets/home/glanceHeader.dart';
import 'package:ttooler/widgets/timetable/timetableTimelineBuilder.dart';

class TimetableGlance extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final String day = DateFormat("EEEE").format(now);
    final _timetable = Provider.of<TimeTableProvider>(context).getListOfTimeTable(day, "mainpage");
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlanceHeader(glanceType: GlanceType.TimeTable,),
          if (_timetable.length == 0)
            Container(
              height: MediaQuery.of(context).size.height/2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$day",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "You don't have any time table.😪",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ),
          if (_timetable.length <= 3 && _timetable.length != 0)
            TimetableTimelineBuilder(day: day, items: _timetable, leftPadding: 0, rightPadding: 0, where: "Glance",),
          if (_timetable.length > 3)
            TimetableTimelineBuilder(day: day, items: _timetable.sublist(0,3), leftPadding: 0, rightPadding: 0, where: "Glance",),
          if(_timetable.length != 0)TextButton(onPressed: (){
            Navigator.of(context).push(CustomPageRouteBuilder(enterPage: TimetablePage()));
          }, child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("See all", style: TextStyle(
                fontSize: 20,
              ),),
              SizedBox(width: 10,),
              Icon(Icons.east, color: Colors.white,)
            ],
          )),
          SizedBox(height: 100,)
        ],
      ),
    );
  }
}