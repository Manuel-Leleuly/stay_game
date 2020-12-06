import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:stay/stay-game.dart';

class ScoreText{
  final StayGame game;
  TextPainter painter;
  Offset position;
  double fontSize;

  ScoreText(this.game){
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr
    );
    position = Offset.zero;
    fontSize = game.screenSize.width * 0.19;
  }

  void render(Canvas c){
    painter.paint(c, position);
  }

  void update(double t){
    if((painter.text ?? '') != game.score.toString()){
      painter.text = TextSpan(
        text: game.score.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize
        )
      );
      painter.layout();
      position = Offset(
          (game.screenSize.width / 2) - (painter.width / 2),
          (game.screenSize.height * 0.2) - (painter.width / 2)
      );
    }
  }

  void onTap(){
    if(game.ball.isDead){
      // reset game
    }
  }
}