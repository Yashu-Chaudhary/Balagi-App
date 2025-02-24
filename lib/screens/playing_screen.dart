import 'package:balagi_bhjans/provider/audio_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PlayingScreen extends StatelessWidget {
  const PlayingScreen({
    super.key,
    required this.title,
    required this.image,
    required this.audio,
    required this.index,
  });

  final String title;
  final String image;
  final String audio;
  final int index;

  @override
  Widget build(BuildContext context) {
    // Initialize the audio on first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AudioProvider>().playAudio(audio, index);
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFF6733),
      appBar: _buildAppBar(),
      body: Consumer<AudioProvider>(
        builder: (context, audioProvider, child) {
          if (audioProvider.error != null) {
            return Center(
              child: Text(
                'Error: ${audioProvider.error}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                ),
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              children: [
                SizedBox(height: 80.sp),
                _buildImageContainer(),
                SizedBox(height: 80.sp),
                _buildAudioSlider(audioProvider, context),
                _buildTimeDisplay(audioProvider),
                _buildControlButtons(audioProvider, context),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: const Color(0xFFFF6733),
      title: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 50),
            )
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 50.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildImageContainer() {
    return Container(
      width: 420.sp,
      height: 400.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildAudioSlider(AudioProvider audioProvider, BuildContext context) {
    final double maxDuration = audioProvider.duration.inSeconds.toDouble();
    final double currentPosition = audioProvider.position.inSeconds.toDouble();

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.white,
        inactiveTrackColor: Colors.white.withOpacity(0.3),
        thumbColor: Colors.white,
        overlayColor: Colors.white.withOpacity(0.2),
        trackHeight: 4.0,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 14.0),
      ),
      child: Slider(
        value: currentPosition.clamp(0, maxDuration > 0 ? maxDuration : 0),
        onChanged:
            maxDuration > 0 ? (value) => audioProvider.seekAudio(value) : null,
        min: 0,
        max: maxDuration > 0 ? maxDuration : 1, // Prevent division by zero
      ),
    );
  }

  Widget _buildTimeDisplay(AudioProvider audioProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            audioProvider.formatTime(audioProvider.position),
            style: TextStyle(color: Colors.white, fontSize: 18.sp),
          ),
          Text(
            audioProvider.formatTime(audioProvider.duration),
            style: TextStyle(color: Colors.white, fontSize: 18.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButtons(AudioProvider audioProvider, BuildContext context) {
    // Check if previous button should be enabled
    final hasPrevious = audioProvider.getPreviousBhajan() != null;
    
    // Check if next button should be enabled
    final hasNext = audioProvider.getNextBhajan() != null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Previous button
        IconButton(
          icon: Icon(
            Icons.skip_previous,
            color: hasPrevious ? Colors.white : Colors.white.withOpacity(0.5),
            size: 70.sp,
          ),
          onPressed: hasPrevious ? () => _handlePrevious(context, audioProvider) : null,
        ),
        
        // Play/Pause button
        IconButton(
          icon: Icon(
            audioProvider.isPlaying
                ? Icons.pause_circle_filled
                : Icons.play_circle_filled,
            color: audio.isNotEmpty ? Colors.white : Colors.white.withOpacity(0.5),
            size: 80.sp,
          ),
          onPressed: audio.isNotEmpty ? () => audioProvider.togglePlayPause(audio) : null,
        ),
        
        // Next button
        IconButton(
          icon: Icon(
            Icons.skip_next,
            color: hasNext ? Colors.white : Colors.white.withOpacity(0.5),
            size: 70.sp,
          ),
          onPressed: hasNext ? () => _handleNext(context, audioProvider) : null,
        ),
      ],
    );
  }

  // Handle previous button click
  void _handlePrevious(BuildContext context, AudioProvider audioProvider) async {
    final prevBhajan = await audioProvider.playPrevious();
    
    if (prevBhajan != null) {
      // Stop current audio before navigation
      await audioProvider.stopAudio();
      
      // Navigate to the previous bhajan
      context.pushReplacement('/playing-screen', extra: {
        'index': audioProvider.bhajanList.indexOf(prevBhajan),
        'title': prevBhajan['text'],
        'image': prevBhajan['image'],
        'audio': prevBhajan['audio'],
      });
    }
  }

  // Handle next button click  
  void _handleNext(BuildContext context, AudioProvider audioProvider) async {
    final nextBhajan = await audioProvider.playNext();
    
    if (nextBhajan != null) {
      // Stop current audio before navigation
      await audioProvider.stopAudio();
      
      // Navigate to the next bhajan
      context.pushReplacement('/playing-screen', extra: {
        'index': audioProvider.bhajanList.indexOf(nextBhajan),
        'title': nextBhajan['text'],
        'image': nextBhajan['image'],
        'audio': nextBhajan['audio'],
      });
    }
  }
}