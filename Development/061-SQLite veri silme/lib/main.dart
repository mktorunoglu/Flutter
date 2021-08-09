import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({
    required this.id,
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'doggie_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
      );
    },
    version: 1,
  );

  Future<void> insertDog(Dog dog) async {
    final db = await database;

    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Dog>> dogs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('dogs');

    return List.generate(
      maps.length,
      (i) {
        return Dog(
          id: maps[i]['id'],
          name: maps[i]['name'],
          age: maps[i]['age'],
        );
      },
    );
  }

  Future<void> updateDog(Dog dog) async {
    final db = await database;

    await db.update(
      'dogs',
      dog.toMap(),
      where: 'id = ?',
      whereArgs: [dog.id],
    );
  }

  Future<void> deleteDog(int id) async {
    final db = await database;

    await db.delete(
      'dogs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  var fido = Dog(
    id: 0,
    name: 'Fido',
    age: 35,
  );

  var dogi = Dog(
    id: 1,
    name: 'Dogi',
    age: 5,
  );

  await insertDog(fido);
  await insertDog(dogi);
  print("Insert:");
  print(await dogs());

  fido = Dog(
    id: fido.id,
    name: fido.name,
    age: fido.age + 7,
  );

  await updateDog(fido);
  print("Update:");
  print(await dogs());

  await deleteDog(dogi.id);
  print("Delete:");
  print(await dogs());
}
