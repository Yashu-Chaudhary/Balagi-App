import 'package:balagi_bhjans/constants/images.dart';
import 'package:balagi_bhjans/widgets/bhjan_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Map<String, dynamic>> bhajanList = [
    {
      'text': 'श्री राम स्तुति',
      'image': PImages.ramjiIstuti,
      'num': 1,
      'audio': ''
    },
    {
      'text': 'हनुमान चालीसा',
      'image': PImages.splashImage,
      'num': 2,
      'audio': 'chalisa.mp3'
    },
    {'text': 'सुंदरकांड', 'image': PImages.sundarkand, 'num': 3, 'audio': ''},
    {
      'text': 'राम रक्षा स्तोत्र',
      'image': PImages.ramRakshaSutra,
      'num': 4,
      'audio': ''
    },
    {
      'text': 'अंजनी पुत्र स्तुति',
      'image': PImages.anjaniPutraStuti,
      'num': 5,
      'audio': ''
    },
    {
      'text': 'रामायण आरती',
      'image': PImages.ramayanArti,
      'num': 6,
      'audio': ''
    },
    {
      'text': 'हनुमान जी आरती',
      'image': PImages.hanumnajiArti,
      'num': 7,
      'audio': ''
    },
    {'text': 'बजरंग बाण', 'image': PImages.bajarangBaan, 'num': 8, 'audio': ''},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF6733),
      appBar: AppBar(
        backgroundColor: Color(0xFFFF6733),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 20.sp),
            Container(
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
              child: Center(
                child: Text(
                  'जय श्री राम',
                  style: TextStyle(
                    fontSize: 50.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // ------------
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 30.sp,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Column(
          children: [
            SizedBox(height: 40.sp),
            // ?Image and text
            GestureDetector(
              child: Row(
                children: [
                  Container(
                    height: 100.sp,
                    width: 150.sp,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2.sp, color: Colors.white),
                      image: DecorationImage(
                        image: AssetImage(PImages.splashImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.sp),
                  Text(
                    'ॐ हं हनुमते नमः',
                    style: TextStyle(
                      fontSize: 35.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 40.sp),

            // !Grid View
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.sp,
                  mainAxisSpacing: 8.sp,
                  childAspectRatio: 1.1,
                ),
                children: bhajanList.map(
                  (bhajan) {
                    return BhjanCard(
                      text: bhajan['text'],
                      image: bhajan['image'],
                      num: bhajan['num'],
                      onTap: () {
                        context.push(
                          '/playing-screen',
                          extra: {
                            'title': bhajan['text'],
                            'image': bhajan['image'],
                            'audio': bhajan['audio'],
                          },
                        );
                      },
                    );
                  },
                ).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
