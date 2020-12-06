import 'dart:async';
import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stay/ball.dart';
import 'package:stay/barrier.dart';
import 'package:stay/barriers.dart';
import 'package:stay/highscoreText.dart';
import 'package:stay/scoreText.dart';
import 'package:stay/startButton.dart';
import 'package:stay/stateGame.dart';
import 'package:stay/titleText.dart';

const String testDevice = 'Mobile_ID';

class StayGame extends Game{
  final SharedPreferences storage;
  Size screenSize;
  double ballSize;
  double barrierSize;
  Ball ball;
  Barriers barrierSpawner;
  List<Barrier> barriers;
  Rect bgRect;
  Paint bgPaint;
  int score;
  ScoreText scoreText;
  StateGame state;
  HighscoreText highscoreText;
  StartButton startButton;
  TitleText titleText;

  bool isStart = false;

  Random random;

  StayGame(this.storage){
    initialize();
  }

  void initialize() async{
    resize(await Flame.util.initialDimensions());
    state = StateGame.menu;
    barriers = List<Barrier>();
    random = Random();
    barrierSpawner = Barriers(this);
    barrierSpawner.setIsStart(false);
    spawnBall();
    score = 0;
    scoreText = ScoreText(this);
    highscoreText = HighscoreText(this);
    startButton = StartButton(this);
    titleText = TitleText(this);
  }

  void spawnBall(){
    double x = (screenSize.width / 2) - (ballSize / 2);
    double y = (screenSize.height / 2) - (ballSize / 2);
    // y = screenSize.height - ballSize;
    ball = Ball(this, x, y);
  }

  void spawnBarrier() async{
    double x = random.nextDouble() * (screenSize.width - barrierSize);
    barriers.add(Barrier(this, x, -10));
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    bgPaint = Paint();
    // bgPaint.color = Color(0xff576574);
    bgPaint.color = Colors.black;
    canvas.drawRect(bgRect, bgPaint);
    if(state == StateGame.menu){
      ball.render(canvas);
      highscoreText.render(canvas);
      startButton.render(canvas);
      titleText.render(canvas);
      //
    } else {
      highscoreText.render(canvas);
      ball.render(canvas);
      barriers.forEach((Barrier barrier) => barrier.render(canvas));
      scoreText.render(canvas);
    }
  }

  @override
  void update(double t){
    // TODO: implement update
    if(state == StateGame.menu){
      titleText.update(t);
      highscoreText.update(t);
      startButton.update(t);
      ball.update(t);
    } else {
      highscoreText.update(t);
      ball.update(t);
      scoreText.update(t);
      barrierSpawner.update(t);
      barriers.forEach((Barrier barrier) {
        if(checkCollision(ball, barrier) == false && ball.isDead == false){
          barrier.update(t);
        } else {
          barrier.setCollide(true);
          ball.isDead = true;
        }
        if(ball.getRestart() == true){
          barrier.setIsStart(false);
          barrier.setCollide(false);
        }
      });
      barriers.removeWhere((Barrier barrier) => barrier.isOffScreen);
    }
  }

  @override
  void resize(Size size) {
    // TODO: implement resize
    super.resize(size);
    screenSize = size;
    ballSize = screenSize.width / 10;
    barrierSize = screenSize.width / 1.7;
  }

  void onTap(){
    if(state == StateGame.menu){
      state = StateGame.playing;
    } else {
      isStart = true;
      ball.onTap();
      barrierSpawner.onTap();
      barriers.forEach((Barrier barrier) {
        barrier.onTap();
      });
    }
  }
  
  bool checkCollision(Ball ball, Barrier barrier){
    var newRect = ball.ballRect.intersect(barrier.barrierRect);
    return newRect.height > 0 && newRect.width > 0;
  }
}