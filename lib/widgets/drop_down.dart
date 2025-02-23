import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThreeDotMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Three Dot Menu'),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 30.sp, // Responsive size using screenutil
            ),
            onSelected: (value) {
              // Perform action based on selected item
              if (value == 'Profile') {
                print('Profile Clicked');
              } else if (value == 'Settings') {
                print('Settings Clicked');
              } else if (value == 'Logout') {
                print('Logout Clicked');
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Profile',
                child: Text('Profile'),
              ),
              PopupMenuItem(
                value: 'Settings',
                child: Text('Settings'),
              ),
              PopupMenuItem(
                value: 'Logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: Center(child: Text('Click the three-dot menu in AppBar!')),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ThreeDotMenu(),
  ));
}
