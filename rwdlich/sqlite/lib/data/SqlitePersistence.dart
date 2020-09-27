/*
 * Copyright (c) 2019 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class SqlitePersistence {
  static const DatabaseName = 'cinephile.db';
  static const MoviesWatchedTableName = 'movieswatched';
  Database db;

  SqlitePersistence._(this.db);

  static Future<SqlitePersistence> create() async =>
      SqlitePersistence._(await database());

  static Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), DatabaseName),
      // 4
      onCreate: (db, version) {
        // 5
        return db.execute(
          '''CREATE TABLE $MoviesWatchedTableName(
           id INTEGER PRIMARY KEY, 
           imdbId INTEGER, 
           name STRING, 
           imageUrl STRING, 
           year STRING, 
           watchedOn INTEGER
        )''',
        );
      },
      // 6
      version: 1,
    );
  }

  Future<List<Map<String, dynamic>>> getUniqueObjects() async {
    final ret = await db.rawQuery(
        'SELECT *, COUNT(*) as watchedTimes FROM $MoviesWatchedTableName group by imdbId');
    return ret;
  }

  Future<List<Map<String, dynamic>>> findObjects(String query) async {
    final ret = await db.rawQuery(
        'SELECT *, COUNT(*) as watchedTimes FROM $MoviesWatchedTableName where name like ? group by imdbId',
        ['%$query%']);
    return ret;
  }

  void createOrUpdateObject(int key, Map<String, dynamic> object) async {
    await db.insert(MoviesWatchedTableName, object,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeObject(int key) async {
    await db.delete(
      MoviesWatchedTableName,
      where: 'id = ?',
      whereArgs: [key],
    );
  }
}
