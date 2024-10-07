import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this for SVG support
import 'package:saysongs/bible/tamilversepage.dart';
import 'package:saysongs/bible/verses_page.dart';

import '../databasecon/database_helper.dart';

class TamilBibleTab extends StatefulWidget {
  const TamilBibleTab({Key? key}) : super(key: key);

  @override
  _TamilBibleTabState createState() => _TamilBibleTabState();
}
void updateBookAndChapter(String book, int chapter) async {
  final dbHelper = DatabaseHelper();
  await dbHelper.updateLastBookAndChapter(book, chapter);
}
class _TamilBibleTabState extends State<TamilBibleTab> {
  final Map<String, int> booksWithChapters = {
    'ஆதியாகமம்': 50,
    'யாத்திராகமம்': 40,
    'லேவியராகமம்': 27,
    'எண்ணாகமம்': 36,
    'உபாகமம்': 34,
    'யோசுவா': 24,
    'நியாயாதிபதிகள்': 21,
    'ரூத்': 4,
    '1 சாமுவேல்': 31,
    '2 சாமுவேல்': 24,
    '1 இராஜாக்கள்': 22,
    '2 இராஜாக்கள்': 25,
    '1 நாளாகமம்': 29,
    '2 நாளாகமம்': 36,
    'எஸ்றா': 10,
    'நெகேமியா': 13,
    'எஸ்தர்': 10,
    'யோபு': 42,
    'சங்கீதம்': 150,
    'நீதிமொழிகள்': 31,
    'பிரசங்கி': 12,
    'உன்னதப்பாட்டு': 8,
    'ஏசாயா': 66,
    'எரேமியா': 52,
    'புலம்பல்': 5,
    'எசேக்கியேல்': 48,
    'தானியேல்': 12,
    'ஓசியா': 14,
    'யோவேல்': 3,
    'ஆமோஸ்': 9,
    'ஒபதியா': 1,
    'யோனா': 4,
    'மீகா': 7,
    'நாகூம்': 3,
    'ஆபகூக்': 3,
    'செப்பனியா': 3,
    'ஆகாய்': 2,
    'சகரியா': 14,
    'மல்கியா': 4,
    'மத்தேயு': 28,
    'மாற்கு': 16,
    'லூக்கா': 24,
    'யோவான்': 21,
    'அப்போஸ்தலருடைய நடபடிகள்': 28,
    'ரோமர்': 16,
    '1 கொரிந்தியர்': 16,
    '2 கொரிந்தியர்': 13,
    'கலாத்தியர்': 6,
    'எபேசியர்': 6,
    'பிலிப்பியர்': 4,
    'கொலோசெயர்': 4,
    '1 தெசலோனிக்கேயர்': 5,
    '2 தெசலோனிக்கேயர்': 3,
    '1 தீமோத்தேயு': 6,
    '2 தீமோத்தேயு': 4,
    'தீத்து': 3,
    'பிலேமோன்': 1,
    'எபிரெயர்': 13,
    'யாக்கோபு': 5,
    '1 பேதுரு': 5,
    '2 பேதுரு': 3,
    '1 யோவான்': 5,
    '2 யோவான்': 1,
    '3 யோவான்': 1,
    'யூதா': 1,
    'வெளிப்படுத்தின விசேஷம்': 22
  };
  Map<String, int> tamilBibleBooks = {
    'ஆதியாகமம்': 0,          // Genesis
    'யாத்திராகமம்': 1,        // Exodus
    'லேவியராகமம்': 2,        // Leviticus
    'எண்ணாகமம்': 3,          // Numbers
    'உபாகமம்': 4,            // Deuteronomy
    'யோசுவா': 5,             // Joshua
    'நியாயாதிபதிகள்': 6,      // Judges
    'ரூத்': 7,                // Ruth
    '1 சாமுவேல்': 8,         // 1 Samuel
    '2 சாமுவேல்': 9,         // 2 Samuel
    '1 இராஜாக்கள்': 10,       // 1 Kings
    '2 இராஜாக்கள்': 11,       // 2 Kings
    '1 நாளாகமம்': 12,         // 1 Chronicles
    '2 நாளாகமம்': 13,         // 2 Chronicles
    'எஸ்றா': 14,             // Ezra
    'நெகேமியா': 15,          // Nehemiah
    'எஸ்தர்': 16,            // Esther
    'யோபு': 17,              // Job
    'சங்கீதம்': 18,          // Psalms
    'நீதிமொழிகள்': 19,       // Proverbs
    'பிரசங்கி': 20,          // Ecclesiastes
    'உன்னதப்பாட்டு': 21,       // The Song of Solomon
    'ஏசாயா': 22,            // Isaiah
    'எரேமியா': 23,          // Jeremiah
    'புலம்பல்': 24,           // Lamentations
    'எசேக்கியேல்': 25,        // Ezekiel
    'தானியேல்': 26,          // Daniel
    'ஓசியா': 27,            // Hosea
    'யோவேல்': 28,           // Joel
    'ஆமோஸ்': 29,            // Amos
    'ஒபதியா': 30,           // Obadiah
    'யோனா': 31,             // Jonah
    'மீகா': 32,              // Micah
    'நாகூம்': 33,            // Nahum
    'ஆபகூக்': 34,           // Habakkuk
    'செப்பனியா': 35,          // Zephaniah
    'ஆகாய்': 36,            // Haggai
    'சகரியா': 37,           // Zechariah
    'மல்கியா': 38,           // Malachi
    // New Testament
    'மத்தேயு': 39,          // Matthew
    'மார்கு': 40,           // Mark
    'லூக்கா': 41,           // Luke
    'யோவான்': 42,           // John
    'அப்போஸ்தலருடைய நடபடிகள்': 43, // Acts
    'எபிரெயர்': 44,         // Hebrews
    'யாக்கோபு': 45,          // James
    'ரோமர்': 46,            // Romans
    '1 கொரிந்தியர்': 47,     // 1 Corinthians
    '2 கொரிந்தியர்': 48,     // 2 Corinthians
    'கலாத்தியர்': 49,        // Galatians
    'எபேசியர்': 50,         // Ephesians
    'பிலிப்பியர்': 51,       // Philippians
    'கொலோசெயர்': 52,        // Colossians
    '1 தெசலோனிக்கேயர்': 53, // 1 Thessalonians
    '2 தெசலோனிக்கேயர்': 54, // 2 Thessalonians
    '1 தீமோத்தேயு': 55,      // 1 Timothy
    '2 தீமோத்தேயு': 56,      // 2 Timothy
    'தீத்து': 57,            // Titus
    'பிலேமோன்': 58,         // Philemon
    '1 பேதுரு': 59,          // 1 Peter
    '2 பேதுரு': 60,          // 2 Peter
    '1 யோவான்': 61,          // 1 John
    '2 யோவான்': 62,          // 2 John
    '3 யோவான்': 63,          // 3 John
    'யூதா': 64,             // Jude
    'வெளிப்படுத்தின விசேஷம்': 65, // Revelation
  };

