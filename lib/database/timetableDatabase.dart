import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class TimetableDatabase{

  static Future<sql.Database> database() async {

    final dpPath = await sql.getDatabasesPath();

    return await sql.openDatabase(path.join(dpPath, 'timetable.db' ), onCreate: (db, version) async {
      await  db.execute("CREATE TABLE monday(id TEXT PRIMARY KEY, title TEXT, description TEXT, toTime TEXT, fromTime TEXT, day TEXT, category INT)");
      await db.execute("CREATE TABLE tuesday(id TEXT PRIMARY KEY, title TEXT, description TEXT, toTime TEXT, fromTime TEXT, day TEXT,category INT)");
      await db.execute("CREATE TABLE wednesday(id TEXT PRIMARY KEY, title TEXT, description TEXT, toTime TEXT, fromTime TEXT, day TEXT,category INT)");
      await db.execute("CREATE TABLE thursday(id TEXT PRIMARY KEY, title TEXT, description TEXT, toTime TEXT, fromTime TEXT, day TEXT,category INT)");
      await db.execute("CREATE TABLE friday(id TEXT PRIMARY KEY, title TEXT, description TEXT, toTime TEXT, fromTime TEXT, day TEXT,category INT)");
      await db.execute("CREATE TABLE saturday(id TEXT PRIMARY KEY, title TEXT, description TEXT, toTime TEXT, fromTime TEXT, day TEXT,category INT)");
      await db.execute("CREATE TABLE sunday(id TEXT PRIMARY KEY, title TEXT, description TEXT, toTime TEXT, fromTime TEXT, day TEXT,category INT)");

    }, version: 1);

  }

  static Future<void> insert(Map<String, Object> data, String day) async {
    final db = await TimetableDatabase.database();
    switch(day){
      case "Monday":
        await db.insert("monday", data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
        break;
      case "Tuesday":
        await db.insert("tuesday", data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
        break;
      case "Wednesday":
        await db.insert("wednesday", data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
        break;
      case "Thursday":
        await db.insert("thursday", data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
        break;
      case "Friday":
        await db.insert("friday", data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
        break;
      case "Saturday":
        await db.insert("saturday", data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
        break;
      case "Sunday":
        await db.insert("sunday", data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
        break;
    }

  }

  static Future<List<Map<String, dynamic>>> getData(String day) async {
    final db = await TimetableDatabase.database();

    switch(day){
      case "Monday":
        return db.query("monday", orderBy: 'fromTime ASC');
      case "Tuesday":
        return db.query("tuesday", orderBy: 'fromTime ASC');
      case "Wednesday":
        return db.query("wednesday", orderBy: 'fromTime ASC');
      case "Thursday":
        return db.query("thursday", orderBy: 'fromTime ASC');
      case "Friday":
        return db.query("friday", orderBy: 'fromTime ASC');
      case "Saturday":
        return db.query("saturday", orderBy: 'fromTime ASC');
      case "Sunday":
        return db.query("sunday", orderBy: 'fromTime ASC');
    }

    return [];
  }

  static Future<void> update(Map<String, Object> data, String key, String day) async {
    final db = await TimetableDatabase.database();

    switch(day){
      case "Monday":
        db.update("monday", data, where: "id = ?", whereArgs: [key]);
        break;
      case "Tuesday":
        db.update("tuesday", data, where: "id = ?", whereArgs: [key]);
        break;
      case "Wednesday":
        db.update("wednesday", data, where: "id = ?", whereArgs: [key]);
        break;
      case "Thursday":
        db.update("thursday", data, where: "id = ?", whereArgs: [key]);
        break;
      case "Friday":
        db.update("friday", data, where: "id = ?", whereArgs: [key]);
        break;
      case "Saturday":
        db.update("saturday", data, where: "id = ?", whereArgs: [key]);
        break;
      case "Sunday":
        db.update("sunday", data, where: "id = ?", whereArgs: [key]);
        break;
    }
  }

  static Future<void> delete(String key, String day) async {
    final db = await TimetableDatabase.database();

    switch(day){
      case "Monday":
        db.delete("monday", where: "id = ?", whereArgs: [key]);
        break;
      case "Tuesday":
        db.delete("tuesday", where: "id = ?", whereArgs: [key]);
        break;
      case "Wednesday":
        db.delete("wednesday", where: "id = ?", whereArgs: [key]);
        break;
      case "Thursday":
        db.delete("thursday", where: "id = ?", whereArgs: [key]);
        break;
      case "Friday":
        db.delete("friday", where: "id = ?", whereArgs: [key]);
        break;
      case "Saturday":
        db.delete("saturday", where: "id = ?", whereArgs: [key]);
        break;
      case "Sunday":
        db.delete("sunday", where: "id = ?", whereArgs: [key]);
        break;
    }
  }
}