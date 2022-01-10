import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:ttooler/database/timetableDatabase.dart';
import 'package:ttooler/konstant/konstant.dart';
import 'package:ttooler/notification/notifications.dart';

class TimeTable {
  final String title;
  final String description;
  final TimeOfDay fromTimeOfDay;
  final TimeOfDay toTimeOfDay;
  final String id;
  final String day;
  final TypeCategory category;

  TimeTable({
    required this.title,
    required this.description,
    required this.fromTimeOfDay,
    required this.toTimeOfDay,
    required this.id,
    required this.day,
    required this.category,
  });
}

class TimeTableProvider extends ChangeNotifier {
  List<TimeTable> _itemsMonday = [];
  List<TimeTable> _itemsTuesday = [];
  List<TimeTable> _itemsWednesday = [];
  List<TimeTable> _itemsThursday = [];
  List<TimeTable> _itemsFriday = [];
  List<TimeTable> _itemsSaturday = [];
  List<TimeTable> _itemsSunday = [];

  var queueMon = PriorityQueue<TimeTable>(
      (a, b) => compareTime(a.fromTimeOfDay, b.fromTimeOfDay));
  var queueTue = PriorityQueue<TimeTable>(
      (a, b) => compareTime(a.fromTimeOfDay, b.fromTimeOfDay));
  var queueWed = PriorityQueue<TimeTable>(
      (a, b) => compareTime(a.fromTimeOfDay, b.fromTimeOfDay));
  var queueThr = PriorityQueue<TimeTable>(
      (a, b) => compareTime(a.fromTimeOfDay, b.fromTimeOfDay));
  var queueFri = PriorityQueue<TimeTable>(
      (a, b) => compareTime(a.fromTimeOfDay, b.fromTimeOfDay));
  var queueSat = PriorityQueue<TimeTable>(
      (a, b) => compareTime(a.fromTimeOfDay, b.fromTimeOfDay));
  var queueSun = PriorityQueue<TimeTable>(
      (a, b) => compareTime(a.fromTimeOfDay, b.fromTimeOfDay));


  List<TimeTable> getTimetableList(String day){
    switch (day) {
      case "Monday":
        return _itemsMonday;
      case "Tuesday":
        return _itemsTuesday;
      case "Wednesday":
        return _itemsWednesday;
      case "Thursday":
        return _itemsThursday;
      case "Friday":
        return _itemsFriday;
      case "Saturday":
        return _itemsSaturday;
      default:
        return _itemsSunday;
    }
  }


  PriorityQueue<TimeTable> getTimetableQueue(String day){
    switch (day) {
      case "Monday":
        return queueMon;
      case "Tuesday":
        return queueTue;
      case "Wednesday":
        return queueWed;
      case "Thursday":
        return queueThr;
      case "Friday":
        return queueFri;
      case "Saturday":
        return queueSat;
      default:
        return queueSun;
    }
  }

  void setTimetableList(String day, List<TimeTable> dayList){
    switch (day) {
      case "Monday":
        _itemsMonday = dayList;
        break;
      case "Tuesday":
        _itemsTuesday = dayList;
        break;
      case "Wednesday":
        _itemsWednesday = dayList;
        break;
      case "Thursday":
        _itemsThursday = dayList;
        break;
      case "Friday":
        _itemsFriday = dayList;
        break;
      case "Saturday":
        _itemsSaturday = dayList;
        break;
      default:
        _itemsSunday = dayList;
        break;
    }
    notifyListeners();
  }


   void setTimetableQueue(String day, PriorityQueue<TimeTable> dayQ){
    switch (day) {
      case "Monday":
        queueMon = dayQ;
        break;
      case "Tuesday":
        queueTue = dayQ;
        break;
      case "Wednesday":
        queueWed = dayQ;
        break;
      case "Thursday":
        queueThr = dayQ;
        break;
      case "Friday":
        queueFri = dayQ;
        break;
      case "Saturday":
        queueSat = dayQ;
        break;
      default:
        queueSun = dayQ;
        break;
    }
  }

