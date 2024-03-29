import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import "package:sqflite/sqflite.dart";
import 'main.dart';

// This class will be used to create the database
class DatabaseHelper{
  // Private constructor;
  DatabaseHelper._constructor();
  // Static instance
  static final DatabaseHelper instance = DatabaseHelper._constructor();

  // Gets the database
  static Database? _database;
  Future<Database> get database async => _database ??= await InitializeDatabase();

  // Creates the database using the directory of the app, you can call this each time
  // you want to reinitialize the database
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

  // Creates the table through a sql string when the database is firstly initialized
  Future CreateDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE water(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        waterDrunk INTEGER,
        dailyWater INTEGER,
        date TEXT
      )
    ''');
  }

  Future<List<Water>> GetWaterTable() async {
    // Grabbing the database from the constructor
    final db = await instance.database;

    // Here you can retrieve a table whose values will be converted
    // To the Water type specified in the method declaration
    // It's possible to order it through a set of commands such as
    // groupBy, orderBy, where...
    final maps = await db.query("water", orderBy: "id");

    // Here generate the list of objects from the list of maps
    return List.generate(maps.length, (i) {
      return Water.fromMap(maps[i]);
    });
  }

  //Adds an object to database
  Future AddWater(Water wtr) async {
    // Grabbing the database
    Database db = await instance.database;

    // We map the object and insert it into the database
    return await db.insert("water", wtr.toMap());
  }

  // Remove an object from a specific table in the database
  Future<int> RemoveWater(int id) async {
    // Grabbing the database
    Database db = await instance.database;

    // We remove an object calling .delete, the '?' is a placeholder
    // which will be replaced at runtime by whereArgs
    return await db.delete("water", where: "id = ?", whereArgs: [id]);
  }

  // Update an object in the database
  Future<int> UpdateWater(Water wtr, int id) async {
    // Grabbing the database
    final db = await instance.database;
    final map = wtr.toMap();

    // Updating an object into the database at a specific index
    return await db.update(
      "water",
      map,
      where: "id = ?",
      whereArgs: [id]
    );
  }

  // Deletes the table
  Future DeleteTable(String name) async{
    // Grabbing the database
    Database db = await instance.database;
    // Deletes a table with a specific name
    return await db.execute("DROP TABLE $name");
  }
  
  // Clears a table eliminating all rows while maintaining the table structure intact
  Future ClearTable(String name) async {
    // Grabbing the database
    Database db = await instance.database;

    // Clears a table
    return await db.execute("DELETE FROM $name");
  }
}

class Water {

  // Class values
  final int? id;
  final int? waterDrunk;
  final int? dailyWater;
  final String? date;
  DateTime dateTime() => DateTime.parse(this.date!);

  // Class constructor
  Water({
    this.id,
    required this.waterDrunk,
    required this.dailyWater,
    required this.date,
  });

  // We need to convert the map returned from the swl call to an
  // of type Water.
  factory Water.fromMap(Map<String, dynamic> json,) => Water(
    id: json["id"],
    waterDrunk: json["waterDrunk"],
    dailyWater: json["dailyWater"],
    date: json["date"]
  );

  // We use toMap() to convert an object of type Water to an
  // Object which can be put into the database.
  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "waterDrunk": waterDrunk,
      "dailyWater": dailyWater,
      "date": date
    };
  }
}
