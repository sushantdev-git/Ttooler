import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import 'package:ttooler/database/reminderDatabase.dart';
import 'package:ttooler/konstant/konstant.dart';
import 'package:ttooler/notification/notifications.dart';

class Reminder {
  final String title;
  final String description;
  final DateTime dateTime;
  final id;
  final TypeCategory category;

  Reminder({required this.title, required this.description, required this.dateTime, required this.id, required this.category});
}


class ReminderProvider extends ChangeNotifier{

  //i have to store basis on of date and time in sorted manner.

  List<Reminder> _items = [];

  var queue = PriorityQueue<Reminder>((a, b) => a.dateTime.compareTo(b.dateTime));


  List<Reminder> get items{
    return [..._items];
  }

  //at creating of reminder we add it to the notification
  //now we have key of reminder so when we update the notification
  //we get key convert to hashcode and cancel that notification and add new notification at new time.

  void addReminder({required String title, required String description, required DateTime dateTime, required TypeCategory category}) async {
      final now = DateTime.now();
     queue.add(Reminder(title: title, description: description, dateTime: dateTime, id: now.toString(), category: category));

     _items = queue.toList();
      await ReminderDatabase.insert({
        "id": now.toString()+"reminder",
        "title": title,
        "description": description,
        "time": dateTime.toIso8601String(),
        "category": category.index,
      });

      await Notifications.showScheduledNotification(
          id: Notifications.getHashCode(dateTime.toString()+"reminder"),
          title: title,
          body: description.length <= 25 ? description : description.substring(0,15)+"...",
          scheduleDate: dateTime);

     notifyListeners();

  }

  void updateReminder({required String title, required String description, required DateTime dateTime, required String key, required TypeCategory category}) async {
    print(key);
    final Reminder rem = _items.firstWhere((reminder) => reminder.id == key);

    await Notifications.cancelNotification(Notifications.getHashCode(key));
    queue.remove(rem);

    queue.add(Reminder(title: title, description: description, dateTime: dateTime, id: key, category: category));
    await ReminderDatabase.update({
      "id": key,
      "title": title,
      "description": description,
      "time": dateTime.toIso8601String(),
      "category":category.index,
    }, key);

    _items = queue.toList();

    await Notifications.showScheduledNotification(
        id: Notifications.getHashCode(dateTime.toString()+"reminder"),
        title: title,
        body: description.length <= 25 ? description : description.substring(0,15)+"...",
        scheduleDate: dateTime);

    notifyListeners();
  }

  void deleteReminder({required String key, required String where}) async {
    queue.remove(_items.firstWhere((element) => element.id == key));
    _items = queue.toList();
    await ReminderDatabase.delete(key);
    if(where == "main")await Notifications.cancelNotification(Notifications.getHashCode(key));
    notifyListeners();
  }


  Future<void> fetchAndSetData() async {
    final data = await ReminderDatabase.getData();

    print(data);
    _items = data.map((rem) => Reminder(
      title: rem["title"],
      description: rem["description"],
      dateTime: DateTime.parse(rem["time"] as String),
      id: rem["id"],
      category: TypeCategory.values.elementAt(rem["category"]),
    )).toList();

    final now = DateTime.now();
    List<int> indexdel = [];
    for(int i=0; i<_items.length; i++){
      if(_items[i].dateTime.isBefore(now)){
        deleteReminder(key: _items[i].id, where: "timePassed");
        indexdel.add(i);
      }
    }

    for(int i=0; i<indexdel.length; i++){
      _items.removeAt(indexdel[i]);
    }

    queue.clear();
    for(int i=0; i<_items.length; i++){
      queue.add(_items[i]);
    }

    _items = queue.toList();
    notifyListeners();
  }

}