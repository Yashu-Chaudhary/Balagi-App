import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  AudioProvider() {
    _initPlayer();
  }

  bool get isPlaying => _player.state == PlayerState.playing;

  void _initPlayer() async {
    await _player.setSourceAsset('chalisa.mp3');

    _player.onPositionChanged.listen((p) {
      position = p;
      notifyListeners();
    });

    _player.onDurationChanged.listen((d) {
      duration = d;
      notifyListeners();
    });

    _player.onPlayerComplete.listen((_) {
      position = Duration.zero;
      notifyListeners();
    });
    await Future.delayed(Duration(seconds: 1));
    duration = await _player.getDuration() ?? Duration.zero;
    notifyListeners();
  }

  void handlePlayPause() {
    if (isPlaying) {
      _player.pause();
    } else {
      _player.resume();
    }
    notifyListeners();
  }

  void handleSeek(double value) {
    _player.seek(Duration(seconds: value.toInt()));
  }

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }
}
