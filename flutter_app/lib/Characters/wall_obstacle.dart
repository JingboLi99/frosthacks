import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class WallObstacle extends PositionComponent {
  static const int wallSpeed = 100;
  int wallDirection = -1;

  Color color;
  Vector2 position;
  Rect wallPos;

  WallObstacle(Vector2 position) {
    this.position = position;
  }

  @override
  Future<void> onLoad() async {
    wallPos = Rect.fromLTWH(position.x, position.y / 2, 10, 100);
    print(position);
  }

  @override
  void update(double dt) {
    super.update(dt);
    wallPos = wallPos.translate(wallSpeed * wallDirection * dt, 0);

    if (wallPos.left <= 0) {
      shouldRemove = true;
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(wallPos, BasicPalette.white.paint());
    super.render(canvas);
  }
}
