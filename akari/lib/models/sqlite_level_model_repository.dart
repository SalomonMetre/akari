import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'level_model.dart';
import 'level_model_repository.dart';

class SQLiteLevelModelRepository implements LevelModelRepository {
  late Database _database;
  static final SQLiteLevelModelRepository _instance =
      SQLiteLevelModelRepository._internal();

  factory SQLiteLevelModelRepository() {
    return _instance;
  }

  SQLiteLevelModelRepository._internal();

  Future<void> initializeDatabase() async {
    final String path = await getDatabasesPath();
    final String databasePath = join(path, 'levels.db');

    _database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE levels(id INTEGER PRIMARY KEY AUTOINCREMENT, level TEXT, gameNo INTEGER, score INTEGER, status INTEGER)',
        );
      },
    );
  }

  @override
  Future<int> insertLevel(LevelModel level) async {
    await initializeDatabase();
    return await _database.insert('levels', level.toJson());
  }

  @override
  Future<List<LevelModel>> getAllLevels() async {
    await initializeDatabase();
    final List<Map<String, dynamic>> maps = await _database.query('levels');
    return List.generate(
      maps.length,
      (index) {
        return LevelModel.fromJson(maps[index]);
      },
    );
  }

  @override
  Future<LevelModel?> getLevelById(int id) async {
    await initializeDatabase();
    final List<Map<String, dynamic>> maps = await _database.query(
      'levels',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) {
      return null;
    }
    return LevelModel.fromJson(maps.first);
  }

  @override
  Future<List<LevelModel>> getLevelsByLevel(String level) async {
  await initializeDatabase();
  final List<Map<String, dynamic>> maps = await _database.query(
    'levels',
    where: 'level = ?',
    whereArgs: [level],
  );
  return List.generate(
    maps.length,
    (index) {
      return LevelModel.fromJson(maps[index]);
    },
  );
}

  @override
  Future<LevelModel?> getLevelByLevelAndGameNo(String level, int gameNo) async {
    await initializeDatabase();
    final List<Map<String, dynamic>> maps = await _database.query(
      'levels',
      where: 'level = ? AND gameNo = ?',
      whereArgs: [level, gameNo],
    );
    if (maps.isEmpty) {
      return null;
    }
    return LevelModel.fromJson(maps.first);
  }

  @override
  Future<int> updateLevel(LevelModel level) async {
    await initializeDatabase();
    return await _database.update(
      'levels',
      level.toJson(),
      where: 'id = ?',
      whereArgs: [level.id],
    );
  }

  @override
  Future<int> deleteLevel(int id) async {
    await initializeDatabase();
    return await _database.delete(
      'levels',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
