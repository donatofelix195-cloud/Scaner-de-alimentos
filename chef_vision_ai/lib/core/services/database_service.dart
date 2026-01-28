import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'chef_vision.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // Tabla de Inventario
    await db.execute('''
      CREATE TABLE inventario (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        fecha_escaneo TEXT NOT NULL,
        fecha_caducidad TEXT,
        cantidad REAL DEFAULT 1.0,
        unidad TEXT DEFAULT 'unidad'
      )
    ''');

    // Tabla de Usuario (Perfil Encriptado - Simulación)
    await db.execute('''
      CREATE TABLE perfil (
        id INTEGER PRIMARY KEY,
        meta_calorica INTEGER,
        alergias TEXT,
        datos_encriptados BLOB
      )
    ''');
  }

  Future<void> insertarIngrediente(Map<String, dynamic> ingrediente) async {
    final db = await database;
    await db.insert('inventario', ingrediente, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getInventario() async {
    final db = await database;
    return await db.query('inventario', orderBy: 'fecha_caducidad ASC');
  }
}
