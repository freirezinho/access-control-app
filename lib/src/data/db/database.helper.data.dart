import 'package:access_control/src/data/db/dbmodel.data.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:path/path.dart';
import 'package:access_control/src/data/db/meta.data.dart';

class SLDBHelper {

  // Retrieve DB Connection
  static Future<Database> connectDB() async {
    final Database databaseConnection = await openDatabase(
      join( await getDatabasesPath(), '${DBMeta.db_name}.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS ${DBMeta.tb_devices}(id INTEGER PRIMARY KEY, name TEXT, isActive BOOLEAN)',
        );
      },
      version: 1,
    );
    return databaseConnection;
  }

  // Save model
  static Future<void> insert(SLDBModel model) async {
    final db = await connectDB();
    await db.insert(
        model.tbName,
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  // Select single model
  static Future<Map<String, dynamic>> selectOne(String table, {required String where,
  required List<Object?> whereArgs}) async {
    final db = await connectDB();
    var result = await db.query(table, where: where, whereArgs:  whereArgs);
    if (result.length > 0) {
      return result.first;
    }
    throw 'Not found';
  }

  // Select list of models
  static Future<List<Map<String, dynamic>>> selectList(String table) async {
    final db = await connectDB();
    return await db.query(table);
  }

  // Update model
  static Future<void> update(SLDBModel model,{required String where,
      required List<Object?> whereArgs}) async {
    final db = await connectDB();
    await db.update(model.tbName, model.toMap(), where: where, whereArgs: whereArgs);
  }

  // Delete model
  static Future<void> delete(SLDBModel model, {required String where,
    required List<Object?> whereArgs}) async {
    final db = await connectDB();
    await db.delete(model.tbName, where: where, whereArgs: whereArgs);
  }
}