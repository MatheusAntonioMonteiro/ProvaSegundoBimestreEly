import 'dart:async';
import 'package:calculoIMC/pessoa.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  DatabaseHelper.internal();
  
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }
  
  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE imc(id INTEGER PRIMARY KEY, nome TEXT, peso REAL, altura REAL, imc REAL)');
  }

  Future<int> inserirPessoa(Pessoa pessoa) async {
    var dbClient = await db;
    var result = await dbClient.insert("imc", pessoa.toMap());

    return result;
  }

  Future<List> getPessoas() async {
    var dbClient = await db;
    var result = await dbClient.query("imc", columns: ["id", "nome", "peso", "altura", "imc"]);
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM imc'));
  }

  Future<Pessoa> getPessoa(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query("imc",
        columns: ["id", "nome", "peso", "altura", "imc"], where: 'ide = ?', whereArgs: [id]);
    if (result.length > 0) {
      return new Pessoa.fromMap(result.first);
    }
    return null;
  }
  
  Future<int> deletePessoa(int id) async {
    var dbClient = await db;
    return await dbClient.delete("imc", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updatePessoa(Pessoa pessoa) async {
    var dbClient = await db;
    return await dbClient.update("imc", pessoa.toMap(),
        where: "id = ?", whereArgs: [pessoa.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }


}