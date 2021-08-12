import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ttooler/modals/timetableProvider.dart';
import 'package:ttooler/widgets/timetable/timetableDisplaycCard.dart';


class TimetableTimelineBuilder extends StatelessWidget {

  final List<TimeTable> items;
  final double leftPadding;
  final double rightPadding;
  final String where;
  final String day;

  const TimetableTimelineBuilder({required this.items, required this.leftPadding, required this.rightPadding, Key? key,required this.where, required this.day}) : super(key: key);

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute); //"6:00 AM"
    return DateFormat("h:mm a").format(dt);
  }

  bool isDayRepeat(TimeOfDay a, TimeOfDay b){
    if(a.hour > b.hour){
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return items.length == 0 ? Center(
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
    ):ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10, bottom: 20, right: rightPadding, left: leftPadding),
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //the row will show the month and current/upcoming on basis of reminder
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                if(index == 0) Text(
                  "$day",
                  style: TextStyle(fontSize: 20, color: Colors.white70),
                ),
                if(index == 0)Text(
                  "Current",
                  style: TextStyle(fontSize: 17, color: Colors.white60,fontWeight: FontWeight.w100,),
                ),
                if(index == 1)Text(
                  "Upcoming",
                  style: TextStyle(fontSize: 17, color: Colors.white60,fontWeight: FontWeight.w100,),
                ),

                //if index == 0 then show the month name
                // if (index == 0)
                //   Text(
                //     "${items[index].timeOfDay}",
                //     style: TextStyle(fontSize: 12, color: Colors.grey),
                //   ),

                //if current reminder month is not equal to next reminder month then we will show the month name
                if (index != 0 &&
                    isDayRepeat(items[index - 1].fromTimeOfDay,
                        items[index].fromTimeOfDay))
                  Text("Next $day", style: TextStyle(
                    color: Colors.white60,
                    fontSize: 15,
                    fontWeight: FontWeight.w100,
                  ),)
              ],
            ),

            //the stack will show the line, date and reminder card
            Stack(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(left: 55.0),
                  child: TimetableCard(
                    day: items[index].day,
                    description: items[index].description,
                    heroKey: items[index].key,
                    index: index,
                    fromTime: items[index].fromTimeOfDay,
                    toTime: items[index].toTimeOfDay,
                    title: items[index].title,
                  )
                ),
                new Positioned(
                  top: index == 0 ||
                      index == 1 ||
                      isDayRepeat(items[index - 1].fromTimeOfDay,
                          items[index].fromTimeOfDay)
                      ? 17.0
                      : 0, //if index 0 ,1 or month don't matches then we want to line to be started from 17 px down from top else 0 px
                  bottom: index == 0 ||
                      index == items.length - 1 ||
                      (index != items.length - 1 &&
                          isDayRepeat(items[index].fromTimeOfDay,
                              items[index + 1].fromTimeOfDay))
                      ? 15
                      : 0, //if index 0, last or current reminder month is different from next reminder month then we want to line end
                  //15 px above from bottom else go to 0 px
                  left: 22.0,
                  child: new Container(
                    height: double.infinity,
                    width: 1.0,
                    color: Colors.white,
                  ),
                ),
                new Positioned(
                  top: 15.0,
                  left: 0.0,
                  child: new Container(
                    height: 45.0,
                    width: 45.0,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff262A3D),
                    ),
                    child: Center(
                      child: Text(
                        formatTimeOfDay(items[index].fromTimeOfDay),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                //if index 0, last, of month difference between current reminder and next reminder the line line will be disconnect
                //so we will put a small circle at end of line
                if (index == 0 ||
                    index == items.length - 1 ||
                    (index != items.length - 1 &&
                        isDayRepeat(items[index].fromTimeOfDay,
                            items[index + 1].fromTimeOfDay)))
                  Positioned(
                    left: 17.5,
                    bottom: 5,
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  )
              ],
            ),
            if(index == items.length -1 && where == "main") Container( height: 100,),
          ],
        );
      },
      itemCount: items.length,
    );
  }
}
