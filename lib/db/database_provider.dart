import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:workout_app/db/models/dog.dart';
import 'package:workout_app/db/models/calendarEvent.dart';

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

  Future<List<calendarEvent>> getList() async {
    Database db = await this.db;

    var calendarEvents = await db.query('CalendarEvent', orderBy: 'dateTime');
    List<calendarEvent> calendarEventsList = calendarEvents.isNotEmpty?
      calendarEvents.map((d) => calendarEvent.fromMap(d)).toList() : [];
    return calendarEventsList;
  }

  Future<int> add (calendarEvent calendarevent) async {
    Database db = await this.db;
    print('Data Inserted');
    return await db.insert('CalendarEvent', calendarevent.toMap());
  }

  Future<int> remove (int id) async {
    Database db = await this.db;
    return await db.delete('CalendarEvent', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateData (calendarEvent calendarevent) async {
    Database db = await this.db;
    return await db.rawUpdate(
        'UPDATE CalendarEvent SET workoutPacket = ? WHERE dateTime = ?',
        [calendarevent.workoutPacket, calendarevent.dateTime]);
  }

  Future<void> createTable ()async{
    Database db = await this.db;
    await db.execute("CREATE TABLE CalendarEvent (id INTEGER PRIMARY KEY AUTOINCREMENT, dateTime TEXT, workoutPacket TEXT)");
  }

  Future<void> dropTable ()async{
    Database db = await this.db;
    await db.execute("DROP TABLE IF EXISTS CalendarEvent");
  }
}