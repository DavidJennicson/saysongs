import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saysongs/databasecon/database_helper.dart'; // Import your DatabaseHelper
import 'package:saysongs/songs/christiantamilsong.dart';
import 'package:saysongs/langutils/tamilconverter.dart'; // Import the TamilTextPage

class SongsByAlphabetPage extends StatefulWidget {
  final String alphabet;

  const SongsByAlphabetPage({Key? key, required this.alphabet}) : super(key: key);

  @override
  _SongsByAlphabetPageState createState() => _SongsByAlphabetPageState();
}

class _SongsByAlphabetPageState extends State<SongsByAlphabetPage> {
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
    final songs = await DatabaseHelper().getSongTitlesByAlphabet(widget.alphabet);
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
      navigationBar: CupertinoNavigationBar(
        middle: Text('${widget.alphabet} Songs'),
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
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _filteredSongs.length,
                itemBuilder: (context, index) {
                  final song = _filteredSongs[index];
                  final songId = song['id'];
                  final songTitleEnglish =  song['heading'];


                  return Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: CupertinoColors.systemGrey.withOpacity(0.1),
                          // blurRadius: 4.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: CupertinoListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              songTitleEnglish,
                              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => TamilTextPage(songId: songId),
                          ),
                        );
                      },
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
}
