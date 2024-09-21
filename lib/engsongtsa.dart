import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Import this for CupertinoScrollbar
import 'package:saysongs/database_helper.dart';
import 'package:saysongs/tsaenglyrics.dart';
import 'lyrics_page.dart'; // Import the new page

class EnglishSongsPage extends StatefulWidget {
  @override
  _EnglishSongsPageState createState() => _EnglishSongsPageState();
}

class _EnglishSongsPageState extends State<EnglishSongsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _songs = [];
  List<Map<String, dynamic>> _filteredSongs = [];

  @override
  void initState() {
    super.initState();
    _fetchSongs();
    _searchController.addListener(_filterSongs);
  }

  Future<void> _fetchSongs() async {
    final songs = await DatabaseHelper().getAllEngSongTitles();
    setState(() {
      _songs = songs;
      _filteredSongs = songs;
    });
  }

  void _filterSongs() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSongs = _songs.where((song) {
        final songTitle = song['heading'].toLowerCase();
        return songTitle.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Salvation Army Songs (English)'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoTextField(
                controller: _searchController,
                placeholder: 'Search Songs',
                prefix: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(CupertinoIcons.search),
                ),
                clearButtonMode: OverlayVisibilityMode.editing,
              ),
            ),
            Expanded(
              child: CupertinoScrollbar(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _filteredSongs.length,
                  itemBuilder: (context, index) {
                    final song = _filteredSongs[index];
                    final songId = song['song'];
                    final songTitle = song['heading'];

                    return CupertinoListTile(
                      title: Text(songTitle),
                      onTap: () {
                        print(songId);
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => EnglishLyricsPage(songId: songId),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
