import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:workout_app/db/models/dog.dart';

class dbHelper{
  static final dbHelper instance = dbHelper._instance();
  dbHelper._instance();

  static Database? _db;
  Future<Database> get db async => _db ??= await initDb();

  Future<Database> initDb() async {
    String dbPath = await getDatabasesPath();
    // print('$dbPath');
    return await openDatabase(
        join(dbPath, 'workoutDB.db'),
        version: 1,
        onCreate: _onCreate
    );
  }

  void _onCreate(Database db, int version)async{
    await db.execute('''
      CREATE TABLE dogs(
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        age INTEGER
        )
    ''');
    print('first table  created');
  }

  Future<List<Dog>> getList() async {
    Database db = await this.db;
    var dogs = await db.query('dogs', orderBy: 'name');
    List<Dog> dogList = dogs.isNotEmpty?
      dogs.map((d) => Dog.fromMap(d)).toList() : [];

    return dogList;
  }

  Future<int> add (Dog dog) async {
    Database db = await this.db;
    print('Data Inserted');
    return await db.insert('dogs', dog.toMap());
  }

  Future<int> remove (int id) async {
    Database db = await this.db;
    return await db.delete('dogs', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateData (Dog dog) async {
    Database db = await this.db;
    return await db.update('dogs', dog.toMap(), where: 'id = ?', whereArgs: [dog.id] );
  }

}