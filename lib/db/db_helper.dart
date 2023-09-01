import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 2;
  static const String _tableName = "tasks";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = '${await getDatabasesPath()}/tasks.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print("Create a new one");
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title STRING, "
            "note TEXT, "
            "date STRING, "
            "startTime STRING, "
            "imageUrls TEXT, "
            "imageUrl TEXT, "
            "todo TEXT, "
            "repeat STRING, "
            "isCompleted INTEGER)",
          );
        },
        onUpgrade: (db, oldVersion, newVersion) {
          if (oldVersion < 3) {
            // Perform migration here
            db.execute("ALTER TABLE $_tableName ADD COLUMN imageUrls TEXT");
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    print("insert function called");
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    try {
      print("Query function called");
      return await _db?.query(_tableName) ?? [];
    } catch (e) {
      print("Error querying the database: $e");
      return [];
    }
  }

  static delete(Task task) async {
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate('''
UPDATE tasks
SET isCompleted = ?
WHERE id=?
''', [1, id]);
  }
}
