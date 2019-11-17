import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stadium/model/parameterModel.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Stadium.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
      
      CREATE TABLE Parameters (
          parameterName Text PRIMARY KEY,
          parameterValue TEXT
          )
          ''');
    });
  }

  newParameter(Parameter newParameter) async {
    print('''INSERT Into parameters (parameterName,parameterValue)
       VALUES ('${newParameter.parameterName}','${newParameter.parameterValue}');
       ''');

    final db = await database;

    var res = await db.rawInsert('''

      INSERT OR REPLACE Into parameters (parameterName,parameterValue)
       VALUES ('${newParameter.parameterName}','${newParameter.parameterValue}');
       ''');
    return res;
  }

  getParameter(String parameterName) async {
    final db = await database;
    var res = await db.query("Parameters",
        where: "parameterName = ?", whereArgs: [parameterName]);
    return res.isNotEmpty ? Parameter.fromMap(res.first) : Null;
  }


deleteTable(String tableName) async {
      final db = await database;
    await db.execute('''DELETE FROM '$tableName';''');
    return;
}




}
