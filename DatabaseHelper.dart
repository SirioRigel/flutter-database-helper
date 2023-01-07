import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import "package:sqflite/sqflite.dart";

// This class will be used to create the database
class DatabaseHelper{
  // Private constructor;
  DatabaseHelper._constructor();
  static final DatabaseHelper instance = DatabaseHelper._constructor();

  // Gets the database
  static Database? _database;
  Future<Database> get database async => _database ??= await InitializeDatabase();

  // Creates the database using the directory of the app
  Future<Database> InitializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "water.db");

    // Returns the open database
    return await openDatabase(
      path,
      version: 1,
      onCreate: CreateDatabase,
    );
  }

  // Creates the table through a sql string
  Future CreateDatabase(Database db, int version) async {
    await db.execute(""
        " CREATE TABLE table");
  }

  Future<List<Object>> GetTables() async {
    // Grabbing the database from the constructor
    Database db = await instance.database;

    // Here you can retrieve a the table whose values will be converted
    // To the Object type specified in the method declaration
    // It's possible to order it through a set of commands such as
    // groupBy, orderBy, where...
    var objects = await db.query("table", orderBy: "NAME OF PROPERTY");

    // Here we map whatever object we are putting
    // We HAVE TO use the ternary operator, otherwise if the database
    // is empty it will return null, which we don't want.
    List<Object> list = objects.isNotEmpty
      ? objects.toList()
      : [];
    return list;
  }

  Future<List<Map<String, Object?>>> AddObject(Object obj) async {
    // Grabbing the database
    Database db = await instance.database;

    // Return the databse query to
    return await db.query(""
        "INSERT INTO table (column1, column2)"
        "VALUES (value1, value2)");
  }
}