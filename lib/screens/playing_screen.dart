import 'package:balagi_bhjans/provider/audio_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PlayingScreen extends StatelessWidget {
  const PlayingScreen({
    super.key,
    required this.title,
    required this.image,
    required this.audio,
  });

  final String title;
  final String image;
  final String audio;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AudioProvider>().playAudio(audio);
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
                _buildControlButtons(audioProvider),
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
        value: currentPosition.clamp(0, maxDuration),
        onChanged: maxDuration > 0 ? (value) => audioProvider.seekAudio(value) : null,
        min: 0,
        max: maxDuration,
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

  Widget _buildControlButtons(AudioProvider audioProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.skip_previous,
            color: Colors.white,
            size: 70.sp,
          ),
          onPressed: null,
        ),
        IconButton(
          icon: Icon(
            audioProvider.isPlaying
                ? Icons.pause_circle_filled
                : Icons.play_circle_filled,
            color: Colors.white,
            size: 80.sp,
          ),
          onPressed: () => audioProvider.togglePlayPause(audio),
        ),
        IconButton(
          icon: Icon(
            Icons.skip_next,
            color: Colors.white,
            size: 70.sp,
          ),
          onPressed: null,
        ),
      ],
    );
  }
}
