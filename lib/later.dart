import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ttooler/modals/timetableProvider.dart';
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

  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  bool isDayChangerOpen = false;

  String day = "M";

  String dayName = "Monday";

  String getNameOfDay(String day) {
    switch (day) {
      case "M":
        return "Monday";
      case "T":
        return "Tuesday";
      case "W":
        return "Wednesday";
      case "Th":
        return "Thursday";
      case "F":
        return "Friday";
      case "St":
        return "Saturday";
      default:
        return "Sunday";
    }
  }

  void changeDay(String dayss) {
    print("Hello $dayss");
    setState(() {
      day = dayss;
      dayName = getNameOfDay(day);
    });

    print(day);
  }

  void slideInOutDaySwitcher() {
    if (isDayChangerOpen == false) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isDayChangerOpen = !isDayChangerOpen;
  }

  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _slideAnimation = Tween<double>(begin: -70.0, end: 0.0).animate(
        CurvedAnimation(
            parent: _animationController, curve: Curves.easeOutCubic));
    _slideAnimation.addListener(() {
      setState(() {});
    });
    final now = DateTime.now();
    dayName = DateFormat("EEEE").format(now);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _timetable = Provider.of<TimeTableProvider>(context);

    return Scaffold(
      floatingActionButton: TimetableFloatingAB(
        currentDay: dayName,
      ),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 20,
            titleSpacing: 0,
            elevation: 10,
            forceElevated: true,
            floating: true,
            snap: true,
            title: Row(
              children: [
                Container(
                    height: 20,
                    width: 20,
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
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
        body: Stack(
          children: [
            if (_timetable.getListOfTimeTable(day,"mainpage").length <= 5)
              Container(
                height: MediaQuery.of(context).size.height,
              ),
            TimetableTimelineBuilder(
              items: _timetable.getListOfTimeTable(dayName, "mainpage"),
              leftPadding: 20,
              rightPadding: 20,
              where: "main",
              day: dayName,
            ),
            Positioned(
              top: 40,
              right: 0,
              child: Container(
                  height: 40,
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30)),
                    color: Theme.of(context).accentColor,
                  ),
                  child: IconButton(
                    onPressed: () {
                      slideInOutDaySwitcher();
                    },
                    icon: Icon(
                      isDayChangerOpen
                          ? Icons.navigate_next
                          : Icons.navigate_before,
                      color: Colors.white,
                    ),
                  )),
            ),
            Positioned(
              top: 100,
              right: _slideAnimation.value,
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                child: Container(
                  padding:
                  EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  width: 70,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * (2 / 3),
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                  child: DayTileScroll(
                    changeDay: changeDay,
                    slide: slideInOutDaySwitcher,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DayTileScroll extends StatelessWidget {
  final Function changeDay;
  final Function slide;
  const DayTileScroll({
    required this.changeDay,
    required this.slide,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        // SizedBox(
        //   height: 10,
        // ),
        DayTile(
          day: "M",
          changeDay: changeDay,
          slide: slide,
        ),
        SizedBox(
          height: 20,
        ),
        DayTile(
          day: "T",
          changeDay: changeDay,
          slide: slide,
        ),
        SizedBox(
          height: 20,
        ),
        DayTile(
          day: "W",
          changeDay: changeDay,
          slide: slide,
        ),
        SizedBox(
          height: 20,
        ),
        DayTile(
          day: "Th",
          changeDay: changeDay,
          slide: slide,
        ),
        SizedBox(
          height: 20,
        ),
        DayTile(
          day: "F",
          changeDay: changeDay,
          slide: slide,
        ),
        SizedBox(
          height: 20,
        ),
        DayTile(
          day: "St",
          changeDay: changeDay,
          slide: slide,
        ),
        SizedBox(
          height: 20,
        ),
        DayTile(
          day: "S",
          changeDay: changeDay,
          slide: slide,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class DayTile extends StatelessWidget {
  final String day;
  final Function changeDay;
  final Function slide;
  const DayTile({
    required this.day,
    required this.changeDay,
    required this.slide,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeDay(day);
        slide();
      },
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              "$day",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
