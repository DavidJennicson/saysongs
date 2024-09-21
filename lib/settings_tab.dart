import 'package:flutter/cupertino.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: Center(
        child: HtmlWidget('Hello World!'),
      ),
    );
  }
}
