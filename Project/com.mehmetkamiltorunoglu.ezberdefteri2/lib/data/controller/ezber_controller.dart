import 'package:ezberdefteri2/data/model/ezber_model.dart';
import 'package:ezberdefteri2/screen/kategoriler_ekrani.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class EzberController extends ChangeNotifier {
  Future<Database> returnDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'ezberler.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE ezberler(id INTEGER PRIMARY KEY, kategoriId INTEGER, ezberlendi INTEGER, ezber TEXT, anlam TEXT)',
        );
      },
      version: 1,
    );
    notifyListeners();
    return database;
  }

  void incrementId() async {
    final prefs = await SharedPreferences.getInstance();
    id = (prefs.getInt('id') ?? 0) + 1;
    prefs.setInt('id', id);
  }

  Future<void> ezberEkle(int id, int kategoriId, int ezberlendi, String ezberr,
      String anlam) async {
    Ezber ezber = Ezber(
        id: id,
        kategoriId: kategoriId,
        ezberlendi: ezberlendi,
        ezber: ezberr,
        anlam: anlam);
    final db = await returnDatabase();
    await db.insert('ezberler', ezber.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    notifyListeners();
  }

  Future<void> ezberSil(int silinecekId) async {
    final db = await returnDatabase();
    await db.delete(
      'ezberler',
      where: 'id = ?',
      whereArgs: [silinecekId],
    );
    notifyListeners();
  }

  Future<void> ezberGuncelle(Ezber ezber) async {
    final db = await returnDatabase();
    await db.update(
      'ezberler',
      ezber.toMap(),
      where: 'id = ?',
      whereArgs: [ezber.id],
    );
    notifyListeners();
  }

  Future<List<Ezber>> ezberListele(int kategoriId, int ezberlendi) async {
    final db = await returnDatabase();
    final List<Map<String, dynamic>> maps = await db.query('ezberler',
        where: '"kategoriId" = ? and "ezberlendi" = ?',
        whereArgs: [kategoriId, ezberlendi]);
    List<Ezber> ezberList = List.generate(
      maps.length,
      (i) {
        return Ezber(
          id: maps[i]['id'],
          kategoriId: maps[i]['kategoriId'],
          ezberlendi: maps[i]['ezberlendi'],
          ezber: maps[i]['ezber'],
          anlam: maps[i]['anlam'],
        );
      },
    );
    notifyListeners();
    return ezberList;
  }

  Future<void> tumEzberleriTasi(int kategoriId) async {
    final db = await returnDatabase();
    List<Ezber> ezberlendiList = await ezberListele(kategoriId, 0);
    for (int i = 0; i < ezberlendiList.length; i++) {
      Ezber ezber = ezberlendiList[i];
      int eskiId = ezberlendiList[i].id;
      incrementId();
      ezber.id = id;
      ezber.ezberlendi = 1;
      await db.update(
        'ezberler',
        ezber.toMap(),
        where: 'id = ?',
        whereArgs: [eskiId],
      );
    }
    notifyListeners();
  }

  Future<void> tumEzberlenenleriGeriYukle(int kategoriId) async {
    final db = await returnDatabase();
    List<Ezber> ezberlendiList = await ezberListele(kategoriId, 1);
    for (int i = 0; i < ezberlendiList.length; i++) {
      Ezber ezber = ezberlendiList[i];
      int eskiId = ezberlendiList[i].id;
      incrementId();
      ezber.id = id;
      ezber.ezberlendi = 0;
      await db.update(
        'ezberler',
        ezber.toMap(),
        where: 'id = ?',
        whereArgs: [eskiId],
      );
    }
    notifyListeners();
  }

  Future<void> tumEzberlenenleriSil(int kategoriId) async {
    final db = await returnDatabase();
    List<Ezber> ezberlendiList = await ezberListele(kategoriId, 1);
    for (int i = 0; i < ezberlendiList.length; i++) {
      await db.delete(
        'ezberler',
        where: 'id = ?',
        whereArgs: [ezberlendiList[i].id],
      );
    }
    notifyListeners();
  }

  Future<void> tumEzberleriSil(int kategoriId) async {
    final db = await returnDatabase();
    List<Ezber> ezberList = await ezberListele(kategoriId, 0);
    for (int i = 0; i < ezberList.length; i++) {
      await db.delete(
        'ezberler',
        where: 'id = ?',
        whereArgs: [ezberList[i].id],
      );
    }
    tumEzberlenenleriSil(kategoriId);
    notifyListeners();
  }
}
