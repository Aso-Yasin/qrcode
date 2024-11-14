import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'qr_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE qr_history (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            type TEXT,
            data TEXT,
            timestamp TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertQRCode(String type, String data) async {
    try {
      final db = await database;
      await db.insert('qr_history', {
        'type': type,
        'data': data,
        'timestamp': DateTime.now().toIso8601String()
      });
      print('Successfully inserted into database');
    } catch (e) {
      print('Database insert error: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getHistory() async {
    final db = await database;
    return await db.query('qr_history', orderBy: 'timestamp DESC');
  }
}
