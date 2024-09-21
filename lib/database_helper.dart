import 'dart:math';

import 'package:saysongs/tamilconverter.dart';
import 'package:saysongs/tamiltransliterator.dart';
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
    String path = join(await getDatabasesPath(), 'secondfin.db');
    print('Database path: $path');

    if (await databaseExists(path)) {
      print('Database exists at $path');
      return await openDatabase(path);
    } else {
      print('Database does not exist, copying from assets');
      ByteData data = await rootBundle.load('assets/secondfin.db');
      List<int> bytes = data.buffer.asUint8List();
      await File(path).writeAsBytes(bytes);
      return await openDatabase(path);
    }
  }

  Future<List<String>> getVerses(int book, int chapter, String language, {bool convertToUnicode = true}) async {
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
      whereArgs: [book, chapter],
    );

    // Extract the verse text from each result map
    List<String> verses = result.map((map) => map['verse'] as String).toList();

    // Convert to Unicode if needed
    if (convertToUnicode && language == 'Tamil') {
      verses = verses.map((verse) {
        String converted = TamilConverter.convertToUnicode(verse);
        return converted;
      }).toList();
    }

    return verses;
  }

  // Method to get song titles starting with a specific alphabet
  Future<List<Map<String, dynamic>>> getSongTitlesByAlphabet(String alphabet) async {
    final db = await database;
    print("fffffffff");
    final List<Map<String, dynamic>> result = await db.query(
      'songlyrics',
      where: 'heading LIKE ?',
      whereArgs: ['${alphabet}%'],
      orderBy: 'heading',
    );
    result.forEach((row) => print(row['heading']));
    return result; // This will return a list of maps with song_id and song_title
  }

  // Method to get Tamil text by song ID
  Future<String?> getTamilTextBySongId(int songId,String language) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'songlyrics',
      where: 'id = ?',
      whereArgs: [songId],
    );

    if (result.isNotEmpty&&language=='Tamil') {
      print(result);
      return TamilConverter.convertToUnicode(result.first['lyrics_html']) as String?;
    }
    else if(result.isNotEmpty&&language=='English')
    {
      print("hihihi");
      var t= TamilTransliterator();
      return t.transliterate(TamilConverter.convertToUnicode(result.first['lyrics_html'])) as String?;
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
    print(result);
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


    if (result.isNotEmpty&&lang==0) {
      return result.first['song_lyrics'] as String?;
    }
    else if (result.isNotEmpty&&lang==1)
      {
          var t= TamilTransliterator();
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
  // Method to fetch verse based on occasion if the date matches
  Future<Map<String, dynamic>?> getVerseForOccasion() async {
    final db = await database;
    DateTime today = DateTime.now();
    String occasion = checkSpecialOccasion(today);

    if (occasion.isNotEmpty) {
      // Fetch the verse for the special occasion from the promiseverse table
      final List<Map<String, dynamic>> verseResult = await db.query(
        'promiseverse',
        where: 'Occasion = ? AND Used = 0',
        whereArgs: [occasion],
      );

      if (verseResult.isNotEmpty) {
        // Pick a random verse for the occasion
        Random random = Random();
        int randomIndex = random.nextInt(verseResult.length);
        Map<String, dynamic> selectedVerse = verseResult[randomIndex];

        // Mark the selected verse as used
        await db.update(
          'promiseverse',
          {'Used': 1},
          where: 'SrNo = ?',
          whereArgs: [selectedVerse['SrNo']],
        );

        return selectedVerse;
      }
    }

    return null; // No verse found for the occasion
  }

  // Helper method to check if today's date matches any special occasion
  String checkSpecialOccasion(DateTime today) {
    // Define special dates (example uses exact dates for simplicity)
    final newYear = DateTime(today.year, 1, 1);
    final ashWednesday = calculateAshWednesday(today.year); // Calculate based on year
    final palmSunday = calculatePalmSunday(today.year); // Calculate based on year
    final maundyThursday = calculateMaundyThursday(today.year); // Calculate based on year
    final goodFriday = calculateGoodFriday(today.year); // Calculate based on year
    final easterSunday = calculateEasterSunday(today.year); // Calculate based on year
    final independenceDayIndia = DateTime(today.year, 8, 15);
    final independenceDayIsrael = DateTime(today.year, 4, 18); // Example date
    final christmasStart = DateTime(today.year, 12, 20);
    final christmasEnd = DateTime(today.year, 12, 25);

    // Check if the current date matches any special occasion
    if (today.isAtSameMomentAs(newYear)) return "New Year Blessing";
    if (today.isAtSameMomentAs(ashWednesday)) return "Ash Wednesday";
    if (today.isAtSameMomentAs(palmSunday)) return "Palm Sunday";
    if (today.isAtSameMomentAs(maundyThursday)) return "Maundy Thursday";
    if (today.isAtSameMomentAs(goodFriday)) return "Good Friday";
    if (today.isAtSameMomentAs(easterSunday)) return "Easter";
    if (today.isAfter(christmasStart) && today.isBefore(christmasEnd.add(Duration(days: 1)))) return "Christmas";
    if (today.isAtSameMomentAs(independenceDayIndia)) return "Independence Day India";
    if (today.isAtSameMomentAs(independenceDayIsrael)) return "Independence Day Israel";

    return ""; // No special occasion
  }

  // Calculate Easter Sunday based on the year
  DateTime calculateEasterSunday(int year) {
    // Calculation of the date for Easter Sunday based on algorithms like Meeus/Jones/Butcher algorithm
    int a = year % 19;
    int b = (year / 100).floor();
    int c = year % 100;
    int d = (b / 4).floor();
    int e = b % 4;
    int f = ((b + 8) / 25).floor();
    int g = ((b - f + 1) / 3).floor();
    int h = (19 * a + b - d - g + 15) % 30;
    int i = (c / 4).floor();
    int k = c % 4;
    int l = (32 + 2 * e + 2 * i - h - k) % 7;
    int m = ((a + 11 * h + 22 * l) / 451).floor();
    int month = ((h + l - 7 * m + 114) / 31).floor();
    int day = ((h + l - 7 * m + 114) % 31) + 1;

    // Return a DateTime object representing Easter Sunday
    return DateTime(year, month, day);
  }


  DateTime calculateAshWednesday(int year) {
    // Ash Wednesday is 46 days before Easter Sunday
    return calculateEasterSunday(year).subtract(Duration(days: 46));
  }


  DateTime calculatePalmSunday(int year) {
    // Palm Sunday is 7 days before Easter
    return calculateEasterSunday(year).subtract(Duration(days: 7));
  }

  DateTime calculateMaundyThursday(int year) {
    // Maundy Thursday is 3 days before Easter
    return calculateEasterSunday(year).subtract(Duration(days: 3));
  }

  DateTime calculateGoodFriday(int year) {
    // Good Friday is 2 days before Easter
    return calculateEasterSunday(year).subtract(Duration(days: 2));
  }

  // Method to fetch a random unused verse if no occasion is found
  Future<Map<String, dynamic>?> getRandomUnusedVerse() async {
    final db = await database;

    // Fetch a random unused verse from the promiseverse table directly using SQL
    final List<Map<String, dynamic>> randomUnusedVerse = await db.rawQuery(
        '''
    SELECT * FROM promiseverse
    WHERE Used = 0
    ORDER BY RANDOM()
    LIMIT 1
    '''
    );
    print(randomUnusedVerse);
    if (randomUnusedVerse.isEmpty) {
      return null; // If no unused verses are available, return null
    }

    // Extract the random verse
    Map<String, dynamic> randomPromiseVerse = randomUnusedVerse.first;

    // Increment the BookIndex by 1 to match the `book` index in the engbible table
    int book = randomPromiseVerse['BookIndex']-1;
    int chapter = randomPromiseVerse['Chapter'];
    int verseNumber = randomPromiseVerse['Verse'];

    // Fetch the corresponding verse from the engbible table
    final List<Map<String, dynamic>> verseResult = await db.query(
      'engbible',
      where: 'book = ? AND chapter = ? AND versecount = ?',
      whereArgs: [book, chapter, verseNumber],
    );
    print(verseResult);
    if (verseResult.isNotEmpty) {
      // Mark the selected promiseverse as used
      await db.update(
        'promiseverse',
        {'Used': 1},
        where: 'SrNo = ?',
        whereArgs: [randomPromiseVerse['SrNo']],
      );

      // Return the verse text and the other details
      return {
        'Book': randomPromiseVerse['Book'],
        'Chapter': chapter,
        'Verse': verseNumber,
        'VerseText': verseResult.first['verse'], // The verse text from engbible
      };
    } else {
      return null; // If no corresponding verse is found
    }
  }


  // Method to fetch the verse for today
  Future<Map<String, dynamic>?> getDailyVerse() async {
    // Try to get a verse based on today's occasion
    var occasionVerse = await getVerseForOccasion();
    if (occasionVerse != null) {
      return occasionVerse;
    }

    // If no occasion matches, fetch a random unused verse
    return await getRandomUnusedVerse();
  }
}

