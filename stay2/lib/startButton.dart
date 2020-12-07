import 'package:flutter/material.dart';
import 'package:stay/stay-game.dart';

class StartButton{
  final StayGame game;
  TextPainter painter;
  Offset position;
  double fontSize;

  StartButton(this.game){
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr
    );
    fontSize = game.screenSize.width * 0.045;
  }

  void render(Canvas c){
    painter.paint(c, position);
  }

  void update(double t){
    int highscore = (game.storage.getInt('highscore') ?? 0);
    painter.text = TextSpan(
        text: "tap to bounce left\n"
            "tap again to bounce right\n"
            "tap again to bounce left\n"
            "you know what I mean...\n\n"
            "don't touch the ceiling\n"
            "don't touch the ground\n"
            "don't touch the incoming bar\n"
            "easy, right?\n\n"
            "bar off screen -> score++",
        style: TextStyle(
            color: Colors.white,
            fontSize: fontSize
        )
    );
    painter.layout();
    position = Offset(
        (game.screenSize.width / 2) - (painter.width / 2),
        // game.screenSize.width / 2,
        (game.screenSize.height * 0.25) - (painter.width / 2)
    );
  }

}