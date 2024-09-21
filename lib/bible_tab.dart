import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this for SVG support
import 'package:saysongs/verses_page.dart';

class BibleTab extends StatefulWidget {
  const BibleTab({Key? key}) : super(key: key);

  @override
  _BibleTabState createState() => _BibleTabState();
}

class _BibleTabState extends State<BibleTab> {
  final Map<String, int> booksWithChapters = {
    'Genesis': 50,
    'Exodus': 40,
    'Leviticus': 27,
    'Numbers': 36,
    'Deuteronomy': 34,
    'Joshua': 24,
    'Judges': 21,
    'Ruth': 4,
    '1 Samuel': 31,
    '2 Samuel': 24,
    '1 Kings': 22,
    '2 Kings': 25,
    '1 Chronicles': 29,
    '2 Chronicles': 36,
    'Ezra': 10,
    'Nehemiah': 13,
    'Esther': 10,
    'Job': 42,
    'Psalms': 150,
    'Proverbs': 31,
    'Ecclesiastes': 12,
    'Song of Solomon': 8,
    'Isaiah': 66,
    'Jeremiah': 52,
    'Lamentations': 5,
    'Ezekiel': 48,
    'Daniel': 12,
    'Hosea': 14,
    'Joel': 3,
    'Amos': 9,
    'Obadiah': 1,
    'Jonah': 4,
    'Micah': 7,
    'Nahum': 3,
    'Habakkuk': 3,
    'Zephaniah': 3,
    'Haggai': 2,
    'Zechariah': 14,
    'Malachi': 4,
    'Matthew': 28,
    'Mark': 16,
    'Luke': 24,
    'John': 21,
    'Acts': 28,
    'Romans': 16,
    '1 Corinthians': 16,
    '2 Corinthians': 13,
    'Galatians': 6,
    'Ephesians': 6,
    'Philippians': 4,
    'Colossians': 4,
    '1 Thessalonians': 5,
    '2 Thessalonians': 3,
    '1 Timothy': 6,
    '2 Timothy': 4,
    'Titus': 3,
    'Philemon': 1,
    'Hebrews': 13,
    'James': 5,
    '1 Peter': 5,
    '2 Peter': 3,
    '1 John': 5,
    '2 John': 1,
    '3 John': 1,
    'Jude': 1,
    'Revelation': 22,
  };

  final Map<String, bool> _isExpanded = {};
  bool _isTamil = false;

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

  void _toggleLanguage() {
    setState(() {
      _isTamil = !_isTamil;
    });
  }

  String _getBookName(String book) {
    if (_isTamil) {
      return _getTamilBookName(book);
    }
    return book;
  }

  String _getTamilBookName(String book) {
    final Map<String, String> tamilBookNames = {
      'Genesis': 'ஆதியாகமம்',
      'Exodus': 'யாத்திராகமம்',
      'Leviticus': 'லேவியராகமம்',
      'Numbers': 'எண்ணாகமம்',
      'Deuteronomy': 'உபாகமம்',
      'Joshua': 'யோசுவா',
      'Judges': 'நியாயாதிபதிகள்',
      'Ruth': 'ரூத்',
      '1 Samuel': '1 சாமுவேல்',
      '2 Samuel': '2 சாமுவேல்',
      '1 Kings': '1 இராஜாக்கள்',
      '2 Kings': '2 இராஜாக்கள்',
      '1 Chronicles': '1 நாளாகமம்',
      '2 Chronicles': '2 நாளாகமம்',
      'Ezra': 'எஸ்றா',
      'Nehemiah': 'நெகேமியா',
      'Esther': 'எஸ்தர்',
      'Job': 'யோபு',
      'Psalms': 'சங்கீதம்',
      'Proverbs': 'நீதிமொழிகள்',
      'Ecclesiastes': 'பிரசங்கி',
      'Song of Solomon': 'உன்னதப்பாட்டு',
      'Isaiah': 'ஏசாயா',
      'Jeremiah': 'எரேமியா',
      'Lamentations': 'புலம்பல்',
      'Ezekiel': 'எசேக்கியேல்',
      'Daniel': 'தானியேல்',
      'Hosea': 'ஓசியா',
      'Joel': 'யோவேல்',
      'Amos': 'ஆமோஸ்',
      'Obadiah': 'ஒபதியா',
      'Jonah': 'யோனா',
      'Micah': 'மீகா',
      'Nahum': 'நாகூம்',
      'Habakkuk': 'ஆபகூக்',
      'Zephaniah': 'செப்பனியா',
      'Haggai': 'ஆகாய்',
      'Zechariah': 'சகரியா',
      'Malachi': 'மல்கியா',
      'Matthew': 'மத்தேயு',
      'Mark': 'மாற்கு',
      'Luke': 'லூக்கா',
      'John': 'யோவான்',
      'Acts': 'அப்போஸ்தலருடைய நடபடிகள்',
      'Hebrews': 'எபிரெயர்',
      'James': 'யாக்கோபு',
      'Romans': 'ரோமர்',
      '1 Corinthians': '1 கொரிந்தியர்',
      '2 Corinthians': '2 கொரிந்தியர்',
      'Galatians': 'கலாத்தியர்',
      'Ephesians': 'எபேசியர்',
      'Philippians': 'பிலிப்பியர்',
      'Colossians': 'கொலோசெயர்',
      '1 Thessalonians': '1 தெசலோனிக்கேயர்',
      '2 Thessalonians': '2 தெசலோனிக்கேயர்',
      '1 Timothy': '1 தீமோத்தேயு',
      '2 Timothy': '2 தீமோத்தேயு',
      'Titus': 'தீத்து',
      'Philemon': 'பிலேமோன்',
      '1 Peter': '1 பேதுரு',
      '2 Peter': '2 பேதுரு',
      '1 John': '1 யோவான்',
      '2 John': '2 யோவான்',
      '3 John': '3 யோவான்',
      'Jude': 'யூதா',
      'Revelation': 'வெளிப்படுத்தின விசேஷம்',
    };
    return tamilBookNames[book] ?? book;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Bible'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.globe,
                color: CupertinoColors.activeBlue,
              ),
              SizedBox(width: 8),
              Text(_isTamil ? 'தமிழ்' : 'English'),
            ],
          ),
          onPressed: _toggleLanguage,
        ),
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
                          title: Text(_getBookName(book)),
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
                          // Check if the screen width is greater than a threshold for tablet size
                          bool isTablet = constraints.maxWidth > 600;
                          double horizontalPadding = isTablet
                              ? 100.0
                              : 40.0; // Adjust padding based on screen size

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
                                    width: 32.0, // Very small width
                                    height: 32.0, // Very small height
                                  ),
                                  child: CupertinoButton(
                                    color: CupertinoColors.systemBlue,
                                    padding: EdgeInsets.zero,
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        fontSize: 16.0, // Small font size
                                        color: CupertinoColors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => VersesPage(
                                            book: book,
                                            chapter: index + 1,
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
