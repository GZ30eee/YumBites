import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Mydb{
  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'tbl_User');
    return await openDatabase(databasePath);
  }

  Future<bool> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "tbl_User");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data =
      await rootBundle.load(join('assets/database', 'tbl_User'));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
      return true;
    }
    return false;
  }

  Future<List<Map<String, dynamic>>> getDetail() async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> userlist =
    await db.rawQuery('SELECT * FROM User_Table;');
    return userlist;
  }

  Future<void> insertUser(String userName) async {
    Database db = await initDatabase();
    await db.rawInsert('INSERT INTO User_Table(userName) VALUES(?);',[userName]);
  }

  Future<void> editUser(int userId,String newUsername) async {
    Database db=await initDatabase();
    await db.rawUpdate('UPDATE User_Table SET userName=? WHERE userId=?',[newUsername,userId]);
  }

  Future<void> deleteUser(int userId) async{
    Database db=await initDatabase();
    await db.rawDelete('DELETE FROM User_Table WHERE userId=?;',[userId]);
  }
}