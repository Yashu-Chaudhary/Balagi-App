import 'package:audioplayers/audioplayers.dart';
import 'package:balagi_bhjans/constants/images.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  String? _currentAudio;
  int _currentIndex = 0; // Changed to start from 0 for better array indexing

  bool isPlaying = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  bool isInitialized = false;
  String? error;
  final List<Map<String, dynamic>> bhajanList = [
    {
      'text': 'श्री राम स्तुति',
      'image': PImages.ramjiIstuti,
      'num': 1,
      'audio': 'ramji_istuti.mp3'
    },
    {
      'text': 'हनुमान चालीसा',
      'image': PImages.splashImage,
      'num': 2,
      'audio': 'h.mp3'
    },
    {
      'text': 'ॐ जय जगदीश हरे',
      'image': PImages.sundarkand,
      'num': 3,
      'audio': 'ohm jai jgdees hare.mp3'
    },
    {
      'text': 'राम रक्षा स्तोत्र',
      'image': PImages.ramRakshaSutra,
      'num': 4,
      'audio': 'ram raksha sutra.mp3'
    },
    {
      'text': 'संकट मोचन हनुमानाष्टक',
      'image': PImages.anjaniPutraStuti,
      'num': 5,
      'audio': 'sankat mochan istuti.mp3'
    },
    {
      'text': 'रामायण आरती',
      'image': PImages.ramayanArti,
      'num': 6,
      'audio': 'arti shree ramayanji ki.mp3'
    },
    {
      'text': 'हनुमान जी आरती',
      'image': PImages.hanumnajiArti,
      'num': 7,
      'audio': 'hanumanji arti.mp3'
    },
    {
      'text': 'बजरंग बाण',
      'image': PImages.bajarangBaan,
      'num': 8,
      'audio': 'bajarang baan.mp3'
    },
  ];

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

  // Set the current index based on the played audio
  void setCurrentIndex(int index) {
    if (index >= 0 && index < bhajanList.length) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  Future<void> playAudio(String audio, int index) async {
    try {
      error = null;
      setCurrentIndex(index);

      // Don't play if audio file is empty
      if (audio.isEmpty) {
        _handleError("Audio file not available");
        return;
      }

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

      // Don't attempt to play empty audio files
      if (audio.isEmpty) {
        _handleError("Audio file not available");
        return;
      }

      if (!isInitialized || _currentAudio != audio) {
        await playAudio(audio, _currentIndex);
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

  // Play next bhajan
  Future<Map<String, dynamic>?> playNext() async {
    int nextIndex = _currentIndex + 1;

    // Find next valid audio (skipping empty ones)
    while (nextIndex < bhajanList.length) {
      if (bhajanList[nextIndex]['audio'].isNotEmpty) {
        setCurrentIndex(nextIndex);
        return bhajanList[nextIndex];
      }
      nextIndex++;
    }

    return null; // No more valid audio files
  }

  // Play previous bhajan
  Future<Map<String, dynamic>?> playPrevious() async {
    int prevIndex = _currentIndex - 1;

    // Find previous valid audio (skipping empty ones)
    while (prevIndex >= 0) {
      if (bhajanList[prevIndex]['audio'].isNotEmpty) {
        setCurrentIndex(prevIndex);
        return bhajanList[prevIndex];
      }
      prevIndex--;
    }

    return null; // No previous valid audio files
  }

  // Get the current bhajan details
  Map<String, dynamic>? getCurrentBhajan() {
    if (_currentIndex >= 0 && _currentIndex < bhajanList.length) {
      return bhajanList[_currentIndex];
    }
    return null;
  }

  // Get the next bhajan details without changing current index
  Map<String, dynamic>? getNextBhajan() {
    int nextIndex = _currentIndex + 1;
    while (nextIndex < bhajanList.length) {
      if (bhajanList[nextIndex]['audio'].isNotEmpty) {
        return bhajanList[nextIndex];
      }
      nextIndex++;
    }
    return null;
  }

  // Get the previous bhajan details without changing current index
  Map<String, dynamic>? getPreviousBhajan() {
    int prevIndex = _currentIndex - 1;
    while (prevIndex >= 0) {
      if (bhajanList[prevIndex]['audio'].isNotEmpty) {
        return bhajanList[prevIndex];
      }
      prevIndex--;
    }
    return null;
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
