import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:stay/stay-game.dart';

class HighscoreText{
  final StayGame game;
  TextPainter painter;
  Offset position;
  double fontSize;

  HighscoreText(this.game){
    painter = TextPainter(
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr
    );
    position = Offset.zero;
    fontSize = game.screenSize.width * 0.08;
  }

  void render(Canvas c){
    painter.paint(c, position);
  }

  void update(double t){
    int highscore = (game.storage.getInt('highscore') ?? 0);
    painter.text = TextSpan(
        text: "Highscore: $highscore",
            style: TextStyle(
            color: Colors.white,
            fontSize: fontSize
        )
    );
    painter.layout();
    position = Offset(
        (game.screenSize.width / 2) - (painter.width / 2),
        (game.screenSize.height * 0.15) - (painter.width / 2)
    );
  }

  void onTap(){
    if(game.ball.isDead){
      // reset game
    }
  }
}