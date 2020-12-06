import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stay/stay-game.dart';

SharedPreferences storage;
StayGame game;

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: game.widget,
    );
  }
}