  int combineHourAndMin(TimeOfDay A) {
    final now = DateTime.now();
    final toFormat = DateTime(now.year, now.month, now.day, A.hour, A.minute);
    final s = int.parse(DateFormat("Hmm").format(toFormat));
    // print("combine hour and min");
    // print(s);
    return s;
  }

  List<int> checkOverlapping({
    required TimeOfDay fromTime,
    required TimeOfDay toTime,
    required String day,
  }) {
    List<TimeTable> times = getListOfTimeTable(day, "modal");
    // print(day);
    if (times.length == 0) {
      print(true);
      return [-1];
    }

    // print("item length " + times.length.toString());
    //
    // print(fromTime.toString()+" "+toTime.toString());
    List<int> overlappingIndexes = [];
    for (int i = 0; i < times.length; i++) {
      // print(times[i].fromTimeOfDay.toString() +
      //     " " +
      //     times[i].toTimeOfDay.toString());
      if (combineHourAndMin(fromTime) <=
          combineHourAndMin(times[i].fromTimeOfDay)) {
        if (combineHourAndMin(toTime) <=
            combineHourAndMin(times[i].fromTimeOfDay)) {
          if (overlappingIndexes.length == 0)
            return [-1];
          else
            return overlappingIndexes;
        } else {
          overlappingIndexes.add(i);
        }
      } else if (combineHourAndMin(fromTime) >
          combineHourAndMin(times[i].fromTimeOfDay)) {
        if (combineHourAndMin(fromTime) <
            combineHourAndMin(times[i].toTimeOfDay)) {
          overlappingIndexes.add(i);
        }
      }
      // print(overlappingIndexes);
    }
    // print("hello");
    if (overlappingIndexes.length == 0) {
      return [-1];
    }
    return overlappingIndexes;
  }

  int getDayNumber(String day) {
    switch (day) {
      case "Monday":
        return 1;
      case "Tuesday":
        return 2;
      case "Wednesday":
        return 3;
      case "Thursday":
        return 4;
      case "Friday":
        return 5;
      case "Saturday":
        return 6;
      default:
        return 7;
    }
  }


  void add(
      {required String title,
      required String description,
      required TimeOfDay fromTimeOfDay,
      required TimeOfDay toTimeOfDay,
      required String whichDay,
      required TypeCategory category,
      required List<int> overlappingIndexes}) async {

    final now = DateTime.now();
    final toTime = DateTime(
        now.year, now.month, now.day, toTimeOfDay.hour, toTimeOfDay.minute);
    final fromTime = DateTime(
        now.year, now.month, now.day, fromTimeOfDay.hour, fromTimeOfDay.minute);


    List<TimeTable> dayList = getTimetableList(whichDay);
    PriorityQueue<TimeTable> dayQ = getTimetableQueue(whichDay);


    for (int i = 0; i < overlappingIndexes.length; i++) {
      dayQ.remove(dayList[overlappingIndexes[i]]);
      await TimetableDatabase.delete(
          dayList[overlappingIndexes[i]].id, whichDay);
      await Notifications.cancelNotification(
          Notifications.getHashCode(dayList[overlappingIndexes[i]].id));
      //this will cancel any scheduled notifications.

    }
    dayQ.add(TimeTable(
      title: title,
      description: description,
      fromTimeOfDay: fromTimeOfDay,
      toTimeOfDay: toTimeOfDay,
      id: now.toString() + whichDay,
      day: whichDay,
      category: category,
    ));
    dayList = dayQ.toList();
    await TimetableDatabase.insert({
      "id": now.toString() + whichDay,
      "title": title,
      "description": description,
      "toTime": toTime.toIso8601String(),
      "fromTime": fromTime.toIso8601String(),
      "day": whichDay,
      "category":category.index,
    }, whichDay);

    await Notifications.showWeeklyNotification(
      id: Notifications.getHashCode(now.toString() + "Timetable" + whichDay ),
      scheduleTime: Time(fromTime.hour, fromTime.minute),
      title: description.length != 0 ? "Timetable | "+ title : "TimeTable",
      body: description.length != 0 ? description : title,
      weekday: getDayNumber(whichDay),
    );
    setTimetableList(whichDay, dayList);
    setTimetableQueue(whichDay, dayQ);

  }

