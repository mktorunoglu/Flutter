import 'package:ezberdefteri2/data/model/kategori_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class KategoriController extends ChangeNotifier {
  Future<Database> returnDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'kategoriler.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE kategoriler(id INTEGER PRIMARY KEY, kategoriAdi TEXT)',
        );
      },
      version: 1,
    );
    notifyListeners();
    return database;
  }

  Future<void> kategoriEkle(int id, String kategoriAdi) async {
    Kategori kategori = Kategori(id: id, kategoriAdi: kategoriAdi);
    final db = await returnDatabase();
    await db.insert('kategoriler', kategori.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    notifyListeners();
  }

  Future<void> kategoriSil(int silinecekId) async {
    final db = await returnDatabase();
    await db.delete(
      'kategoriler',
      where: 'id = ?',
      whereArgs: [silinecekId],
    );
    notifyListeners();
  }

  Future<void> kategoriGuncelle(Kategori kategori) async {
    final db = await returnDatabase();
    await db.update(
      'kategoriler',
      kategori.toMap(),
      where: 'id = ?',
      whereArgs: [kategori.id],
    );
    notifyListeners();
  }

  Future<List<Kategori>> kategoriListele() async {
    final db = await returnDatabase();
    final List<Map<String, dynamic>> maps = await db.query('kategoriler');
    List<Kategori> kategoriList = List.generate(
      maps.length,
      (i) {
        return Kategori(
          id: maps[i]['id'],
          kategoriAdi: maps[i]['kategoriAdi'],
        );
      },
    );
    notifyListeners();
    return kategoriList;
  }
}
