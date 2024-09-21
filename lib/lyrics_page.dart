import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // For Cupertino widgets
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:saysongs/database_helper.dart';

class LyricsPage extends StatefulWidget {
  final int songId;

  LyricsPage({required this.songId});

  @override
  _LyricsPageState createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> {
  int _selectedSegment = 0; // 0 for Tamil, 1 for English

  Future<String?> _fetchLyrics() async {
    // Fetch the lyrics based on the selected segment
    return await DatabaseHelper().getLyricsBySongId(widget.songId, _selectedSegment);
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
            CupertinoSlidingSegmentedControl<int>(
              groupValue: _selectedSegment,
              onValueChanged: (int? value) {
                if (value != null) {
                  setState(() {
                    _selectedSegment = value;
                  });
                }
              },
              children: {
                0: Text('Tamil'),
                1: Text('English'),
              },
            ),
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
                        // child: Text(htmlContent),
                        child: HtmlWidget(
                          htmlContent,
                          textStyle: TextStyle(
                            color: textColor,
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
