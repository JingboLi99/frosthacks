import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

enum WallType { Red, Blue, Green }

class WallData {
  final int redValue;
  final int blueValue;
  final int greenValue;

  const WallData({
    @required this.redValue,
    @required this.blueValue,
    @required this.greenValue,
  });
}

class WallObstacle extends PositionComponent {
  WallData wallData;
  static Random random = Random();
  static const int squareSpeed = 100;
  Rect squarePos;
  int squareDirection = -1;

  WallObstacle(WallType wallType) {
    wallData = ;
  }

  static const Map<WallType, WallData> wallDetails = {
    WallType.Red: WallData(
      redValue: 255,
      blueValue: 0,
      greenValue: 0,
    ),
    WallType.Blue: WallData(
      redValue: 0,
      blueValue: 255,
      greenValue: 0,
    ),
    WallType.Green: WallData(
      redValue: 0,
      blueValue: 0,
      greenValue: 255,
    )
  };

  @override
  Future<void> update(double dt) async {
    super.update(dt);
    this.x -= squareSpeed * dt;

    if (this.x < (-this.width)) {
      this.x = this.width;
    }
  }

  @override
  bool destroy() {
    return (this.x < (-this.width));
  }


}