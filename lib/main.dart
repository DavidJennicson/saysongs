import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saysongs/tabs/navigation_service.dart';
import 'dart:async';
import 'tabs/home_tab.dart';
import 'tabs/bible_tab.dart';
import 'tabs/songs_tab.dart';
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
    Timer(const Duration(seconds: 5), () {
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/tsa.svg',
                    width: 200.0,
                    height: 200.0,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'The Salvation Army Hymns',
                    style: TextStyle(
                      fontFamily: 'InterTight',
                      fontSize: 26.0,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'SING TO THE LORD WITH ALL YOUR HEART',
                    style: TextStyle(
                      fontFamily: 'InterTight',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                const Text(
                  'Developed by',
                  style: TextStyle(
                    fontFamily: 'InterTight',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'SAY Group',
                  style: TextStyle(
                    fontFamily: 'InterTight',
                    fontSize: 30.0,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Salvation Army Youth Group',
                  style: TextStyle(
                    fontFamily: 'InterTight',
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'TSA Sion Corps Mumbai',
                  style: TextStyle(
                    fontFamily: 'InterTight',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
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

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Expanded(child: HomeTab()), // Change this to display a specific tab's content
            // If you want to allow navigation to different sections, you could add buttons to navigate.
          ],
        ),
      ),
    );
  }
}
