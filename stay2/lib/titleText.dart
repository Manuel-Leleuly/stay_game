import 'package:flutter/material.dart';
import 'package:stay/stay-game.dart';

class TitleText{
  final StayGame game;
  TextPainter painter;
  Offset position;
  double fontSize;

  TitleText(this.game){
    painter = TextPainter(
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr
    );
    fontSize = game.screenSize.width * 0.11;
  }

  void render(Canvas c){
    painter.paint(c, position);
  }

  void update(double t){
    int highscore = (game.storage.getInt('highscore') ?? 0);
    painter.text = TextSpan(
        text: "Stay?",
        style: TextStyle(
            color: Colors.white,
            fontSize: fontSize
        )
    );
    painter.layout();
    position = Offset(
        (game.screenSize.width / 2) - (painter.width / 2),
        // game.screenSize.width / 2,
        (game.screenSize.height * 0.7) - (painter.width / 2)
    );
  }

}