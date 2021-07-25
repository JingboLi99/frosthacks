import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';

class WallObstacle extends PositionComponent {
  static const int wallSpeed = 100;
  int wallDirection = -1;

  Paint color;
  Vector2 position;
  Rect wallPos;
  int levelOfDifficulty;

  Random random;
  List arrayOfColors = [
    Color.fromRGBO(255, 0, 0, 1),
    Color.fromRGBO(0, 255, 0, 1),
    Color.fromRGBO(0, 0, 255, 1),
    Color.fromRGBO(255, 255, 0, 1),
    Color.fromRGBO(255, 0, 255, 1),
    Color.fromRGBO(0, 255, 255, 1),
    Color.fromRGBO(255, 255, 255, 1),
    Color.fromRGBO(0, 0, 0, 1),
  ];

  WallObstacle(Vector2 position, int levelOfDifficulty) {
    this.position = position;
    this.levelOfDifficulty = levelOfDifficulty;
  }

  @override
  Future<void> onLoad() async {
    wallPos = Rect.fromLTWH(position.x, position.y / 2, 10, 100);
    color = wallPaint();
  }

  @override
  void update(double dt) {
    super.update(dt);
    wallPos = wallPos.translate(wallSpeed * wallDirection * dt, 0);

    if (wallPos.left <= 0) {
      shouldRemove = true;
    }
  }

  Paint wallPaint() {
    var random = new Random();
    int colorOptions = [3, 6, 8][levelOfDifficulty - 1];
    int colorSelector = random.nextInt(colorOptions);
    Color wallColor = arrayOfColors[colorSelector];
    print(wallColor);
    return Paint()..color = wallColor;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(wallPos, color);
    super.render(canvas);
  }
}
