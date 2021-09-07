import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class TodoDatabase{

  static Future<sql.Database> database() async {

    final dpPath = await sql.getDatabasesPath();
    
    return await sql.openDatabase(path.join(dpPath, 'todo.db' ), onCreate: (db, version){
      return db.execute("CREATE TABLE todo(id TEXT PRIMARY KEY, title TEXT, description TEXT, priority INT, isCompleted BOOLEAN NOT NULL, category INT, time TEXT)");
    }, version: 1);

  }

  static Future<void> insert(Map<String, Object> data) async {
    final db = await TodoDatabase.database();
    await db.insert("todo", data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await TodoDatabase.database();
    print("get data ");
    return db.query("todo");
  }

  static Future<void> update(Map<String, Object> data, String key) async {
    print("update");
    final db = await TodoDatabase.database();

    db.update("todo", data, where: "id = ?", whereArgs: [key]);
  }

  static Future<void> delete(String key) async {
    final db = await TodoDatabase.database();

    db.delete("todo", where: "id = ?", whereArgs: [key]);
  }
}