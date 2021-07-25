import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';

class WallObstacle extends PositionComponent {
  static const double wallHeight = 100;
  static const double wallWidth = 10;
  static const int wallSpeed = 100;
  int wallDirection = -1;

  Paint color;
  Vector2 position;
  Rect wallPos;
  int score;

  Random random;
  List arrayOfColors = [
    Color(0xfff44336),
    Color(0xff2196f3),
    Color(0xffffeb3b),
    Color(0xff8a6c94),
    Color(0xfff99738),
    Color(0xff90c097),
    Color(0xffffffff),
    Color(0xffb19676),
  ];

  WallObstacle(Vector2 position, int score) {
    this.position = position;
    this.score = score;
  }

  @override
  Future<void> onLoad() async {
    wallPos = Rect.fromLTWH(position.x, position.y - wallHeight / 1.5, wallWidth, wallHeight);
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
    int colorOptions = [3, 6, 8][1];
    int colorSelector = random.nextInt(colorOptions);
    Color wallColor = arrayOfColors[colorSelector];
    return Paint()..color = wallColor;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(wallPos, color);
    super.render(canvas);
  }
}