  List<TimeTable> getListOfTimeTable(String day, String where) {
    //This function is called by widgets to get the timetable list of that day.
    List<TimeTable> dayList = getTimetableList(day);
    if (where == "modal") return dayList;
    return orderTimetable(dayList);

  }

  void printList(List<TimeTable> temp) {
    for (int i = 0; i < temp.length; i++) {
      print(temp[i].title);
      print(temp[i].description);
      print(temp[i].fromTimeOfDay.toString());
      print(temp[i].id);
    }
  }

  List<TimeTable> orderTimetable(List<TimeTable> time) {
    var q = QueueList<TimeTable>();

    for (int i = 0; i < time.length; i++) {
      q.add(time[i]);
    }
    int n = 0;

    final currentTime = TimeOfDay.now();

    //here i m comparing the first element of queue to current time and if it is less than that, then i move that element to list.
    while (n < time.length) {
      if (compareTime(q[0].toTimeOfDay, currentTime) == -1) {
        q.addLast(q.first);
        q.removeFirst();
      } else {
        break;
      }
      n++;
    }

    return q.toList();
  }

  int getCurrentScheduleIndex(String? key, String day) {
    if (key == null) {
      return -1;
    }
    List<TimeTable> dayList = getTimetableList(day);
    return dayList.indexWhere((element) => element.id == key);

  }

  void removeSchedule(String key, String day) async {
    print(day);

    List<TimeTable> dayList = getTimetableList(day);
    PriorityQueue<TimeTable> dayQ = getTimetableQueue(day);

    final item = dayList.firstWhere((element) => element.id == key);
    dayQ.remove(item);
    await TimetableDatabase.delete(key, day);
    await Notifications.cancelNotification(Notifications.getHashCode(key));
    dayList = dayQ.toList();

    setTimetableList(day, dayList);
    setTimetableQueue(day, dayQ);

  }


  int getCategoryWiseTime(TypeCategory category, String day){
    int totalTime = 0;

    List<TimeTable> dayList = getTimetableList(day);

    for(int i=0; i<dayList.length; i++){
      TimeTable e = dayList[i];
      if(e.category == category){
        int x = e.toTimeOfDay.hour*60+e.toTimeOfDay.minute;
        int y = e.fromTimeOfDay.hour*60+e.fromTimeOfDay.minute;
        totalTime+=(x-y);
      }
    }

    return totalTime;
  }

  Future<void> fetchAndSetData() async {
    List<String> li = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];

    li.forEach((day) async {
      final data = await TimetableDatabase.getData(day);
      List<TimeTable> tempList;
      var tempQ = PriorityQueue<TimeTable>(
              (a, b) => compareTime(a.fromTimeOfDay, b.fromTimeOfDay));
      tempList = data
          .map(
            (tt) =>
            TimeTable(
              title: tt["title"],
              description: tt["description"],
              id: tt["id"],
              fromTimeOfDay: TimeOfDay(
                  hour: DateTime
                      .parse(tt["fromTime"] as String)
                      .hour,
                  minute: DateTime
                      .parse(tt["fromTime"] as String)
                      .minute),
              toTimeOfDay: TimeOfDay(
                  hour: DateTime
                      .parse(tt["toTime"] as String)
                      .hour,
                  minute: DateTime
                      .parse(tt["toTime"] as String)
                      .minute),
              day: tt["day"],
              category: TypeCategory.values.elementAt(tt["category"]),
            ),
      )
          .toList();

      tempQ.clear();
      for (int j = 0; j < tempList.length; j++) {
        tempQ.add(tempList[j]);
      }
      tempList = tempQ.toList();
      setTimetableList(day, tempList);
      setTimetableQueue(day, tempQ);
    });

    await Future.delayed(Duration(milliseconds: 300));

  }
}

int compareTime(TimeOfDay a, TimeOfDay b) {
  final now = DateTime.now();
  final A = DateTime(
    now.year,
    now.month,
    now.day,
    a.hour,
    a.minute,
  );

  final B = DateTime(
    now.year,
    now.month,
    now.day,
    b.hour,
    b.minute,
  );

  return A.compareTo(B);
}
