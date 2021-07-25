import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';

class WallObstacle extends PositionComponent {
  static const double wallWidth = 10;
  int wallSpeed = 125;
  int wallDirection = -1;

  Color color;
  Vector2 position;
  double wallHeight;
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

  WallObstacle(Vector2 position, double wallHeight, int score) {
    this.position = position;
    this.wallHeight = wallHeight;
    this.score = score;
  }

  @override
  Future<void> onLoad() async {
    wallPos = Rect.fromLTWH(
        position.x, position.y - wallHeight / 1.5, wallWidth, wallHeight);
    color = wallPaint();
  }

  @override
  void update(double dt) {
    super.update(dt);
    wallPos =
        wallPos.translate((wallSpeed + 15 * score) * wallDirection * dt, 0);

    if (wallPos.left <= 0) {
      shouldRemove = true;
    }
  }

  Color wallPaint() {
    var difficultyLevel = score ~/ 10;
    if (difficultyLevel > 2) {
      difficultyLevel = 2;
    }
    var random = new Random();
    int colorOptions = [3, 6, 8][difficultyLevel];
    int colorSelector = random.nextInt(colorOptions);
    Color wallColor = arrayOfColors[colorSelector];
    return wallColor;
  }

  @override
  void render(Canvas canvas) {
    var wall_paint = Paint();
    wall_paint.color = color;
    canvas.drawRect(wallPos, wall_paint);
    super.render(canvas);
  }
}
