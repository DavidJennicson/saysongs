import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saysongs/engsongtsa.dart';
import 'package:saysongs/songbyalphabetpage.dart';
import 'package:saysongs/tamilsongstsa.dart';
class SongsTab extends StatelessWidget {
  const SongsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Songs'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildButton(
              context,
              title: 'Salvation Army Songs (Tamil)',
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => TamilSongsPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16.0),
            _buildButton(
              context,
              title: 'Salvation Army Songs (English)',
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => EnglishSongsPage(),
                  ),
                );
                // Add navigation or action for English Salvation Army songs
              },
            ),
            const SizedBox(height: 16.0),
            _buildButton(
              context,
              title: 'Christian Songs (Tamil)',
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => ChristianSongsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, {required String title, required VoidCallback onTap}) {
    return CupertinoButton(
      color: CupertinoColors.systemRed,
      onPressed: onTap,
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0), // Increase height with vertical padding
      borderRadius: BorderRadius.circular(20.0), // More rounded corners
      child: Text(
        title,
        style: const TextStyle(color: CupertinoColors.white),
      ),
    );
  }
}


class ChristianSongsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Determine the number of columns based on screen size
    final isTablet = MediaQuery.of(context).size.width > 600;
    final crossAxisCount = isTablet ? 10 : 4;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Song Index'),
      ),
      child: SafeArea(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          padding: const EdgeInsets.all(16.0),
          itemCount: 26, // Number of letters A to Z
          itemBuilder: (context, index) {
            final letter = String.fromCharCode(index + 65); // Convert index to letter (A-Z)
            return CupertinoButton(
              color: CupertinoColors.systemBlue,
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SongsByAlphabetPage(alphabet: letter),
                  ),
                );
              },
              padding: const EdgeInsets.all(16.0),
              borderRadius: BorderRadius.circular(10.0),
              child: Text(
                letter,
                style: const TextStyle(color: CupertinoColors.white, fontSize: 18.0),
              ),
            );
          },
        ),
      ),
    );
  }
}