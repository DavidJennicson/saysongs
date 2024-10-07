import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saysongs/bible/englishbiblebooks.dart';
import 'package:saysongs/bible/tamilbiblebooks.dart';
import 'package:saysongs/tabs/songs_tab.dart';
import 'package:saysongs/tsafunctions/engsongs/engsongtsa.dart';
import 'package:saysongs/tsafunctions/tamsongs/tamilsongstsa.dart';

import '../bible/tamilversepage.dart';
import '../bible/verses_page.dart';
import '../databasecon/database_helper.dart';
import '../tsafunctions/doctrine/doctrine.dart';
// Import the database helper

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String? todayVerse;
  String? todayVerseReference;
  String? lastBook;
  int? lastChapter;
  @override
  void initState() {
    super.initState();
   _fetchTodayVerse();
    _fetchLastBookAndChapter();
  }



  Future<void> _fetchLastBookAndChapter() async {
    final dbHelper = DatabaseHelper();
    Map<String, dynamic>? lastData = await dbHelper.fetchLastBookAndChapter();

    if (lastData != null) {
      setState(() {
        lastBook = lastData['Lastbook'] ?? 'No last book found';
        lastChapter = lastData['Lastchap'];
        print(lastBook);
      });
    }
  }

  Future<void> _fetchTodayVerse() async {
    final dbHelper = DatabaseHelper();

    // Fetch the verse and update the date
    Map<String, dynamic>? verseData = await dbHelper.fetchRandomVerseAndUpdateDate();

    // If verseData is not null, update todayVerse and todayVerseReference
    if (verseData != null) {
      setState(() {
        todayVerse = verseData['Verse'];
        todayVerseReference = verseData['Reference'];
      });
    } else {
      // Handle case where no verse was found
      setState(() {
        todayVerse = "No verse found.";
        todayVerseReference = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine the current theme
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Define colors based on the theme
    final backgroundColor = isDarkMode ? CupertinoColors.black : Colors.white;
    final cardColor = isDarkMode ? CupertinoColors.darkBackgroundGray : Colors.white;
    final textColor = isDarkMode ? CupertinoColors.white : CupertinoColors.black;
    final subtitleColor = isDarkMode ? CupertinoColors.white.withOpacity(0.7) : Colors.black.withOpacity(0.7);
    final borderColor = Colors.grey.withOpacity(0.5);
    final redColor = isDarkMode ? CupertinoColors.darkBackgroundGray : Colors.red;

    String getGreetingMessage() {
      final hour = DateTime.now().hour;
      if (hour >= 5 && hour < 12) {
        return 'Good Morning,';
      } else if (hour >= 12 && hour < 19) {
        return 'Good Afternoon,';
      } else {
        return 'Good Evening,';
      }
    }
    bool isEnglishString(String str) {
      // Check if the string contains only English letters
      return RegExp(r'^[a-zA-Z\s]+$').hasMatch(str);
    }
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: backgroundColor,
        middle: Text(
          'Home',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'InterTight',
            color: textColor,
          ),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    getGreetingMessage(),
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'InterTight',
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                ),

                _buildCard(
                  context,
                  title: "Today's Verse",
                  verse: todayVerse != null ? '$todayVerse - $todayVerseReference' : 'Loading...',
                  textColor: textColor,
                  subtitleColor: subtitleColor,
                  cardColor: cardColor,
                  borderColor: borderColor,
                  fullWidth: true,
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {

                    if (lastBook == null || lastChapter == null) {
                      // Show an alert dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: Text('No Book Selected'),
                            content: Text('You haven\'t chosen any book yet.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      // Navigate to VersesPage with the selected book and chapter
                      if (lastBook != null && isEnglishString(lastBook!)) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => VersesPage(
                              book: lastBook ?? 'Genesis', // Pass the selected book
                              chapter: lastChapter ?? 1, // Pass the selected chapter
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => TamilVersePage(
                              book: lastBook ?? '0', // Pass the selected book
                              chapter: lastChapter ?? 1, // Pass the selected chapter
                            ),
                          ),
                        );
                      }
                    }

                  },
                  child: _buildCard(
                    context,
                    title: 'Continue Reading',
                    verse: lastChapter != null ? 'You closed the app at Chapter $lastChapter of $lastBook.' : 'Loading...',
                    textColor: textColor,
                    subtitleColor: subtitleColor,
                    cardColor: cardColor,
                    borderColor: borderColor,
                    fullWidth: true,
                    icon: CupertinoIcons.book,
                  ),
                ),

                const SizedBox(height: 16.0),
                Text(
                  'Quick Menu',
                  style: TextStyle(
                    fontSize: _getFontSize(context, isLargeScreen: true),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'InterTight',
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 16.0),
                _buildButtons(redColor, textColor, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, {
    required String title,
    required String verse,
    required Color textColor,
    required Color subtitleColor,
    required Color cardColor,
    required Color borderColor,
    bool fullWidth = false,
    IconData? icon,
  }) {
    return Container(
      width: fullWidth ? double.infinity : null,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor, size: 30),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: _getFontSize(context),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'InterTight',
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    verse,
                    style: TextStyle(
                      fontSize: _getFontSize(context, isLargeScreen: false),
                      fontFamily: 'InterTight',
                      color: subtitleColor,

                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(Color redColor, Color textColor, BuildContext context) {
    final List<Map<String, dynamic>> buttonDetails = [
      {'title': 'English Bible', 'icon': 'assets/icons/bible.svg', 'subtitle': 'Eng'},
      {'title': 'Tamil Bible', 'icon': 'assets/icons/bible.svg', 'subtitle': 'தமிழ்'},
      {'title': 'TSA Songbook English', 'icon': Icons.music_note, 'subtitle': 'Eng'},
      {'title': 'TSA Songbook Tamil', 'icon': Icons.music_note, 'subtitle': 'தமிழ்'},
      {'title': 'Christian Songs Tamil', 'icon': Icons.music_note, 'subtitle': 'தமிழ்'},
      {'title': 'Doctrine', 'icon': Icons.book, 'subtitle': ''}, // This is the Doctrine button
    ];

    return Column(
      children: buttonDetails.map((details) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              onPressed: () {

                // Check if the button title is 'Doctrine'
                if (details['title'] == 'Doctrine') {
                  // Navigate to the BeliefStatement widget
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => BeliefStatement()),
                  );
                }
                else if(details['title']=='Christian Songs Tamil')
                {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ChristianSongsPage(),
                    ),
                  );
                }
                else if(details['title']=='TSA Songbook English')
                {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => EnglishSongsPage(),
                    ),
                  );
                }
                else if(details['title']=='TSA Songbook Tamil')
                {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => TamilSongsPage(),
                    ),
                  );
                }
                else if(details['title']=='English Bible'){
                  Navigator.push(context, CupertinoPageRoute(builder:(context)=>EnglishBibleTab()));
                  // Add your other button actions here
                }
                else if(details['title']=='Tamil Bible'){
                  Navigator.push(context, CupertinoPageRoute(builder:(context)=>TamilBibleTab()));
                  // Add your other button actions here
                }
              },
              color: CupertinoColors.destructiveRed,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              borderRadius: BorderRadius.circular(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (details['icon'] is String)
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: SvgPicture.asset(
                        details['icon'],
                        color: CupertinoColors.white,
                        height: 24,
                        width: 24,
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(
                        details['icon'],
                        color: CupertinoColors.white,
                        size: 24,
                      ),
                    ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          details['title'],
                          style: TextStyle(
                            fontSize: _getFontSize(context),
                            fontFamily: 'InterTight',
                            color: CupertinoColors.white,
                          ),
                        ),
                        if (details['subtitle'] != '')
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              details['subtitle'],
                              style: TextStyle(
                                fontSize: _getFontSize(context, isLargeScreen: false),
                                fontFamily: 'InterTight',
                                color: CupertinoColors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  double _getFontSize(BuildContext context, {bool isLargeScreen = true}) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      // Large screens
      return isLargeScreen ? 20.0 : 16.0;
    } else {
      // Small screens
      return isLargeScreen ? 16.0 : 14.0;
    }
  }
}