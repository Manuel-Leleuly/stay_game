import 'package:stay/stay-game.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Barrier{
  final StayGame game;
  double height;
  double width;
  Rect barrierRect;
  Paint barrierPaint;
  static bool isStart = false;
  bool isOffScreen = false;

  static int countBarrier = 0;

  static double speed = 10;

  static double timer = 0;

  static int tapCount = 0;

  static bool collide = false;

  void setCollide(bool newCollide){
    collide = newCollide;
  }

  void setIsStart(bool newIsStart){
    isStart = newIsStart;
  }

  void incrementSpeed(double newSpeed){
    if(speed < 50){
      speed += newSpeed;
    }
  }

  bool barrierCountIsMet(int number){
    return countBarrier % number == 0;
  }

  Barrier(this.game, double left, double top){
    height = 10;
    width = game.barrierSize;
    barrierRect = Rect.fromLTWH(left, top, width, height);
    barrierPaint = Paint();
    barrierPaint.color = Colors.white;
  }

  void render(Canvas c){
    c.drawRect(barrierRect, barrierPaint);
  }

  void update(double t){
    if(isStart && collide == false){
      barrierRect = barrierRect.translate(0, height * speed * t);

      if(barrierRect.top > game.screenSize.height){
        isOffScreen = true;
        countBarrier += 1;
        game.score += 1;

        if(game.score > (game.storage.getInt('highscore') ?? 0)){
          game.storage.setInt('highscore', game.score);
        }
      }
    }
  }

  void onTap(){
    isStart = true;
  }
}