import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rmcharactersappfluttercupertino/Model/AdaptedCharacter.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'favoritesRev9.sqlite');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS favCharacters (
        characterId TEXT PRIMARY KEY,
        name TEXT,
        image TEXT,
        status TEXT,
        species TEXT,
        gender TEXT,
        origin TEXT,
        location TEXT,
        episodes INTEGER
      )
    ''');
  }

  Future<void> toggleFavorite(AdaptedCharacter character) async {
    final db = await database;
    final count = Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM favCharacters WHERE characterId = ?',
      [character.id],
    ));

    if (count! > 0) {
      await removeFavorite(character);
    } else {
      await addFavorite(character);
    }
  }

  Future<void> addFavorite(AdaptedCharacter character) async {
    final db = await database;
    await db.insert(
      'favCharacters',
      character.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("added favorite: ${character.name}");
  }

  Future<void> removeFavorite(AdaptedCharacter character) async {
    final db = await database;
    await db.delete(
      'favCharacters',
      where: 'characterId = ?',
      whereArgs: [character.id],
    );
    print("removed favorite: ${character.name}");
  }

  Future<List<AdaptedCharacter>> fetchAllFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favCharacters');

    return List.generate(maps.length, (i) {
      return AdaptedCharacter(
        id: maps[i]['characterId'],
        name: maps[i]['name'],
        image: maps[i]['image'],
        status: maps[i]['status'],
        species: maps[i]['species'],
        gender: maps[i]['gender'],
        origin: maps[i]['origin'],
        location: maps[i]['location'],
        episode: maps[i]['episodes'],
      );
    });
  }

  Future<bool> isCharacterInFavorites(String characterId) async {
    final db = await database;
    final count = Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM favCharacters WHERE characterId = ?',
      [characterId],
    ));
    return count! > 0;
  }
}
