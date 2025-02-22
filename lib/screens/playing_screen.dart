import 'package:audioplayers/audioplayers.dart';
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
    final audioProvider = Provider.of<AudioProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFFFF6733),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFFF6733),
        title: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 50),
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
      ),
      body: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Column(
          children: [
            SizedBox(height: 80.sp),
            Container(
              width: 420.sp,
              height: 400.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.sp),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 80.sp),

            // audio slider
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.white,
                inactiveTrackColor: Colors.white.withOpacity(0.3),
                thumbColor: Colors.white,
                overlayColor: Colors.white.withOpacity(0.2),
                trackHeight: 4.0,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
              ),
              child: Slider(
                value: audioProvider.position.inSeconds.toDouble(),
                onChanged: (value) => audioProvider.handleSeek(value),
                min: 0,
                max: audioProvider.position.inSeconds.toDouble(),
              ),
            ),

            //?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  audioProvider.formatDuration(audioProvider.position),
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
                Text(
                  audioProvider.formatDuration(audioProvider.duration),
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
              ],
            ),

            // ?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Previous Button
                IconButton(
                  icon: Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                    size: 70.sp,
                  ),
                  onPressed: () {
                    // audioProvider.playPrevious();
                  },
                ),

                // Play / Pause Button
                IconButton(
                    icon: Icon(
                      audioProvider.isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      color: Colors.white,
                      size: 80.sp,
                    ),
                    onPressed: audioProvider.handlePlayPause),

                // Next Button
                IconButton(
                  icon: Icon(
                    Icons.skip_next,
                    color: Colors.white,
                    size: 70.sp,
                  ),
                  onPressed: () {
                    // audioProvider.playNext();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // String _formatDuration(Duration duration) {
  //   String minutes = duration.inMinutes.toString().padLeft(2, '0');
  //   String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
  //   return "$minutes:$seconds";
  // }
}
