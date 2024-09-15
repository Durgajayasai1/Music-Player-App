import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:music_player/components/neu_box.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => SongPageState();
}

class SongPageState extends State<SongPage> {
  // convert duration to min:sec
  String formatTime(Duration duration) {
    String twoDigitsSec =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitsSec";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, value, child) {
      // get the playlist
      final playlist = value.playlist;
      // get current song index
      final currentSong = playlist[value.currentSongIdx ?? 0];
      // return Scaffold UI
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // custom appbar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Iconsax.arrow_left_2)),
                    Text(
                      "Playlist",
                      style: GoogleFonts.pacifico(fontSize: 20),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Iconsax.menu))
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                // album artwork
                NeuBox(
                    child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(currentSong.albumArtImagePath),
                    ),
                    // song and artist name and heart icon
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentSong.songName,
                                style: GoogleFonts.poppins(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                currentSong.artistName,
                                style: GoogleFonts.poppins(),
                              )
                            ],
                          ),
                          const Icon(
                            Iconsax.heart,
                          )
                        ],
                      ),
                    )
                  ],
                )),
                const SizedBox(
                  height: 25,
                ),
                // song duration work
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // start time
                          Text(
                            formatTime(value.currDuration),
                            style: GoogleFonts.poppins(),
                          ),
                          // shuffle icon
                          const Icon(Iconsax.shuffle),
                          // repeat music
                          const Icon(Iconsax.repeate_music),
                          Text(
                            formatTime(value.totalDuration),
                            style: GoogleFonts.poppins(),
                          )
                        ],
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 0)),
                      child: Slider(
                        min: 0,
                        max: value.totalDuration.inSeconds.toDouble(),
                        value: value.currDuration.inSeconds.toDouble(),
                        activeColor: Colors.blueAccent,
                        onChanged: (double double) {
                          // when user dragging the slider
                        },
                        onChangeEnd: (double double) {
                          // sliding has finished, go to that position in song duration
                          value.seek(Duration(seconds: double.toInt()));
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // playback controls
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                          onTap: value.playPreviousSong,
                          child: const NeuBox(child: Icon(Iconsax.previous))),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                          onTap: value.pauseOrResume,
                          child: NeuBox(
                              child: Icon(value.isPlaying
                                  ? Iconsax.pause
                                  : Iconsax.play))),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                          onTap: value.playNextSong,
                          child: const NeuBox(child: Icon(Iconsax.next))),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
