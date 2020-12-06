import 'dart:async';

import 'package:stay/stay-game.dart';

import 'barrier.dart';

class Barriers{
  final StayGame game;
  final int intervalChange = 3;
  final int maxSpawnInterval = 3000;
  final int minSpawnInterval = 1000;

  int currentInterval;
  int nextSpawn;

  static bool isStart = false;

  Barriers(this.game){
    initialize();
  }

  void setIsStart(bool newIsStart){
    isStart = newIsStart;
  }

  void initialize(){
    stopBarriers();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void stopBarriers(){
    game.barriers.forEach((Barrier barrier) => barrier.setCollide(true));
  }

  void update(double t){
    if(isStart == true){
      int now = DateTime.now().millisecondsSinceEpoch;
      // print(now >= nextSpawn);
      if(now >= nextSpawn){
        game.spawnBarrier();
        nextSpawn = now + currentInterval;
      }
    }
  }

  void onTap(){
    isStart = true;
  }
}