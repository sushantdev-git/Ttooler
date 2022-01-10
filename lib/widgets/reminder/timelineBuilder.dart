import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ttooler/modals/reminderProvier.dart';
import 'package:ttooler/widgets/reminder/reminderDisplayCard.dart';


class TimelineBuilder extends StatefulWidget {

  final Function isSameMonth;
  final List <Reminder>items;
  final double leftPadding;
  final double rightPadding;
  final String where;


  const TimelineBuilder({required this.items, required this.isSameMonth, required this.leftPadding, required this.rightPadding, Key? key,required this.where}) : super(key: key);

  @override
  _TimelineBuilderState createState() => _TimelineBuilderState();
}

class _TimelineBuilderState extends State<TimelineBuilder> {

  int upcomingCount  = 0;

  bool isToday(DateTime date){
    final now = DateTime.now();
    if(date.year == now.year && date.month == now.month && date.day == now.day){
      return true;
    }
    upcomingCount +=1;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10, bottom: 20, right: widget.rightPadding, left: widget.leftPadding),
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //the row will show the month and current/upcoming on basis of reminder
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                if(isToday(widget.items[index].dateTime) && index == 0)Text(
                  "Today",
                  style: TextStyle(fontSize: 20, color: Colors.white60),
                ),

                if(!isToday(widget.items[index].dateTime) &&  upcomingCount == 2)Text(
                  "Upcoming",
                  style: TextStyle(fontSize: 20, color: Colors.white60),
                ),

                //if index == 0 then show the month name
                if (index == 0)
                  Text(
                    DateFormat("MMM yyyy").format(widget.items[index].dateTime),
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),

                //if current reminder month is not equal to next reminder month then we will show the month name
                if (index != 0 &&
                    widget.isSameMonth(widget.items[index - 1].dateTime,
                        widget.items[index].dateTime))
                  Text(
                    DateFormat("MMM yyyy").format(widget.items[index].dateTime),
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
              ],
            ),

            //the stack will show the line, date and reminder card
            Stack(
              children: <Widget>[
                new Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: ReminderCard(
                      title: widget.items[index].title,
                      description: widget.items[index].description,
                      dateTime: widget.items[index].dateTime,
                      index: index,
                      category: widget.items[index].category,
                      id: widget.items[index].id,
                    ),),
                new Positioned(
                  top: index == 0 ||
                      index == 1 ||
                      widget.isSameMonth(widget.items[index - 1].dateTime,
                          widget.items[index].dateTime)
                      ? 17.0
                      : 0, //if index 0 ,1 or month don't matches then we want to line to be started from 17 px down from top else 0 px
                  bottom: index == 0 ||
                      index == widget.items.length - 1 ||
                      (index != widget.items.length - 1 &&
                          widget.isSameMonth(widget.items[index].dateTime,
                              widget.items[index + 1].dateTime))
                      ? 15
                      : 0, //if index 0, last or current reminder month is different from next reminder month then we want to line end
                  //15 px above from bottom else go to 0 px
                  left: 15.0,
                  child: new Container(
                    height: double.infinity,
                    width: 1.0,
                    color: Colors.white,
                  ),
                ),
                new Positioned(
                  top: 15.0,
                  left: 1.0,
                  child: new Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff262A3D),
                    ),
                    child: Center(
                      child: Text(
                        DateFormat("dd").format(widget.items[index].dateTime),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                //if index 0, last, of month difference between current reminder and next reminder the line line will be disconnect
                //so we will put a small circle at end of line
                if (index == 0 ||
                    index == widget.items.length - 1 ||
                    (index != widget.items.length - 1 &&
                        widget.isSameMonth(widget.items[index].dateTime,
                            widget.items[index + 1].dateTime)))
                  Positioned(
                    left: 10.5,
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
            if(index == widget.items.length -1 && widget.where == "main") Container( height: 100,),
          ],
        );
      },
      itemCount: widget.items.length,
    );
  }
}
