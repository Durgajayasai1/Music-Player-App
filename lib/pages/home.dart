import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/components/my_drawer.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/models/song.dart';
import 'package:music_player/pages/song_page.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  // get the playlist provider
  late final dynamic playlist_provider;

  @override
  void initState() {
    super.initState();

    // get playlist provider
    playlist_provider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int songIdx){
    // update the current song index
    playlist_provider.currentSongIdx = songIdx;
    // navigate to the song page
    Navigator.push(context, MaterialPageRoute(builder: (context) => SongPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            title: Text(
              "Playlist",
              style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500),
            ),
          )),
      drawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          // Get the playlist
          final List<Song> playList = value.playlist;

          return ListView.builder(
            itemCount: playList.length,
            itemBuilder: (context, index) {
              // Get individual song
              final Song song = playList[index];

              // Return ListTile UI
              return ListTile(
                leading: Image.asset(song.albumArtImagePath),
                title: Text(
                  song.songName,
                  style: GoogleFonts.poppins(),
                ),
                subtitle: Text(
                  song.artistName,
                  style: GoogleFonts.poppins(),
                ),
                onTap: () => goToSong(index),
              );
            },
          );
        },
      ),
    );
  }
}
