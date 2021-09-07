import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class ReminderDatabase{

  static Future<sql.Database> database() async {

    final dpPath = await sql.getDatabasesPath();

    return await sql.openDatabase(path.join(dpPath, 'reminder.db' ), onCreate: (db, version){
      return db.execute("CREATE TABLE reminder(id TEXT PRIMARY KEY, title TEXT, description TEXT, time TEXT, category INT)");
    }, version: 1);

  }

  static Future<void> insert(Map<String, Object> data) async {
    final db = await ReminderDatabase.database();
    await db.insert("reminder", data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await ReminderDatabase.database();
    print("get data ");
    return db.query("reminder", orderBy: 'time ASC');
  }

  static Future<void> update(Map<String, Object> data, String key) async {
    print("update");
    final db = await ReminderDatabase.database();

    db.update("reminder", data, where: "id = ?", whereArgs: [key]);
  }

  static Future<void> delete(String key) async {
    final db = await ReminderDatabase.database();

    db.delete("reminder", where: "id = ?", whereArgs: [key]);
  }
}