import 'package:balagi_bhjans/ad_manager/ad_manager.dart';
import 'package:balagi_bhjans/constants/images.dart';
import 'package:balagi_bhjans/widgets/bhjan_card.dart';
import 'package:balagi_bhjans/widgets/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

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
      'text': 'हनुमानाष्टक',
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

  @override
  Widget build(BuildContext context) {
    final adProvider = Provider.of<AdProvider>(
      context,
    );
    return Scaffold(
      bottomNavigationBar: adProvider.isBannerAdLoaded
          ? SizedBox(
              width: adProvider.bannerAd.size.width.toDouble(),
              height: adProvider.bannerAd.size.height.toDouble(),
              child: AdWidget(ad: adProvider.bannerAd),
            )
          : null,
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
            DropDown()
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
                children: bhajanList.asMap().entries.map(
                  (entry) {
                    int index = entry.key;
                    var bhajan = entry.value;
                    return BhjanCard(
                      text: bhajan['text'],
                      image: bhajan['image'],
                      num: bhajan['num'],
                      onTap: () {
                        context.push(
                          '/playing-screen',
                          extra: {
                            'index': index,
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
