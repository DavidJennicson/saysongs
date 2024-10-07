import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:saysongs/databasecon/database_helper.dart';
import 'package:saysongs/langutils/tamiltransliterator.dart';

class TamilTextPage extends StatefulWidget {
  final int songId;

  const TamilTextPage({Key? key, required this.songId}) : super(key: key);

  @override
  _TamilTextPageState createState() => _TamilTextPageState();
}

class _TamilTextPageState extends State<TamilTextPage> {
  String _selectedLanguage = 'Tamil';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Song Number ${widget.songId}'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            CupertinoSlidingSegmentedControl<String>(
              children: const {
                'Tamil': Text('Tamil'),
                'English': Text('English'),
              },
              onValueChanged: (value) {
                setState(() {
                  _selectedLanguage = value ?? 'Tamil';

                });
              },
              groupValue: _selectedLanguage,
            ),
            Expanded(
              child: FutureBuilder<String?>(
                future: _getTextForSelectedLanguage(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CupertinoActivityIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final text = snapshot.data;

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: HtmlWidget(
                        text ?? '',
                        textStyle: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                          fontSize: _selectedLanguage=='Tamil'?24:21,
                          fontFamily: _selectedLanguage == 'Tamil' ? 'MuktaMalar' : 'PTSerif-Regular',
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _getTextForSelectedLanguage() async {
    var t = TamilTransliterator();

    if (_selectedLanguage == 'Tamil') {
      return await DatabaseHelper().getTamilTextBySongId(widget.songId, 'Tamil');
    } else {
      final tamilText = await DatabaseHelper().getTamilTextBySongId(widget.songId, 'Tamil');
      return t.transliterate(tamilText!);
    }
  }
}
