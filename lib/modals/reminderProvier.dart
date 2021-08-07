import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class Reminder {
  final String title;
  final String subtitle;
  final String description;
  final DateTime dateTime;
  final key;

  Reminder({required this.title, required this.subtitle, required this.description, required this.dateTime, required this.key});
}


class ReminderProvider extends ChangeNotifier{

  //i have to store basis on of date and time in sorted manner.

  List<Reminder> _items = [];

  var queue = PriorityQueue<Reminder>((a, b) => a.dateTime.compareTo(b.dateTime));


  List<Reminder> get items{
    return [..._items];
  }

  bool _dateTimeCompare(DateTime rem1, DateTime rem2){
    int res = rem1.compareTo(rem2);

    if(res == 1){
      return true;
    }

    return false;
  }


  void addReminder({required String title, required String subtitle, required String description, required DateTime dateTime}){

     queue.add(Reminder(title: title, subtitle: subtitle, description: description, dateTime: dateTime, key: dateTime.toString()));

     _items = queue.toList();

     notifyListeners();
     printQueue();

  }

  void updateReminder({required String title, required String subtitle, required String description, required DateTime dateTime, required String key}){

    final Reminder rem = _items.firstWhere((reminder) => reminder.key == key);

    queue.remove(rem);

    queue.add(Reminder(title: title, subtitle: subtitle, description: description, dateTime: dateTime, key: dateTime.toString()));

    _items = queue.toList();

    notifyListeners();

  }

  void printQueue(){
    List<Reminder> temp = _items;
    for(int i=0; i<temp.length; i++){
      print(temp[i].dateTime);
    }
  }

}