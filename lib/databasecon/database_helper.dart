import 'dart:math';
import 'package:intl/intl.dart';
import 'package:saysongs/langutils/tamilconverter.dart';
import 'package:saysongs/langutils/tamiltransliterator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'fo.db');
    // print('Database path: $path');

    if (await databaseExists(path)) {
      // print('Database exists at $path');
      return await openDatabase(path);
    } else {
      // print('Database does not exist, copying from assets');
      ByteData data = await rootBundle.load('assets/fo.db');
      List<int> bytes = data.buffer.asUint8List();
      await File(path).writeAsBytes(bytes);
      return await openDatabase(path);
    }
  }

  Future<List<String>> getVerses(int book, int chapter, String language,
      {bool convertToUnicode = true}) async {
    final db = await database;
    String tableName;

    // Determine the table name based on the language
    if (language == 'English') {
      tableName = 'engbible';
    } else {
      tableName = 'tambible';
    }

    final List<Map<String, dynamic>> result = await db.query(
      tableName,
      where: 'book = ? AND chapter = ?',
      whereArgs: [book+1, chapter],
    );

    // Extract the verse text from each result map
    List<String> verses = result.map((map) => map['verse'] as String).toList();

    // Convert to Unicode if needed
    print(verses);

    return verses;
  }

  // Method to get song titles starting with a specific alphabet
  Future<List<Map<String, dynamic>>> getSongTitlesByAlphabet(
      String alphabet) async {
    final db = await database;
    // print("fffffffff");
    final List<Map<String, dynamic>> result = await db.query(
      'songlyrics',
      where: 'heading LIKE ?',
      whereArgs: ['${alphabet}%'],
      orderBy: 'heading',
    );
    // result.forEach((row) => print(row['heading']));
    return result; // This will return a list of maps with song_id and song_title
  }

  // Method to get Tamil text by song ID
  Future<String?> getTamilTextBySongId(int songId, String language) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'songlyrics',
      where: 'id = ?',
      whereArgs: [songId],
    );

    if (result.isNotEmpty && language == 'Tamil') {
      // print(result);
      return TamilConverter.convertToUnicode(
          result.first['lyrics_html']) as String?;
    }
    else if (result.isNotEmpty && language == 'English') {
      // print("hihihi");
      var t = TamilTransliterator();
      return t.transliterate(TamilConverter.convertToUnicode(
          result.first['lyrics_html'])) as String?;
    }
    return null;
  }

  // Method to get all song titles from tsatamsong_titles table
  Future<List<Map<String, dynamic>>> getAllSongTitles() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'tsatamsong_titles',
      orderBy: 'song_title',
    );

    return result; // This will return a list of maps with songid and song_title
  }

  Future<List<Map<String, dynamic>>> getAllEngSongTitles() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'lyrics',
      orderBy: 'heading',
    );
    // print(result);
    return result; // This will return a list of maps with songid and song_title
  }

  // Method to get lyrics by song ID from tsatamsong_lyrics table
  Future<String?> getLyricsBySongId(int songId, int lang) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'tsatamsong_lyrics',
      where: 'songid = ?',
      whereArgs: [songId],
    );


    if (result.isNotEmpty && lang == 0) {
      return result.first['song_lyrics'] as String?;
    }
    else if (result.isNotEmpty && lang == 1) {
      var t = TamilTransliterator();
      return t.transliterate(result.first['song_lyrics']) as String?;
    }
    return null;
  }

  Future<String?> getEngLyricsBySongId(int songId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'lyrics',
      where: 'song = ?',
      whereArgs: [songId],
    );


    return result.first['lyrics'] as String?;
    print(result);
  }

  // Method to get a random row from the promiseversedaily table
  Future<Map<String, dynamic>?> fetchRandomVerseAndUpdateDate() async {
    final db = await database;

    // Get today's date formatted as ddMMyyyy
    String todayDate = DateFormat('ddMMyyyy').format(DateTime.now());

    // Check if there's already a row with today's date
    final List<Map<String, dynamic>> existingDateResult = await db.rawQuery('''
    SELECT * FROM promiseversedaily WHERE Date = ?
  ''', [todayDate]);

    if (existingDateResult.isNotEmpty) {
      return existingDateResult.first; // Return today's verse if it exists
    }

    // Reset all dates to null for entries that are not null
    int rowsAffected = await db.update(
      'promiseversedaily',
      {'Date': null},
      where: 'Date IS NOT NULL',
    );

    // Get a random verse that has not been assigned a date
    final List<Map<String, dynamic>> randomVerseResult = await db.rawQuery('''
    SELECT * FROM promiseversedaily WHERE Date IS NULL ORDER BY RANDOM() LIMIT 1
  ''');

    if (randomVerseResult.isNotEmpty) {
      Map<String, dynamic> randomVerse = randomVerseResult.first;

      // Update the specific row with today's date
      await db.update(
        'promiseversedaily',
        {'Date': todayDate},
        where: 'Srno = ?',
        whereArgs: [randomVerse['Srno']],
      );

      return randomVerse; // Return the fetched random verse
    }

    return null; // Return null if no random verse was found
  }

  Future<void> updateLastBookAndChapter(String lastBook, int lastChapter) async {
    final db = await DatabaseHelper().database;

    // Update Lastchap in the Userdatas table
    await db.update(
      'Userdatas',
      {'Value': lastChapter.toString()},
      where: 'Param = ?',
      whereArgs: ['Lastchap'],
    );

    // Update Lastbook in the Userdatas table
    await db.update(
      'Userdatas',
      {'Value': lastBook}, // Keep lastBook as a string
      where: 'Param = ?',
      whereArgs: ['Lastbook'],
    );
  }
  Future<Map<String, dynamic>?> fetchLastBookAndChapter() async {
    final db = await DatabaseHelper().database;

    // Initialize a map to hold the results
    Map<String, dynamic> results = {};

    // Fetch Lastbook
    List<Map<String, dynamic>> lastBookResult = await db.query(
      'Userdatas',
      where: 'Param = ?',
      whereArgs: ['Lastbook'],
    );

    if (lastBookResult.isNotEmpty) {
      results['Lastbook'] = lastBookResult.first['Value'] as String;
    } else {
      results['Lastbook'] = null; // Return null if not found
    }

    // Fetch Lastchap
    List<Map<String, dynamic>> lastChapResult = await db.query(
      'Userdatas',
      where: 'Param = ?',
      whereArgs: ['Lastchap'],
    );

    if (lastChapResult.isNotEmpty) {
      results['Lastchap'] = int.tryParse(lastChapResult.first['Value']) ?? null; // Convert to int
    } else {
      results['Lastchap'] = null; // Return null if not found
    }

    return results; // Return the map containing both values
  }

// Method to fetch a random unused verse if no occasion is found
}