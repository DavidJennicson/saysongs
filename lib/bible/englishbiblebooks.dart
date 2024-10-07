import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this for SVG support
import 'package:saysongs/bible/verses_page.dart';

import '../databasecon/database_helper.dart';

class EnglishBibleTab extends StatefulWidget {
  const EnglishBibleTab({Key? key}) : super(key: key);

  @override
  _EnglishBibleTabState createState() => _EnglishBibleTabState();
}
void updateBookAndChapter(String book, int chapter) async {
  final dbHelper = DatabaseHelper();
  await dbHelper.updateLastBookAndChapter(book, chapter);
}
class _EnglishBibleTabState extends State<EnglishBibleTab> {
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
        middle: Text('English Bible'),
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
                                      print('${book} ${index + 1}');
                                      updateBookAndChapter(book, index+1);
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>

                                              VersesPage(
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