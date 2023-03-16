import 'package:flutter/foundation.dart';
import 'package:license/Theory/Model/QuestionModel.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'driverLicense.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute("CREATE TABLE question(id INTEGER PRIMARY KEY, chapterId INTEGER, questionText TEXT, answerIndex INTEGER, questionImage TEXT, answerList TEXT, comment TEXT, selectedIndex INTEGER)");
  }

  Future<void> insertQuestion(QuestionModel question) async {
    // Get a reference to the database.
    final db = await SQLHelper.db();

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'question',
      question.toJson(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  // Read all items (journals)
  static Future<QuestionModel> getQuestion(int id) async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> maps = await db.query('question', where: 'id = ?', whereArgs: [id]);
    return QuestionModel.fromDatabase(maps.first);
  }

  // Update an item by id
  Future<void> updateQuestion(QuestionModel question) async {
    final db = await SQLHelper.db();

    await db.update(
      'question',
      question.toJson(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [question.id],
    );
  }

  // Delete
  static Future<void> deleteQuestion(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete(
          "question",
          where: "id = ?",
          whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}