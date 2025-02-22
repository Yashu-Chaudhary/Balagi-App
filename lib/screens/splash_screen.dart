import 'package:balagi_bhjans/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      context.go('/');
    });
    return Scaffold(
      backgroundColor: Color(0xFFFF6733),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 50.sp,
                ),
                Center(
                  child: Text(
                    'जय श्री राम',
                    style: TextStyle(
                      fontSize: 90.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      PImages.splashImage,
                    ),
                  ),
                ),
              ),
              // child: Image.asset(
              //   'assets/splash_image.png', // Replace with your image path
              //   width: 200,
              //   height: 200,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
