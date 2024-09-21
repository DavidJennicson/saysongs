import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'database_helper.dart'; // Import the database helper

class VersesPage extends StatefulWidget {
  final String book;
  final int chapter;

  const VersesPage({Key? key, required this.book, required this.chapter}) : super(key: key);

  @override
  _VersesPageState createState() => _VersesPageState();
}

class _VersesPageState extends State<VersesPage> {
  late Future<List<String>> _versesFuture;
  String _selectedLanguage = 'English'; // Default language

  final List<String> _languages = ['English', 'Tamil']; // Example languages

  @override
  void initState() {
    super.initState();
    _versesFuture = _fetchVerses(_selectedLanguage);
  }

  final Map<String, int> bookIndex = {
    'Genesis': 0,
    'Exodus': 1,
    'Leviticus': 2,
    'Numbers': 3,
    'Deuteronomy': 4,
    'Joshua': 5,
    'Judges': 6,
    'Ruth': 7,
    '1 Samuel': 8,
    '2 Samuel': 9,
    '1 Kings': 10,
    '2 Kings': 11,
    '1 Chronicles': 12,
    '2 Chronicles': 13,
    'Ezra': 14,
    'Nehemiah': 15,
    'Esther': 16,
    'Job': 17,
    'Psalms': 18,
    'Proverbs': 19,
    'Ecclesiastes': 20,
    'Song of Solomon': 21,
    'Isaiah': 22,
    'Jeremiah': 23,
    'Lamentations': 24,
    'Ezekiel': 25,
    'Daniel': 26,
    'Hosea': 27,
    'Joel': 28,
    'Amos': 29,
    'Obadiah': 30,
    'Jonah': 31,
    'Micah': 32,
    'Nahum': 33,
    'Habakkuk': 34,
    'Zephaniah': 35,
    'Haggai': 36,
    'Zechariah': 37,
    'Malachi': 38,
    'Matthew': 39,
    'Mark': 40,
    'Luke': 41,
    'John': 42,
    'Acts': 43,
    'Romans': 44,
    '1 Corinthians': 45,
    '2 Corinthians': 46,
    'Galatians': 47,
    'Ephesians': 48,
    'Philippians': 49,
    'Colossians': 50,
    '1 Thessalonians': 51,
    '2 Thessalonians': 52,
    '1 Timothy': 53,
    '2 Timothy': 54,
    'Titus': 55,
    'Philemon': 56,
    'Hebrews': 57,
    'James': 58,
    '1 Peter': 59,
    '2 Peter': 60,
    '1 John': 61,
    '2 John': 62,
    '3 John': 63,
    'Jude': 64,
    'Revelation': 65,
  };


  Future<List<String>> _fetchVerses(String sel) async {
    final dbHelper = DatabaseHelper();
    return await dbHelper.getVerses(bookIndex[widget.book]!, widget.chapter, sel);
  }

  void _onLanguageChanged(String? newLanguage) {
    if (newLanguage != null) {
      setState(() {
        _selectedLanguage = newLanguage;
        _versesFuture = _fetchVerses(newLanguage); // Re-fetch verses with the new language
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = CupertinoTheme.brightnessOf(context) == Brightness.dark;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('${widget.book} Chapter ${widget.chapter}'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text(
            _selectedLanguage,
            style: TextStyle(color: isDarkMode ? CupertinoColors.white : CupertinoColors.black),
          ),
          onPressed: () => _showLanguagePicker(),
        ),
      ),
      child: SafeArea(
        child: FutureBuilder<List<String>>(
          future: _versesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No verses found.'));
            } else {
              final verses = snapshot.data!;
              return LayoutBuilder(
                builder: (context, constraints) {
                  bool isWideScreen = constraints.maxWidth > 950;
                  return isWideScreen
                      ? Row(
                    children: [
                      Expanded(
                        child: _buildVerseList(verses, 0, (verses.length / 2).toInt()),
                      ),
                      Expanded(
                        child: _buildVerseList(verses, (verses.length / 2).toInt(), verses.length),
                      ),
                    ],
                  )
                      : CupertinoScrollbar(
                    child: _buildVerseList(verses, 0, verses.length),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildVerseList(List<String> verses, int start, int end) {
    final isDarkMode = CupertinoTheme.brightnessOf(context) == Brightness.dark;

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: end - start,
      itemBuilder: (context, index) {
        int verseIndex = start + index;
        String verse = verses[verseIndex];

        // Choose font family and size based on the selected language
        String fontFamily = _selectedLanguage == 'English' ? 'PTSerif-Regular' : 'MuktaMalar';
        double fontSize = _selectedLanguage == 'English' ? 20.0 : 21.0;  // Font size condition

        return Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: fontSize,
                      fontFamily: fontFamily,
                      color: isDarkMode ? Colors.grey[300] : Colors.black87,
                    ),
                    children: [
                      TextSpan(
                        text: '${verseIndex + 1}. ', // Automatically adds the verse number
                        style: TextStyle(fontWeight: FontWeight.bold), // Optional bold for numbering
                      ),
                      TextSpan(
                        text: verse, // The actual verse text
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLanguagePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text('Select Language'),
        actions: _languages.map((language) {
          return CupertinoActionSheetAction(
            onPressed: () {
              _onLanguageChanged(language);
              Navigator.pop(context);
            },
            child: Text(language),
          );
        }).toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
      ),
    );
  }
}
