import 'package:flutter/foundation.dart';
import 'package:license/Theory/Model/QuestionModel.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<sql.Database> db(String tableName) async {
    return sql.openDatabase(
      'driverLicense.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute("CREATE TABLE questions(id INTEGER PRIMARY KEY, chapterId INTEGER, questionText TEXT, answerIndex INTEGER, questionImage TEXT, answerList TEXT, comment TEXT, selectedIndex INTEGER, testId INTEGER)");
    await database.execute("CREATE TABLE tests(questionOnTestId INTEGER PRIMARY KEY, id INTEGER chapterId INTEGER, questionText TEXT, answerIndex INTEGER, questionImage TEXT, answerList TEXT, comment TEXT, selectedIndex INTEGER, testId INTEGER)");
  }

  Future<void> insertQuestion(QuestionModel question, String tableName) async {
    // Get a reference to the database.
    final db = await SQLHelper.db(tableName);

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      tableName,
      question.toJson(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  // Read all items (journals)
  static Future<QuestionModel> getQuestion(int id, String tableName) async {
    final db = await SQLHelper.db(tableName);
    final List<Map<String, dynamic>> maps = await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    return QuestionModel.fromDatabase(maps.first);
  }

  static Future<QuestionModel> getAllQuestionOnTest(int testId) async {
    const tableName = 'tests';
    final db = await SQLHelper.db(tableName);
    final List<Map<String, dynamic>> maps = await db.query(tableName, where: 'testId = ?', whereArgs: [testId]);
    return QuestionModel.fromDatabase(maps.first);
  }

  static Future<QuestionModel> getQuestionOnTest(int testId, int questionId) async {
    const tableName = 'tests';
    final db = await SQLHelper.db(tableName);
    final List<Map<String, dynamic>> maps = await db.query(tableName, where: 'testId = ? and id = ?', whereArgs: [testId, questionId]);
    return QuestionModel.fromDatabase(maps.first);
  }

  static Future<List<QuestionModel>> getAllQuestion(String tableName) async {
    final db = await SQLHelper.db(tableName);
    final List<Map<String, dynamic>> list = await db.query(tableName);
    return list.map((e) => QuestionModel.fromDatabase(e)).toList();
  }

  // Update an item by id
  Future<void> updateQuestion(QuestionModel question, String tableName) async {
    final db = await SQLHelper.db(tableName);

    await db.update(
      tableName,
      question.toJson(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [question.id],
    );
  }

  // Delete
  static Future<void> deleteQuestion(int id, String tableName) async {
    final db = await SQLHelper.db(tableName);
    try {
      await db.delete(
          tableName,
          where: "id = ?",
          whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}