import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  bool isPlaying = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  bool isInitialized = false;

  AudioProvider() {
    _initPlayer();
  }

  void _initPlayer() {
    _player.onDurationChanged.listen((d) {
      duration = d;
      notifyListeners();
    });

    _player.onPositionChanged.listen((p) {
      position = p;
      notifyListeners();
    });

    _player.onPlayerComplete.listen((_) {
      isPlaying = false;
      position = Duration.zero;
      notifyListeners();
    });

    _player.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
      notifyListeners();
    });
  }

  Future<void> playAudio(String audio) async {
    try {
      if (!isInitialized) {
        await _player.setSource(AssetSource(audio));
        isInitialized = true;
      }
      
      await _player.resume();
      isPlaying = true;
      notifyListeners();
    } catch (e) {
      print('Error playing audio: $e');
      isPlaying = false;
      notifyListeners();
    }
  }

  Future<void> togglePlayPause(audio) async {
    try {
      if (!isInitialized) {
        await playAudio(audio);
        return;
      }

      if (isPlaying) {
        await _player.pause();
      } else {
        await _player.resume();
      }
      isPlaying = !isPlaying;
      notifyListeners();
    } catch (e) {
      print('Error toggling play/pause: $e');
    }
  }

  Future<void> seekAudio(double value) async {
    try {
      await _player.seek(Duration(seconds: value.toInt()));
    } catch (e) {
      print('Error seeking audio: $e');
    }
  }

  Future<void> stopAudio() async {
    try {
      await _player.stop();
      isPlaying = false;
      position = Duration.zero;
      notifyListeners();
    } catch (e) {
      print('Error stopping audio: $e');
    }
  }

  String formatTime(Duration d) {
    return "${d.inMinutes.remainder(60).toString().padLeft(2, '0')}:"
           "${d.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _player.dispose(); 
    super.dispose();
  }
}