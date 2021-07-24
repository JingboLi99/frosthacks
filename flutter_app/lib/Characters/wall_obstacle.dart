import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter_app/screens/game_play.dart';

class WallObstacle extends PositionComponent {
  static const int wallSpeed = 100;
  static final wallPaint = BasicPalette.white.paint();
  int wallDirection = -1;

  Rect wallPos;

  @override
  Future<void> onLoad() async {
    wallPos = Rect.fromLTWH(, 500, 10, 100);
  }

  @override
  void update(double dt) {
    super.update(dt);
    wallPos = wallPos.translate(wallSpeed * wallDirection * dt, 0);

    if (wallPos.left < 0) {
      wallPos = Rect.fromLTWH(0, size.y / 2, 10, 100);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(wallPos, wallPaint);
  }
}
