import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static InterstitialAd? interstitialAd;
  static double lastDisplayingTime = 0;

  Future<void> loadGoogleAds() async {
    AdHelper ads = AdHelper();
    ads.loadInterstitialAd();
  }

  static showAds({required Function dismiss}) {
    double currentTime = DateTime.now().microsecondsSinceEpoch/1000000;

    if (AdHelper.interstitialAd == null) {
      dismiss();
      AdHelper().loadInterstitialAd();
      return;
    }
    if ((AdHelper.interstitialAd != null) && (currentTime- 18000) > lastDisplayingTime) {
      AdHelper.lastDisplayingTime = DateTime.now().microsecondsSinceEpoch/1000000;
      AdHelper.interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ads) {
          AdHelper().loadInterstitialAd();
          dismiss();
          return;
        },
      );
      AdHelper.interstitialAd?.show();
    } else {
      dismiss();
    }
  }

  Future<void> initGoogleMobileAds() async {
    // TODO: Initialize Google Mobile Ads SDK
    MobileAds.instance
      ..initialize()
      ..updateRequestConfiguration(RequestConfiguration(
        testDeviceIds: <String>['2319471873f7024999e7933a8a89954b'],
      ));
  }

  void loadInterstitialAd() {
    AdHelper.interstitialAd = null;

    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ads) {
          AdHelper.interstitialAd = ads;
        },
        onAdFailedToLoad: (err) {
          AdHelper.interstitialAd = null;
        },
      ),
    );
  }

  String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7356825362262138/3351981056';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7356825362262138/5483320371';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-7356825362262138/7363978250";
    } else if (Platform.isIOS) {
      return "ca-app-pub-7356825362262138/6225556400";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5224354917";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}