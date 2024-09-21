import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'home_tab.dart';
import 'bible_tab.dart';
import 'songs_tab.dart';
import 'settings_tab.dart';
import 'package:flutter_svg/flutter_svg.dart';
void main() async {


  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => const MainPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Prevents the column from taking extra space
                children: [
                  SvgPicture.asset(
                    'assets/tsa.svg', // Path to your SVG asset
                    width: 200.0, // Larger size
                    height: 200.0, // Larger size
                  ),
                  SizedBox(height: 20), // Space between SVG and headline text
                  Text(
                    'Salvation Army Song Book',
                    style: TextStyle(
                      fontFamily: 'InterTight',
                      fontSize: 24.0, // Medium headline text size
                      fontWeight: FontWeight.w700, // Adjust weight as needed
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0), // Padding at the bottom
            child: Column(
              children: [
                Text(
                  'Developed by',
                  style: TextStyle(
                    fontFamily: 'InterTight',
                    fontSize: 18.0, // Small text size
                    fontWeight: FontWeight.w700, // Regular weight
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10), // Space between texts
                Text(
                  'SAY Group',
                  style: TextStyle(
                    fontFamily: 'InterTight',
                    fontSize: 30.0, // Big headline text size
                    fontWeight: FontWeight.w800, // Bold weight
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10), // Space between texts
                Text(
                  'Salvation Army Youth Group',
                  style: TextStyle(
                    fontFamily: 'InterTight',
                    fontSize: 24.0, // Medium headline text size
                    fontWeight: FontWeight.w700, // Bold weight
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10), // Space between texts
                Text(
                  'TSA Sion Corps Mumbai',
                  style: TextStyle(
                    fontFamily: 'InterTight',
                    fontSize: 18.0, // Adjust text size as needed
                    fontWeight: FontWeight.w400, // Regular weight
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book),
            label: 'Bible',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.music_note),
            label: 'Songs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        activeColor: Colors.red,
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) => const HomeTab());
          case 1:
            return CupertinoTabView(builder: (context) => const BibleTab());
          case 2:
            return CupertinoTabView(builder: (context) => const SongsTab());
          case 3:
            return CupertinoTabView(builder: (context) => const SettingsTab());
          default:
            return CupertinoTabView(builder: (context) => const HomeTab());
        }
      },
    );
  }
}
