import 'dart:math';

// import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Notifications {
  static final _notifications = FlutterLocalNotificationsPlugin();

  //static MethodChannel platform = MethodChannel('dexterx.dev/flutter_local_notifications_example');

  static Future<bool> init() async {
    tz.initializeTimeZones();
    final String? locationName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(locationName!));

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null, macOS: null);

    await _notifications.initialize(initializationSettings);
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
    await _notifications.getNotificationAppLaunchDetails();
    return notificationAppLaunchDetails!.didNotificationLaunchApp;
  }


  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        "channel id",
        "channel name",
        "channel description",
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('notf'),
      ),
    );
  }

  static Future showScheduledNotification({
    required int id,
    String? title,
    String? body,
    required DateTime scheduleDate,
  }) async =>
      _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduleDate, tz.local),
        await _notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
      );

  static Future showWeeklyNotification({
    required int id,
    String? title,
    String? body,
    required int weekday,
    required Time scheduleTime,
  }) async => _notifications.zonedSchedule(
    id,
    title,
    body,
    _scheduleWeekly(scheduleTime , weekday, ),
    await _notificationDetails(),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
  );


  static tz.TZDateTime _scheduleDaily(Time time){
    final now = tz.TZDateTime.now(tz.local);
    final scheduleDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, time.hour, time.minute, time.second);

    return scheduleDate.isBefore(now) ? scheduleDate.add(Duration(days: 1)) : scheduleDate;
  }


  Future<void> _repeatNotification() async {

    await _notifications.periodicallyShow(
        0,
        'repeating title',
        'repeating body',
        RepeatInterval.everyMinute,
        await _notificationDetails(),
        androidAllowWhileIdle: true
    );
  }




  static tz.TZDateTime _scheduleWeekly (Time time, int weekDay){

    switch(weekDay){
      case 1:
        tz.TZDateTime scheduleDate = _scheduleDaily(time);
        while(scheduleDate.weekday != DateTime.monday){
          scheduleDate = scheduleDate.add(const Duration(days: 1));
        }
        return scheduleDate;

      case 2:
        tz.TZDateTime scheduleDate = _scheduleDaily(time);
        while(scheduleDate.weekday != DateTime.tuesday){
          scheduleDate = scheduleDate.add(const Duration(days: 1));
        }
        return scheduleDate;

      case 3:
        tz.TZDateTime scheduleDate = _scheduleDaily(time);
        while(scheduleDate.weekday != DateTime.wednesday){
          scheduleDate = scheduleDate.add(const Duration(days: 1));
        }
        return scheduleDate;

      case 4:
        tz.TZDateTime scheduleDate = _scheduleDaily(time);
        while(scheduleDate.weekday != DateTime.thursday){
          scheduleDate = scheduleDate.add(const Duration(days: 1));
        }
        return scheduleDate;

      case 5:
        tz.TZDateTime scheduleDate = _scheduleDaily(time);
        while(scheduleDate.weekday != DateTime.friday){
          scheduleDate = scheduleDate.add(const Duration(days: 1));
        }
        return scheduleDate;

      case 6:
        tz.TZDateTime scheduleDate = _scheduleDaily(time);
        while(scheduleDate.weekday != DateTime.saturday){
          scheduleDate = scheduleDate.add(const Duration(days: 1));
        }
        return scheduleDate;

      default:
        tz.TZDateTime scheduleDate = _scheduleDaily(time);
        while(scheduleDate.weekday != DateTime.sunday){
          scheduleDate = scheduleDate.add(const Duration(days: 1));
        }
        return scheduleDate;
    }
  }




  static Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }


  static int getHashCode(String s){
    int sum = 0;
    for(int i=0; i< min(s.length,100); i++){
      sum+=(s.codeUnitAt(i)*31)%100000007;
    }
    print(sum);
    return sum;
  }
}
