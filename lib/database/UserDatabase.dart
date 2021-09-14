import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class UserDatabase{

  static Future<sql.Database> database() async {
    //this method will return database.

    final dbPath = await sql.getDatabasesPath(); //this method will return data base path

    //now if we try to access our data base through path we get, if path exist then we get the access to the database
    //else we will create a new database (and ofc this will be first time our app save something.

    return sql.openDatabase(path.join(dbPath, 'info.db'),onCreate: (db, version){
      return db.execute("CREATE TABLE user_info(id TEXT PRIMARY KEY, username TEXT, image TEXT)");
    }, version: 1);

  }

  static Future<void> insert(String table, Map<String , dynamic> data) async {

    final sqlDb = await UserDatabase.database();

    await sqlDb.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {

    final sqlDb = await UserDatabase.database();

    return sqlDb.query(table); //query method will list of map
  }
}