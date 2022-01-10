import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/modals/timetableProvider.dart';
import 'package:ttooler/pageRoutebuilder/heroPageRouteBuilder.dart';
import 'package:ttooler/widgets/timetable/stats.dart';
import 'package:ttooler/widgets/timetable/timetableFAB.dart';
import 'package:ttooler/widgets/timetable/timetableTimelineBuilder.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage({Key? key}) : super(key: key);

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage>
    with SingleTickerProviderStateMixin {
  bool isSameMonth(DateTime prev, DateTime next) {
    return prev.month != next.month;
  }

  bool isDayChangerOpen = false;


  String dayName = "Monday";


  void changeDay(String day) {
    print(day);
    setState(() {
      dayName = day;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    final now = DateTime.now();
    dayName = DateFormat("EEEE").format(now);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final _timetable = Provider.of<TimeTableProvider>(context);

    return Scaffold(
      floatingActionButton: TimetableFloatingAB(
        currentDay: dayName,
      ),
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 1,
        title: Row(
          children: [
            Container(
                height: 30,
                width: 30,
                child: Image.asset(
                  "assets/images/icon_images/calender.png",
                  fit: BoxFit.cover,
                )),
            SizedBox(
              width: 5,
            ),
            Text(
              "Timetable",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return Statistics(onPress: changeDay, day: dayName,);
            },));
          }, icon: Icon(Icons.insights, color: Colors.white,)),
          IconButton(onPressed: (){
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return DayPicker(onPress: changeDay);
            },));
          }, icon: Icon(Icons.calendar_today, color: Colors.white,))
        ],
      ),
      body: TimetableTimelineBuilder(
          items: _timetable.getListOfTimeTable(dayName, "mainpage"),
          leftPadding: 20,
          rightPadding: 20,
          where: "main",
          day: dayName,
        ),
      );
  }
}

class DayPicker extends StatelessWidget {
  final Function onPress;
  const DayPicker({
    required this.onPress,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minW = MediaQuery.of(context).size.width/4 <= 90;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.only(top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * (0.7)),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Pick Day", style: TextStyle(
                                fontSize: 25,
                                color: Color(0xff262A3D),
                              ),),
                              Text("pick a day to see the schedule.", style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff262A3D),
                                fontStyle: FontStyle.italic,
                              ),),
                              SizedBox(height: 20,),
                              GridView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.only(bottom: 20, right: 10, left: 5),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                children: [
                                  ElevatedButton(onPressed: (){
                                    onPress("Monday"); Navigator.of(context).pop();
                                    print(MediaQuery.of(context).size.width);
                                  }, child: minW ? Text("M") : Text("Mon")),
                                  ElevatedButton(onPressed: (){onPress("Tuesday");Navigator.of(context).pop();}, child:  minW ? Text("T") : Text("Tue") ),
                                  ElevatedButton(onPressed: (){onPress("Wednesday");Navigator.of(context).pop();}, child: minW ?  Text("W"): Text("Wed")),
                                  ElevatedButton(onPressed: (){onPress("Thursday");Navigator.of(context).pop();}, child: minW ? Text("Th"):Text("Thu")),
                                  ElevatedButton(onPressed: (){onPress("Friday");Navigator.of(context).pop();}, child: minW ? Text("F"):Text("Fri")),
                                  ElevatedButton(onPressed: (){onPress("Saturday");Navigator.of(context).pop();}, child: minW ? Text("St"):Text("Sat")),
                                  ElevatedButton(onPressed: (){onPress("Sunday");Navigator.of(context).pop();}, child: minW ? Text("S"): Text("Sun")),
                                  Center(child: Text("🚴", style: TextStyle(
                                      fontSize: minW ? 35: 50,
                                      shadows: [
                                    Shadow(
                                      color: Colors.black26,
                                      blurRadius: 5,
                                      offset: Offset(1,1)
                                    )
                                  ]),))
                                ],
                              ),
                            ],
                          ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        onPressed: () {
                          print("hello");
                          Navigator.of(context).pop();
                        },
                        icon: Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 5,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
