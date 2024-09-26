import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // For Cupertino widgets
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:saysongs/databasecon/database_helper.dart';

class EnglishLyricsPage extends StatefulWidget {
  final int songId;

  const EnglishLyricsPage({super.key, required this.songId});

  @override
  _EnglishLyricsPageState createState() => _EnglishLyricsPageState();
}

class _EnglishLyricsPageState extends State<EnglishLyricsPage> {

  Future<String?> _fetchLyrics() async {
    // Fetch only English lyrics directly
    return await DatabaseHelper().getEngLyricsBySongId(widget.songId); // 1 for English lyrics
  }
  String convertToHtml(String text) {
    // Define a regex pattern to detect "Chorus" or "Verse" followed by a number
    final pattern = RegExp(r'(Chorus|Verse) \d+');

    // Split the text into paragraphs using newlines
    List<String> paragraphs = text.split('\n');

    // Convert paragraphs to HTML by wrapping in <p> and replacing newlines with <br>
    List<String> htmlParagraphs = paragraphs.map((para) {
      // Replace any "Chorus" or "Verse" followed by a number with bold tags and inline CSS
      String formattedPara = para.replaceAllMapped(pattern, (match) {
        return '<b>${match.group(0)}</b>';
      });
      // Wrap the rest of the paragraph in <p> tags with inline CSS and replace newlines with <br>
      return '<p >${formattedPara.replaceAll('\n', '<br>')}</p>';
    }).toList();

    // Join all paragraphs into one string
    return htmlParagraphs.join();
  }


  @override
  Widget build(BuildContext context) {
    final CupertinoThemeData themeData = CupertinoTheme.of(context);
    final Color backgroundColor = themeData.barBackgroundColor;
    final Color textColor = themeData.textTheme.navTitleTextStyle.color!;

    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Song Lyrics',
          style: TextStyle(
            color: textColor,
            fontFamily: 'CustomFont', // Apply custom font
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<String?>(
                future: _fetchLyrics(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CupertinoActivityIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final String htmlContent = """
                      <div style="margin-left: 30px;">
                        ${snapshot.data ?? 'Lyrics not found.'}
                      </div>
                    """;

                    return CupertinoScrollbar(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: HtmlWidget(
                          convertToHtml(htmlContent),
                          textStyle: TextStyle(
                            color: textColor,
                            fontFamily: "PTSerif-Regular",
                            fontSize: 19,
                            // Apply custom font
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
