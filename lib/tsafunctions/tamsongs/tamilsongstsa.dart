import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Import this for CupertinoScrollbar
import 'package:saysongs/databasecon/database_helper.dart';
import 'lyrics_page.dart'; // Import the new page

class TamilSongsPage extends StatefulWidget {
  @override
  _TamilSongsPageState createState() => _TamilSongsPageState();
}

class _TamilSongsPageState extends State<TamilSongsPage> {
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
    final songs = await DatabaseHelper().getAllSongTitles();
    setState(() {
      _songs = songs;
      _filteredSongs = songs;
    });
  }

  void _filterSongs() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSongs = _songs.where((song) {
        final songTitle = song['song_title'].toLowerCase();
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
        middle: Text('Salvation Army Songs (Tamil)'),
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
                    final songId = song['songid'];
                    final songTitle = song['song_title'];

                    return CupertinoListTile(
                      title: Text(songTitle),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => LyricsPage(songId: songId),
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
