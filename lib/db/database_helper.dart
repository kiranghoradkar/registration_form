import 'dart:async';
import 'package:path/path.dart';
import 'package:registration_form/models/user_details.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static const dbName = 'myDataBase.db';
  static const dbVersion = 1;

  // late Database database;

  DataBaseHelper._privateConstructor();

  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  static Database? dataBase;

  Future<Database> get database async {
    if (dataBase != null) return dataBase!;
    dataBase = await initializeDataBase();
    return dataBase!;
  }

  initializeDataBase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: createDB);
  }

  FutureOr<void> createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    await db.execute('''CREATE TABLE $userTable(${UserFields.id} $idType,
    ${UserFields.firstName} $textType,
    ${UserFields.lastName} $textType,
    ${UserFields.phoneNumber} $textType,
    ${UserFields.emailAddress} $textType,
    ${UserFields.gender} $textType,
    ${UserFields.education} $textType,
    ${UserFields.passingYear} $textType,
    ${UserFields.percentage} $textType,
    ${UserFields.experience} $textType,
    ${UserFields.designation} $textType,
    ${UserFields.address} $textType,
    ${UserFields.state} $textType,
    ${UserFields.password} $textType,
    ${UserFields.profilePic} BLOB)''');
  }

  Future<UserDetails> create(UserDetails userDetails) async {
    final db = await instance.database;
    await db.insert(userTable, userDetails.toJson());
    return userDetails;
  }

  Future<List<UserDetails>> readAllUser() async {
    final db = await instance.database;
    final result = await db.query(userTable);
    List<UserDetails> list =
        result.map((json) => UserDetails.fromJson(json)).toList();
    return list;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
