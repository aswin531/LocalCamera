// ignore_for: avoid_print

// ignore_for_file: avoid_print, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:camera/model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<CameraModel>> imageListNotifier = ValueNotifier([]);
// void addImage(CameraModel value) {
//   imageListNotifier.value.add(value);
// }

late Database _database;

Future<void> initialiseDataBase() async {
  try {
    _database = await openDatabase(
      'camera.db',
      version: 1,
      onCreate: (db, version) async {
        await db
            .execute('CREATE TABLE camera(id INTEGER PRIMARY KEY, path TEXT)');
      },
    );
    print('DATABASE INITIALISED');
  } catch (e) {
    print('ERROR');
  }
}

Future<void> addImage(CameraModel value) async {
  try {
    await _database.insert('camera', {'path': value.path});
    print('IMAGE INSERTED');
    getImage();
  } catch (e) {
    print('INSERTION ERROR');
  }
}

Future<void> getImage() async {
  final values = await _database.query('camera'); // await here to get the actual result
  print(values);
  imageListNotifier.value.clear();
  for (var map in values) {
    final camera = CameraModel.fromMap(map);
    imageListNotifier.value.add(camera);
  }
  imageListNotifier.notifyListeners();
}

Future<bool> deleteById(int id) async {
  final count = await _database.delete('camera', where: 'id = ?', whereArgs: [id]);
  if (count == 1) {
    await getImage();
    return true;
  } else {
    return false; 
  }
}



