import 'dart:math';
import 'dart:ui';
import 'package:stay/stay-game.dart';
import 'package:flutter/material.dart';

class Ball{
  final StayGame game;
  Rect ballRect;
  Paint ballPaint;
  bool isStart = false;
  int count = 0;
  double timer = 0;
  double speed = 10;

  double updateX;
  double updateY;

  bool isDead = false;

  static bool restart = false;

  Ball(this.game, double x, double y){
    ballRect = Rect.fromLTWH(x, y, game.ballSize, game.ballSize);
    ballPaint = Paint();
    ballPaint.color = Colors.white;
  }

  bool getRestart(){
    return restart;
  }

  void render(Canvas c){
    c.drawRect(ballRect, ballPaint);
  }

  void update(double t){
    timer += t*4;
    double gravity = 12;
    double radian = 0.872665;
    if(isStart && isDead == false){
      double speedX = speed * cos(radian);
      double speedY = speed * sin(radian);
      updateX = speedX * timer;
      updateY = (speedY * timer) - (0.5 * gravity * timer * timer);

      if(count % 2 == 0){ //going right
        if(ballRect.right > game.screenSize.width){
          updateX = 0;
        }
        ballRect = ballRect.translate(updateX, -updateY);
      } else { // going left
        if(ballRect.left < 0.5){
          updateX = 0;
        }
        ballRect = ballRect.translate(-updateX, -updateY);
      }
      if(ballRect.bottom > game.screenSize.height){
        isDead = true;
      }
      if(ballRect.top < 0){
        isDead = true;
      }
    }
    if(isDead == true){
      restart = true;
      game.initialize();
    }
  }

  void onTap(){
    timer = 0;
    isStart = true;
    restart = false;
    count += 1;
  }
}