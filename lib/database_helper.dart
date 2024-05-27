import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'dart:io' as io;
import 'dart:async';
import 'employee.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await setDB();
    return _db!;
  }

  DatabaseHelper.internal();

  setDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "employee.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "database", "employee.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

    // Open the database
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE Employee(id INTEGER PRIMARY KEY, name TEXT, profession TEXT)");
    print("Table is created");
  }

  // Insertion
  Future<int> saveEmployee(Employee employee) async {
    var dbClient = await db;
    int res = await dbClient.insert("Employee", employee.toMap());
    return res;
  }

  // Fetching
  Future<List<Employee>> getEmployees() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Employee');
    List<Employee> employees = [];
    for (int i = 0; i < list.length; i++) {
      var employee = new Employee(list[i]["name"], list[i]["profession"]);
      employee.setEmployeeId(list[i]["id"]);
      employees.add(employee);
    }
    return employees;
  }

  // Deletion
  Future<int> deleteEmployee(Employee employee) async {
    var dbClient = await db;
    int res = await dbClient.rawDelete('DELETE FROM Employee WHERE id = ?', [employee.id]);
    return res;
  }

  // Updation
  Future<int> update(Employee employee) async {
    var dbClient = await db;
    int res = await dbClient.update("Employee", employee.toMap(),
        where: "id = ?", whereArgs: <int>[employee.id!]);
    return res;
  }
}
