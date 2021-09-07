import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Notifications {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static MethodChannel platform = MethodChannel('dexterx.dev/flutter_local_notifications_example');

  static Future<void> init() async {
    tz.initializeTimeZones();
    final String? locationName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(locationName!));

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null, macOS: null);

    await _notifications.initialize(initializationSettings);
  }


  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        "channel id",
        "channel name",
        "channel description",
        importance: Importance.max,
        priority: Priority.high,
        // sound: RawResourceAndroidNotificationSound('notf'),
      ),
    );
  }

  static Future showScheduledNotification({
    required int id,
    String? title,
    String? body,
    String? payload,
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
    String? payload,
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


  static tz.TZDateTime _scheduleWeekly(Time time, weekDay){
    tz.TZDateTime scheduleDate = _scheduleDaily(time);
    print("hour");
    print(time.hour);
    print(time.minute);
    print("weekday");
    print(weekDay);
    while(scheduleDate.weekday != weekDay){
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }

    return scheduleDate;
  }




  static Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }



  static int getHashCode(String s){
    int sum = 0;
    for(int i=0; i< min(s.length,20); i++){
      sum+=(s.codeUnitAt(i)*31)%100000007;
    }
    return sum;
  }
}
