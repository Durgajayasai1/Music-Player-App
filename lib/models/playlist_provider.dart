import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  // playlist of songs
  final List<Song> _playlist = [
    // song 1
    Song(
        songName: "SO LONG",
        artistName: "Killval",
        albumArtImagePath: "assets/images/solong.jpeg",
        audioPath: "audio/solong.mp3"),
    // song 2
    Song(
        songName: "UGLY (ft. nineteen95)",
        artistName: "Timmies",
        albumArtImagePath: "assets/images/ugly.jpeg",
        audioPath: "audio/ugly.mp3"),
    // song 3
    Song(
        songName: "LOOSING INTEREST",
        artistName: "Sarah Meow",
        albumArtImagePath: "assets/images/loosing.jpeg",
        audioPath: "audio/loosing.mp3"),
    // song 4
    Song(
        songName: "24kGoldn - Mood",
        artistName: "iann dior",
        albumArtImagePath: "assets/images/mood.jpeg",
        audioPath: "audio/mood.mp3")
  ];

  int? _currentSongIdx;

  // AUDIO PLAYER
  // audio player
  final AudioPlayer _audioPlayer = AudioPlayer();
  // durations
  Duration _currDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  // constructor
  PlaylistProvider() {
    listerToDuration();
  }
  // initially not playing
  bool _isPlaying = false;
  // play the song
  void play() async {
    final String path = _playlist[_currentSongIdx!].audioPath;
    await _audioPlayer.stop(); // stop current song
    await _audioPlayer.play(AssetSource(path)); // play the new song
    _isPlaying = true;
    notifyListeners();
  }

  // pause the current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  // seek to the specific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // play next song
  void playNextSong() {
    if (_currentSongIdx != null) {
      if (_currentSongIdx! < playlist.length - 1) {
        // go to the next if it's not the last song
        _currentSongIdx = _currentSongIdx! + 1;
      } else {
        // if it's the last song, loop back to the first song
        _currentSongIdx = 0;
      }
      play();
    }
  }

  // play previous song
  void playPreviousSong() async {
    // if more than 2 seconds have passed, restart the current song
    if (_currDuration.inSeconds > 2) {
      seek(Duration.zero);
    }
    // if it's within first 2 second of the song, go to previous song
    else {
      if (_currentSongIdx! > 0) {
        _currentSongIdx = _currentSongIdx! - 1;
      } else {
        // if it's the first song loop back to the last song
        _currentSongIdx = _playlist.length - 1;
      }
      play();
    }
  }

  // list to duration
  void listerToDuration() {
    // listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
    // listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currDuration = newPosition;
      notifyListeners();
    });
    // listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }
  // dispose audio player

  // GETTERS
  List<Song> get playlist => _playlist;
  int? get currentSongIdx => _currentSongIdx;
  bool get isPlaying => _isPlaying;
  Duration get currDuration => _currDuration;
  Duration get totalDuration => _totalDuration;
  // SETTERS
  set currentSongIdx(int? newIdx) {
    // update current song Idx
    _currentSongIdx = newIdx;
    if (newIdx != null) {
      play(); // play the song at the new index
    }
    // update the UI
    notifyListeners();
  }
}