  final Map<String, bool> _isExpanded = {};

  @override
  void initState() {
    super.initState();
    for (var book in booksWithChapters.keys) {
      _isExpanded[book] = false;
    }
  }

  void _toggleExpansion(String book) {
    setState(() {
      _isExpanded[book] = !_isExpanded[book]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Tamil Bible'),
      ),
      child: SafeArea(
        child: CupertinoScrollbar(
          child: CustomScrollView(
            slivers: booksWithChapters.keys.map((book) {
              return SliverList(
                delegate: SliverChildListDelegate(
                  [
                    GestureDetector(
                      onTap: () => _toggleExpansion(book),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: CupertinoColors.systemGrey,
                              width: 0.3,
                            ),
                          ),
                        ),
                        child: CupertinoListTile(
                          title: Text(book),
                          trailing: CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: Icon(
                              _isExpanded[book] == true
                                  ? CupertinoIcons.chevron_up
                                  : CupertinoIcons.chevron_down,
                            ),
                            onPressed: () => _toggleExpansion(book),
                          ),
                        ),
                      ),
                    ),
                    if (_isExpanded[book]!)
                      LayoutBuilder(
                        builder: (context, constraints) {
                          bool isTablet = constraints.maxWidth > 600;
                          double horizontalPadding = isTablet
                              ? 100.0
                              : 40.0;

                          return Padding(
                            padding: EdgeInsets.fromLTRB(
                                horizontalPadding, 10, horizontalPadding, 0),
                            child: GridView.builder(
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: isTablet ? 10 : 5,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                              ),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: booksWithChapters[book]!,
                              itemBuilder: (context, index) {
                                return Container(
                                  constraints: BoxConstraints.tightFor(
                                    width: 32.0,
                                    height: 32.0,
                                  ),
                                  child: CupertinoButton(
                                    color: CupertinoColors.systemBlue,
                                    padding: EdgeInsets.zero,
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: CupertinoColors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    onPressed: () {
                                      print('${book} ${index +1}');
                                      updateBookAndChapter(book, index+1);
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>

                                              TamilVersePage(
                                                book: book,
                                                chapter: index +1,
                                              ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}