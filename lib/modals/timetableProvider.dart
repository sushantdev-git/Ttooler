import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class TimeTable{

  final String title;
  final String description;
  final TimeOfDay fromTimeOfDay;
  final TimeOfDay toTimeOfDay;
  final String key;
  final String day;

  TimeTable({required this.title, required this.description, required this.fromTimeOfDay , required this.toTimeOfDay,  required this.key, required this.day});
}


class TimeTableProvider extends ChangeNotifier{

  List<TimeTable> _itemsMonday = [];
  List<TimeTable> _itemsTuesday = [];
  List<TimeTable> _itemsWednesday = [];
  List<TimeTable> _itemsThursday = [];
  List<TimeTable> _itemsFriday = [];
  List<TimeTable> _itemsSaturday = [];
  List<TimeTable> _itemsSunday = [];

  var queueMon = PriorityQueue<TimeTable>((a, b) => compareTime(a.fromTimeOfDay, b.fromTimeOfDay));
  var queueTue = PriorityQueue<TimeTable>((a, b) => compareTime(a.fromTimeOfDay, b.fromTimeOfDay));
  var queueWed = PriorityQueue<TimeTable>((a, b) => compareTime(a.fromTimeOfDay, b.fromTimeOfDay));
  var queueThr = PriorityQueue<TimeTable>((a, b) => compareTime(a.fromTimeOfDay, b.fromTimeOfDay));
  var queueFri = PriorityQueue<TimeTable>((a, b) => compareTime(a.fromTimeOfDay, b.fromTimeOfDay));
  var queueSat = PriorityQueue<TimeTable>((a, b) => compareTime(a.fromTimeOfDay, b.fromTimeOfDay));
  var queueSun = PriorityQueue<TimeTable>((a, b) => compareTime(a.fromTimeOfDay, b.fromTimeOfDay));


  PriorityQueue<TimeTable> whichQueue(String whichDay){

    if(whichDay == "M"){
      return queueMon;
    }

    return queueSun;
  }

  int combineHourAndMin(TimeOfDay A){
    return int.parse(A.hour.toString()+A.minute.toString());
  }

  List<int> checkOverlapping({required TimeOfDay fromTime, required TimeOfDay toTime, required String day}){
    List<TimeTable> times = getListOfTimeTable(day);

    if(times.length == 0){
      return [-1];
    }

    List<int> overlappingIndexes = [];
    for(int i=0; i<times.length; i++){
      if(combineHourAndMin(fromTime) < combineHourAndMin(times[i].fromTimeOfDay)){
        if(combineHourAndMin(toTime) < combineHourAndMin(times[i].fromTimeOfDay)){
          return [-1];
        }
        else{
          overlappingIndexes.add(i);
        }
      }
      else if(combineHourAndMin(fromTime) > combineHourAndMin(times[i].fromTimeOfDay)){
        if(combineHourAndMin(fromTime) < combineHourAndMin(times[i].toTimeOfDay)){
          overlappingIndexes.add(i);
        }
      }
    }
    return overlappingIndexes;
  }

  bool add({required String title,required String description, required TimeOfDay fromTimeOfDay, required TimeOfDay toTimeOfDay, required String whichDay , required List<int> overlappingIndexes}){

    if(whichDay == "Monday"){
      for(int i=0; i<overlappingIndexes.length; i++){
        queueMon.remove(_itemsMonday[overlappingIndexes[i]]);
      }
      queueMon.add(TimeTable(title: title, description: description, fromTimeOfDay: fromTimeOfDay, toTimeOfDay: toTimeOfDay, key: fromTimeOfDay.toString(), day: whichDay));
      _itemsMonday = queueMon.toList();
      printQueue(_itemsMonday);
      notifyListeners();
    }
    else if(whichDay == "Tuesday"){
      queueTue.add(TimeTable(title: title, description: description, fromTimeOfDay: fromTimeOfDay, toTimeOfDay: toTimeOfDay, key: fromTimeOfDay.toString(), day: whichDay));
      _itemsTuesday = queueTue.toList();
      notifyListeners();
    }
    else if(whichDay == "Wednesday"){
      queueWed.add(TimeTable(title: title, description: description,fromTimeOfDay: fromTimeOfDay, toTimeOfDay: toTimeOfDay, key: fromTimeOfDay.toString(),day: whichDay));
      _itemsWednesday = queueWed.toList();
      notifyListeners();
    }
    else if(whichDay == "Thursday"){
      queueThr.add(TimeTable(title: title, description: description, fromTimeOfDay: fromTimeOfDay, toTimeOfDay: toTimeOfDay, key: fromTimeOfDay.toString(), day: whichDay));
      _itemsThursday = queueThr.toList();
      notifyListeners();
    }
    else if(whichDay == "Friday"){
      queueFri.add(TimeTable(title: title, description: description,fromTimeOfDay: fromTimeOfDay, toTimeOfDay: toTimeOfDay, key: fromTimeOfDay.toString(), day: whichDay));
      _itemsFriday = queueFri.toList();
      notifyListeners();
    }
    else if(whichDay == "Saturday"){
      queueSat.add(TimeTable(title: title, description: description, fromTimeOfDay: fromTimeOfDay, toTimeOfDay: toTimeOfDay, key: fromTimeOfDay.toString(), day: whichDay));
      _itemsSaturday = queueSat.toList();
      notifyListeners();
    }
    else if(whichDay == "Sunday"){
      queueSun.add(TimeTable(title: title, description: description, fromTimeOfDay: fromTimeOfDay, toTimeOfDay: toTimeOfDay, key: fromTimeOfDay.toString(), day: whichDay));
      _itemsSunday = queueSun.toList();
      notifyListeners();
    }

    return true;
  }

  List<TimeTable> getListOfTimeTable(String day){
    switch(day){
      case "Monday":
        return orderTimetable([..._itemsMonday]);
      case "Tuesday":
        return orderTimetable([..._itemsTuesday]);
      case "Wednesday":
        return orderTimetable([..._itemsWednesday]);
      case "Thursday":
        return orderTimetable([..._itemsThursday]);
      case "Friday":
        return orderTimetable([..._itemsFriday]);
      case "Saturday":
        return orderTimetable([..._itemsSaturday]);
      default:
        return orderTimetable([..._itemsSunday]);
    }
  }

  void printQueue(List<TimeTable> temp){

    for(int i=0; i<temp.length; i++){
      print(temp[i].title);
      print(temp[i].description);
      print(temp[i].fromTimeOfDay.toString());
      print(temp[i].key);
    }
  }

  List<TimeTable> orderTimetable(List<TimeTable> time){
    var q = QueueList<TimeTable>();

    for(int i=0; i<time.length; i++){
      q.add(time[i]);
    }
    int n = 0;

    final currentTime = TimeOfDay.now();

    //here i m comparing the first element of queue to current time and if it is less than that, then i move that element to list.
    while(n < time.length){
      if(compareTime(q[0].fromTimeOfDay, currentTime) == -1){
        q.addLast(q.first);
        q.removeFirst();
      }
      else{
        break;
      }
      n++;
    }

    return q.toList();
  }

}


int compareTime(TimeOfDay a, TimeOfDay b){
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