import 'package:balagi_bhjans/ad_manager/ad_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdProvider extends ChangeNotifier {
  late BannerAd _bannerAd;
  bool _isBannerAdLoaded = false;

  bool get isBannerAdLoaded => _isBannerAdLoaded;
  BannerAd get bannerAd => _bannerAd;

  AdProvider() {
    _initializeBannerAd();
  }

  void _initializeBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: PAddConstants.bannerAd,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _isBannerAdLoaded = true;
          notifyListeners();
        },
        onAdFailedToLoad: (ad, error) {
          print(error);
          ad.dispose();
        },
      ),
      request: AdRequest(),
    )..load();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bannerAd.dispose();
    super.dispose();
  }
}
