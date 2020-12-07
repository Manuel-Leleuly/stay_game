import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stay/stay-game.dart';

SharedPreferences storage;
StayGame game;

const String testDevice = 'E8D4DB21A1FC5019844AE98BE4EB7337';
// const String testDevice = 'Mobile_ID';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Util stayUtil = Util();
  await stayUtil.fullScreen();
  await stayUtil.setOrientation(DeviceOrientation.portraitUp);

  // SharedPreferences storage = await SharedPreferences.getInstance();
  // StayGame game = StayGame(storage);
  // runApp(game.widget);
  storage = await SharedPreferences.getInstance();
  game = StayGame(storage);
  runApp(RunApp());

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTap = game.onTap;
  stayUtil.addGestureRecognizer(tapper);
}

class RunApp extends StatefulWidget {
  @override
  _RunAppState createState() => _RunAppState();
}

class _RunAppState extends State<RunApp> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game']
  );
  BannerAd _bannerAd;
  BannerAd createBannerAd(){
    return BannerAd(
      adUnitId: 'ca-app-pub-6071397204389523/6658590738',
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event){
        print("Banner ad $event");
      }
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    FirebaseAdMob.instance.initialize(
      appId: 'ca-app-pub-6071397204389523~7181033593'
    );
    _bannerAd = createBannerAd()..load()..show();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: game.widget,
    );
  }
}

