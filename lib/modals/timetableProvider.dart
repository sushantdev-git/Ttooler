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
        return 0;
      case "Tuesday":
        return 1;
      case "Wednesday":
        return 2;
      case "Thursday":
        return 3;
      case "Friday":
        return 4;
      case "Saturday":
        return 5;
      default:
        return 6;
    }
  }

  int dayDifference(String day) {
    //this function find the difference between two days
    final now = DateTime.now();
    String nowDay = DateFormat("EEEE").format(now);

    int a = getDayNumber(day);
    int b = getDayNumber(nowDay);

    // print(a - b);
    return a - b;
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
    if (whichDay == "Monday") {
      for (int i = 0; i < overlappingIndexes.length; i++) {
        queueMon.remove(_itemsMonday[overlappingIndexes[i]]);
        await TimetableDatabase.delete(
            _itemsMonday[overlappingIndexes[i]].id, "Monday");
        await Notifications.cancelNotification(
            Notifications.getHashCode(_itemsMonday[overlappingIndexes[i]].id));
        //this will cancel any scheduled notifications.

      }
      queueMon.add(TimeTable(
        title: title,
        description: description,
        fromTimeOfDay: fromTimeOfDay,
        toTimeOfDay: toTimeOfDay,
        id: now.toString() + whichDay,
        day: whichDay,
        category: category,
      ));
      _itemsMonday = queueMon.toList();
      await TimetableDatabase.insert({
        "id": now.toString() + whichDay,
        "title": title,
        "description": description,
        "toTime": toTime.toIso8601String(),
        "fromTime": fromTime.toIso8601String(),
        "day": "Monday",
        "category":category.index,
      }, "Monday");

      await Notifications.showWeeklyNotification(
        id: Notifications.getHashCode(now.toString() + whichDay),
        scheduleTime: Time(fromTime.hour, fromTime.minute),
        title: title,
        body: description,
        weekday: 1,
      );
      notifyListeners();
    } else if (whichDay == "Tuesday") {
      for (int i = 0; i < overlappingIndexes.length; i++) {
        queueTue.remove(_itemsTuesday[overlappingIndexes[i]]);
        await TimetableDatabase.delete(
            _itemsTuesday[overlappingIndexes[i]].id, "Tuesday");
        await Notifications.cancelNotification(
            Notifications.getHashCode(_itemsTuesday[overlappingIndexes[i]].id));
        // print(Notifications.getHashCode(_itemsTuesday[overlappingIndexes[i]].id));
      }
      queueTue.add(TimeTable(
          title: title,
          description: description,
          fromTimeOfDay: fromTimeOfDay,
          toTimeOfDay: toTimeOfDay,
          id: now.toString() + whichDay,
          category: category,
          day: whichDay));
      _itemsTuesday = queueTue.toList();
      await TimetableDatabase.insert({
        "id": now.toString() + whichDay,
        "title": title,
        "description": description,
        "toTime": toTime.toIso8601String(),
        "fromTime": fromTime.toIso8601String(),
        "day": "Tuesday",
        "category":category.index,
      }, "Tuesday");
      await Notifications.showWeeklyNotification(
        id: Notifications.getHashCode(now.toString() + whichDay),
        scheduleTime: Time(fromTime.hour, fromTime.minute),
        title: title,
        body: description,
        weekday: 2,
      );
      // print(Notifications.getHashCode(now.toString() + whichDay));
      notifyListeners();
    } else if (whichDay == "Wednesday") {
      for (int i = 0; i < overlappingIndexes.length; i++) {
        queueWed.remove(_itemsWednesday[overlappingIndexes[i]]);
        await TimetableDatabase.delete(
            _itemsWednesday[overlappingIndexes[i]].id, "Wednesday");
        await Notifications.cancelNotification(Notifications.getHashCode(
            _itemsWednesday[overlappingIndexes[i]].id));
      }
      queueWed.add(TimeTable(
        title: title,
        description: description,
        fromTimeOfDay: fromTimeOfDay,
        toTimeOfDay: toTimeOfDay,
        id: now.toString() + whichDay,
        day: whichDay,
        category: category,
      ));
      _itemsWednesday = queueWed.toList();
      await TimetableDatabase.insert({
        "id": now.toString() + whichDay,
        "title": title,
        "description": description,
        "toTime": toTime.toIso8601String(),
        "fromTime": fromTime.toIso8601String(),
        "day": "Wednesday",
        "category":category.index,
      }, "Wednesday");
      await Notifications.showWeeklyNotification(
        id: Notifications.getHashCode(now.toString() + whichDay),
        scheduleTime: Time(fromTime.hour, fromTime.minute),
        title: title,
        body: description,
        weekday: 3,
      );
      notifyListeners();
    } else if (whichDay == "Thursday") {
      for (int i = 0; i < overlappingIndexes.length; i++) {
        queueThr.remove(_itemsThursday[overlappingIndexes[i]]);
        await TimetableDatabase.delete(
            _itemsThursday[overlappingIndexes[i]].id, "Thursday");
        await Notifications.cancelNotification(Notifications.getHashCode(
            _itemsThursday[overlappingIndexes[i]].id));
      }
      queueThr.add(TimeTable(
        title: title,
        description: description,
        fromTimeOfDay: fromTimeOfDay,
        toTimeOfDay: toTimeOfDay,
        id: now.toString() + whichDay,
        day: whichDay,
        category: category,
      ));
      _itemsThursday = queueThr.toList();
      await TimetableDatabase.insert({
        "id": now.toString() + whichDay,
        "title": title,
        "description": description,
        "toTime": toTime.toIso8601String(),
        "fromTime": fromTime.toIso8601String(),
        "day": "Thursday",
        "category":category.index,
      }, "Thursday");
      await Notifications.showWeeklyNotification(
        id: Notifications.getHashCode(now.toString() + whichDay),
        scheduleTime: Time(fromTime.hour, fromTime.minute),
        title: title,
        body: description,
        weekday: 4,
      );
      notifyListeners();
    } else if (whichDay == "Friday") {
      for (int i = 0; i < overlappingIndexes.length; i++) {
        queueFri.remove(_itemsFriday[overlappingIndexes[i]]);
        await TimetableDatabase.delete(
            _itemsFriday[overlappingIndexes[i]].id, "Friday");
        await Notifications.cancelNotification(
            Notifications.getHashCode(_itemsFriday[overlappingIndexes[i]].id));
      }
      queueFri.add(TimeTable(
        title: title,
        description: description,
        fromTimeOfDay: fromTimeOfDay,
        toTimeOfDay: toTimeOfDay,
        id: now.toString() + whichDay,
        day: whichDay,
        category: category,
      ));
      _itemsFriday = queueFri.toList();
      await TimetableDatabase.insert({
        "id": now.toString() + whichDay,
        "title": title,
        "description": description,
        "toTime": toTime.toIso8601String(),
        "fromTime": fromTime.toIso8601String(),
        "day": "Friday",
        "category":category.index,
      }, "Friday");
      await Notifications.showWeeklyNotification(
        id: Notifications.getHashCode(now.toString() + whichDay),
        scheduleTime: Time(fromTime.hour, fromTime.minute),
        title: title,
        body: description,
        weekday: 5,
      );
      notifyListeners();
    } else if (whichDay == "Saturday") {
      for (int i = 0; i < overlappingIndexes.length; i++) {
        queueSat.remove(_itemsSaturday[overlappingIndexes[i]]);
        await TimetableDatabase.delete(
            _itemsSaturday[overlappingIndexes[i]].id, "Saturday");
        await Notifications.cancelNotification(Notifications.getHashCode(
            _itemsSaturday[overlappingIndexes[i]].id));
      }
      queueSat.add(TimeTable(
        title: title,
        description: description,
        fromTimeOfDay: fromTimeOfDay,
        toTimeOfDay: toTimeOfDay,
        id: now.toString() + whichDay,
        day: whichDay,
        category: category,
      ));
      _itemsSaturday = queueSat.toList();
      await TimetableDatabase.insert({
        "id": now.toString() + whichDay,
        "title": title,
        "description": description,
        "toTime": toTime.toIso8601String(),
        "fromTime": fromTime.toIso8601String(),
        "day": "Saturday",
        "category":category.index,
      }, "Saturday");
      await Notifications.showWeeklyNotification(
        id: Notifications.getHashCode(now.toString() + whichDay),
        scheduleTime: Time(fromTime.hour, fromTime.minute),
        title: title,
        body: description,
        weekday: 6,
      );
      // print(now.weekday);
      notifyListeners();
    } else if (whichDay == "Sunday") {
      for (int i = 0; i < overlappingIndexes.length; i++) {
        queueSun.remove(_itemsSunday[overlappingIndexes[i]]);
        await TimetableDatabase.delete(
            _itemsSunday[overlappingIndexes[i]].id, "Sunday");
        await Notifications.cancelNotification(
            Notifications.getHashCode(_itemsSunday[overlappingIndexes[i]].id));
      }
      queueSun.add(TimeTable(
        title: title,
        description: description,
        fromTimeOfDay: fromTimeOfDay,
        toTimeOfDay: toTimeOfDay,
        id: now.toString() + whichDay,
        day: whichDay,
        category: category,
      ));
      _itemsSunday = queueSun.toList();
      await TimetableDatabase.insert({
        "id": now.toString() + whichDay,
        "title": title,
        "description": description,
        "toTime": toTime.toIso8601String(),
        "fromTime": fromTime.toIso8601String(),
        "day": "Sunday",
        "category":category.index,
      }, "Sunday");
      await Notifications.showWeeklyNotification(
        id: Notifications.getHashCode(now.toString() + whichDay),
        scheduleTime: Time(fromTime.hour, fromTime.minute),
        title: title,
        body: description,
        weekday: 7,
      );
      notifyListeners();
    }
  }

  List<TimeTable> getListOfTimeTable(String day, String where) {
    switch (day) {
      case "Monday":
        if (where == "modal") return [..._itemsMonday];
        return orderTimetable([..._itemsMonday]);
      case "Tuesday":
        if (where == "modal") return [..._itemsTuesday];
        return orderTimetable([..._itemsTuesday]);
      case "Wednesday":
        if (where == "modal") return [..._itemsWednesday];
        return orderTimetable([..._itemsWednesday]);
      case "Thursday":
        if (where == "modal") return [..._itemsThursday];
        return orderTimetable([..._itemsThursday]);
      case "Friday":
        if (where == "modal") return [..._itemsFriday];
        return orderTimetable([..._itemsFriday]);
      case "Saturday":
        if (where == "modal") return [..._itemsSaturday];
        return orderTimetable([..._itemsSaturday]);
      default:
        if (where == "modal") return [..._itemsSunday];
        return orderTimetable([..._itemsSunday]);
    }
  }

  // void printQueue(List<TimeTable> temp) {
  //   for (int i = 0; i < temp.length; i++) {
  //     print(temp[i].title);
  //     print(temp[i].description);
  //     print(temp[i].fromTimeOfDay.toString());
  //     print(temp[i].id);
  //   }
  // }

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
    switch (day) {
      case "Monday":
        return _itemsMonday.indexWhere((element) => element.id == key);
      case "Tuesday":
        return _itemsTuesday.indexWhere((element) => element.id == key);
      case "Wednesday":
        return _itemsWednesday.indexWhere((element) => element.id == key);
      case "Thursday":
        return _itemsThursday.indexWhere((element) => element.id == key);
      case "Friday":
        return _itemsFriday.indexWhere((element) => element.id == key);
      case "Saturday":
        return _itemsSaturday.indexWhere((element) => element.id == key);
      default:
        return _itemsSunday.indexWhere((element) => element.id == key);
    }
  }

  void removeSchedule(String key, String day) async {
    switch (day) {
      case "Monday":
        final item = _itemsMonday.firstWhere((element) => element.id == key);
        queueMon.remove(item);
        await TimetableDatabase.delete(key, day);
        await Notifications.cancelNotification(Notifications.getHashCode(key));
        _itemsMonday = queueMon.toList();
        break;
      case "Tuesday":
        final item = _itemsTuesday.firstWhere((element) => element.id == key);
        queueTue.remove(item);
        await TimetableDatabase.delete(key, day);
        await Notifications.cancelNotification(Notifications.getHashCode(key));
        _itemsTuesday = queueTue.toList();
        break;
      case "Wednesday":
        final item = _itemsWednesday.firstWhere((element) => element.id == key);
        queueWed.remove(item);
        await TimetableDatabase.delete(key, day);
        await Notifications.cancelNotification(Notifications.getHashCode(key));
        _itemsWednesday = queueWed.toList();
        break;
      case "Thursday":
        final item = _itemsThursday.firstWhere((element) => element.id == key);
        queueThr.remove(item);
        await TimetableDatabase.delete(key, day);
        await Notifications.cancelNotification(Notifications.getHashCode(key));
        _itemsThursday = queueThr.toList();
        break;
      case "Friday":
        final item = _itemsFriday.firstWhere((element) => element.id == key);
        queueFri.remove(item);
        await TimetableDatabase.delete(key, day);
        await Notifications.cancelNotification(Notifications.getHashCode(key));
        _itemsFriday = queueFri.toList();
        break;
      case "Saturday":
        final item = _itemsSaturday.firstWhere((element) => element.id == key);
        queueSat.remove(item);
        await TimetableDatabase.delete(key, day);
        await Notifications.cancelNotification(Notifications.getHashCode(key));
        _itemsSaturday = queueSat.toList();
        break;
      default:
        final item = _itemsSunday.firstWhere((element) => element.id == key);
        queueSun.remove(item);
        await TimetableDatabase.delete(key, day);
        await Notifications.cancelNotification(Notifications.getHashCode(key));
        _itemsSunday = queueSun.toList();
        break;
    }
    notifyListeners();
  }


  int getCategoryWiseTime(TypeCategory category, String day){
    int totalTime = 0;
    switch (day) {
      case "Monday":
        for(int i=0; i<_itemsMonday.length; i++){
          TimeTable e = _itemsMonday[i];
          if(e.category == category){
            int x = e.toTimeOfDay.hour*60+e.toTimeOfDay.minute;
            int y = e.fromTimeOfDay.hour*60+e.fromTimeOfDay.minute;
            totalTime+=(x-y);
          }
        }
        break;
      case "Tuesday":
        for(int i=0; i<_itemsTuesday.length; i++){
          TimeTable e = _itemsTuesday[i];
          if(e.category == category){
            int x = e.toTimeOfDay.hour*60+e.toTimeOfDay.minute;
            int y = e.fromTimeOfDay.hour*60+e.fromTimeOfDay.minute;
            totalTime+=(x-y);
          }
        }
        break;
      case "Wednesday":
        for(int i=0; i<_itemsWednesday.length; i++){
          TimeTable e = _itemsWednesday[i];
          if(e.category == category){
            int x = e.toTimeOfDay.hour*60+e.toTimeOfDay.minute;
            int y = e.fromTimeOfDay.hour*60+e.fromTimeOfDay.minute;
            totalTime+=(x-y);
          }
        }
        break;
      case "Thursday":
        for(int i=0; i<_itemsThursday.length; i++){
          TimeTable e = _itemsThursday[i];
          if(e.category == category){
            int x = e.toTimeOfDay.hour*60+e.toTimeOfDay.minute;
            int y = e.fromTimeOfDay.hour*60+e.fromTimeOfDay.minute;
            totalTime+=(x-y);
          }
        }
        break;
      case "Friday":
        for(int i=0; i<_itemsFriday.length; i++){
          TimeTable e = _itemsFriday[i];
          if(e.category == category){
            int x = e.toTimeOfDay.hour*60+e.toTimeOfDay.minute;
            int y = e.fromTimeOfDay.hour*60+e.fromTimeOfDay.minute;
            totalTime+=(x-y);
          }
        }
        break;
      case "Saturday":
        for(int i=0; i<_itemsSaturday.length; i++){
          TimeTable e = _itemsSaturday[i];
          if(e.category == category){
            int x = e.toTimeOfDay.hour*60+e.toTimeOfDay.minute;
            int y = e.fromTimeOfDay.hour*60+e.fromTimeOfDay.minute;
            totalTime+=(x-y);
          }
        }
        break;
      default:
        for(int i=0; i<_itemsSunday.length; i++){
          TimeTable e = _itemsSunday[i];
          if(e.category == category){
            int x = e.toTimeOfDay.hour*60+e.toTimeOfDay.minute;
            int y = e.fromTimeOfDay.hour*60+e.fromTimeOfDay.minute;
            totalTime+=(x-y);
          }
        }
        break;
    }
    return totalTime;
  }

  Future<void> fetchAndSetData() async {
    for (int i = 0; i < 7; i++) {
      switch (i) {
        case 0:
          final data = await TimetableDatabase.getData("Monday");
          _itemsMonday = data
              .map(
                (tt) => TimeTable(
                  title: tt["title"],
                  description: tt["description"],
                  id: tt["id"],
                  fromTimeOfDay: TimeOfDay(
                      hour: DateTime.parse(tt["fromTime"] as String).hour,
                      minute: DateTime.parse(tt["fromTime"] as String).minute),
                  toTimeOfDay: TimeOfDay(
                      hour: DateTime.parse(tt["toTime"] as String).hour,
                      minute: DateTime.parse(tt["toTime"] as String).minute),
                  day: tt["day"],
                  category: TypeCategory.values.elementAt(tt["category"]),
                ),
              )
              .toList();

          queueMon.clear();
          for (int j = 0; j < _itemsMonday.length; j++) {
            queueMon.add(_itemsMonday[j]);
          }

          _itemsMonday = queueMon.toList();
          break;
        case 1:
          final data = await TimetableDatabase.getData("Tuesday");
          _itemsTuesday = data
              .map(
                (tt) => TimeTable(
                  title: tt["title"],
                  description: tt["description"],
                  id: tt["id"],
                  fromTimeOfDay: TimeOfDay(
                      hour: DateTime.parse(tt["fromTime"] as String).hour,
                      minute: DateTime.parse(tt["fromTime"] as String).minute),
                  toTimeOfDay: TimeOfDay(
                      hour: DateTime.parse(tt["toTime"] as String).hour,
                      minute: DateTime.parse(tt["toTime"] as String).minute),
                  day: tt["day"],
                  category: TypeCategory.values.elementAt(tt["category"]),
                ),
              )
              .toList();

          queueTue.clear();
          for (int j = 0; j < _itemsTuesday.length; j++) {
            queueTue.add(_itemsTuesday[j]);
          }

          _itemsTuesday = queueTue.toList();
          break;
        case 2:
          final data = await TimetableDatabase.getData("Wednesday");
          _itemsWednesday = data
              .map(
                (tt) => TimeTable(
                  title: tt["title"],
                  description: tt["description"],
                  id: tt["id"],
                  fromTimeOfDay: TimeOfDay(
                      hour: DateTime.parse(tt["fromTime"] as String).hour,
                      minute: DateTime.parse(tt["fromTime"] as String).minute),
                  toTimeOfDay: TimeOfDay(
                      hour: DateTime.parse(tt["toTime"] as String).hour,
                      minute: DateTime.parse(tt["toTime"] as String).minute),
                  day: tt["day"],
                  category:TypeCategory.values.elementAt(tt["category"]),
                ),
              )
              .toList();

          queueWed.clear();
          for (int j = 0; j < _itemsWednesday.length; j++) {
            queueWed.add(_itemsWednesday[j]);
          }

          _itemsWednesday = queueWed.toList();
          break;
        case 3:
          final data = await TimetableDatabase.getData("Thursday");
          _itemsThursday = data
              .map(
                (tt) => TimeTable(
                  title: tt["title"],
                  description: tt["description"],
                  id: tt["id"],
                  fromTimeOfDay: TimeOfDay(
                      hour: DateTime.parse(tt["fromTime"] as String).hour,
                      minute: DateTime.parse(tt["fromTime"] as String).minute),
                  toTimeOfDay: TimeOfDay(
                      hour: DateTime.parse(tt["toTime"] as String).hour,
                      minute: DateTime.parse(tt["toTime"] as String).minute),
                  day: tt["day"],
                  category: TypeCategory.values.elementAt(tt["category"]),
                ),
              )
              .toList();

          queueThr.clear();
          for (int j = 0; j < _itemsThursday.length; j++) {
            queueThr.add(_itemsThursday[j]);
          }

          _itemsThursday = queueThr.toList();
          break;
        case 4:
          final data = await TimetableDatabase.getData("Friday");
          _itemsFriday = data
              .map(
                (tt) => TimeTable(
                  title: tt["title"],
                  description: tt["description"],
                  id: tt["id"],
                  fromTimeOfDay: TimeOfDay(
                      hour: DateTime.parse(tt["fromTime"] as String).hour,
                      minute: DateTime.parse(tt["fromTime"] as String).minute),
                  toTimeOfDay: TimeOfDay(
                      hour: DateTime.parse(tt["toTime"] as String).hour,
                      minute: DateTime.parse(tt["toTime"] as String).minute),
                  day: tt["day"],
                  category: TypeCategory.values.elementAt(tt["category"]),
                ),
              )
              .toList();

          queueFri.clear();
          for (int j = 0; j < _itemsFriday.length; j++) {
            queueFri.add(_itemsFriday[j]);
          }

          _itemsFriday = queueFri.toList();
          break;
        case 5:
          final data = await TimetableDatabase.getData("Saturday");
          _itemsSaturday = data
              .map(
                (tt) => TimeTable(
                  title: tt["title"],
                  description: tt["description"],
                  id: tt["id"],
                  fromTimeOfDay: TimeOfDay(
                      hour: DateTime.parse(tt["fromTime"] as String).hour,
                      minute: DateTime.parse(tt["fromTime"] as String).minute),
                  toTimeOfDay: TimeOfDay(
                      hour: DateTime.parse(tt["toTime"] as String).hour,
                      minute: DateTime.parse(tt["toTime"] as String).minute),
                  day: tt["day"],
                  category: TypeCategory.values.elementAt(tt["category"]),
                ),
              )
              .toList();

          queueSat.clear();
          for (int j = 0; j < _itemsSaturday.length; j++) {
            queueSat.add(_itemsSaturday[j]);
          }

          _itemsSaturday = queueSat.toList();
          break;
        case 6:
          final data = await TimetableDatabase.getData("Sunday");
          _itemsSunday = data
              .map(
                (tt) => TimeTable(
                  title: tt["title"],
                  description: tt["description"],
                  id: tt["id"],
                  fromTimeOfDay: TimeOfDay(
                      hour: DateTime.parse(tt["fromTime"] as String).hour,
                      minute: DateTime.parse(tt["fromTime"] as String).minute),
                  toTimeOfDay: TimeOfDay(
                      hour: DateTime.parse(tt["toTime"] as String).hour,
                      minute: DateTime.parse(tt["toTime"] as String).minute),
                  day: tt["day"],
                  category: TypeCategory.values.elementAt(tt["category"]),
                ),
              )
              .toList();

          queueSun.clear();
          for (int j = 0; j < _itemsSunday.length; j++) {
            queueSun.add(_itemsSunday[j]);
          }

          _itemsSunday = queueSun.toList();
          break;
      }
    }
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
