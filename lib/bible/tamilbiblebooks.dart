import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saysongs/bible/tamilversepage.dart';
import 'package:saysongs/bible/verses_page.dart';

class TamilBibleTab extends StatefulWidget {
  const TamilBibleTab({Key? key}) : super(key: key);

  @override
  _TamilBibleTabState createState() => _TamilBibleTabState();
}

class _TamilBibleTabState extends State<TamilBibleTab> {
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

  final Map<String, bool> _isExpanded = {};

  @override
  void initState() {
    super.initState();
    for (var book in tamilBookNames.keys) {
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
            slivers: tamilBookNames.keys.map((book) {
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
                          title: Text(tamilBookNames[book]!),
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
                              itemCount: tamilBookNames.length,
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
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => TamilVersePage(
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
