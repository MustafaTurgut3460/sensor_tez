import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notifications.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const realType = 'REAL NOT NULL';

    await db.execute('''
CREATE TABLE notifications (
  id $idType,
  title $textType,
  body $textType,
  date $textType
  )
''');

    await db.execute('''
CREATE TABLE sensor_data (
  id $idType,
  temperature $realType,
  air_quality $realType,
  humidity $realType,
  light $realType,
  watt $realType
  )
''');
  }

  Future<void> deleteOldestRecords(String tableName, int limit) async {
    final db = await instance.database;
    await db.delete(
      tableName,
      where: 'id IN (SELECT id FROM $tableName ORDER BY id ASC LIMIT ?)',
      whereArgs: [limit],
    );
  }

  Future<void> maintainTableSize(
      String tableName, int maxSize, int deleteSize) async {
    final db = await instance.database;
    final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableName'));
    if (count != null && count > maxSize) {
      await deleteOldestRecords(tableName, deleteSize);
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
