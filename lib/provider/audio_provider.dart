import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  String? _currentAudio;

  bool isPlaying = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  bool isInitialized = false;
  String? error;

  AudioProvider() {
    _initPlayer();
  }

  void _initPlayer() {
    _player.onDurationChanged.listen(
      (d) {
        duration = d;
        notifyListeners();
      },
      onError: _handleError,
    );

    _player.onPositionChanged.listen(
      (p) {
        position = p;
        notifyListeners();
      },
      onError: _handleError,
    );

    _player.onPlayerComplete.listen(
      (_) {
        isPlaying = false;
        position = Duration.zero;
        notifyListeners();
      },
      onError: _handleError,
    );

    _player.onPlayerStateChanged.listen(
      (state) {
        isPlaying = state == PlayerState.playing;
        notifyListeners();
      },
      onError: _handleError,
    );
  }

  void _handleError(dynamic error) {
    this.error = error.toString();
    isPlaying = false;
    notifyListeners();
  }

  Future<void> playAudio(String audio) async {
    try {
      error = null;

      if (_currentAudio != audio) {
        await _player.stop();
        await _player.setSource(AssetSource(audio));
        _currentAudio = audio;
        isInitialized = true;
      }

      await _player.resume();
      isPlaying = true;
      notifyListeners();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> togglePlayPause(String audio) async {
    try {
      error = null;

      if (!isInitialized || _currentAudio != audio) {
        await playAudio(audio);
        return;
      }

      if (isPlaying) {
        await _player.pause();
        isPlaying = false;
      } else {
        await _player.resume();
        isPlaying = true;
      }

      notifyListeners();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> seekAudio(double value) async {
    try {
      error = null;

      if (!isInitialized) {
        return;
      }

      final newPosition = Duration(seconds: value.toInt());
      if (newPosition <= duration) {
        await _player.seek(newPosition);
        position = newPosition;
        notifyListeners();
      }
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> stopAudio() async {
    try {
      error = null;

      await _player.stop();
      isPlaying = false;
      position = Duration.zero;
      _currentAudio = null;
      isInitialized = false;
      notifyListeners();
    } catch (e) {
      _handleError(e);
    }
  }

  String formatTime(Duration d) {
    if (d.isNegative) {
      return "00:00";
    }
    return "${d.inMinutes.remainder(60).toString().padLeft(2, '0')}:"
        "${d.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
