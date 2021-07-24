
import 'dart:ui';
import 'package:flame/components.dart';

class Player {

  Color colour;
  Vector2 position;
  Vector2 size;

  Player(Vector2 position, Vector2 size, Color colour) {
    this.position = position;
    this.size = size;
    this.colour = colour;
  }

  Paint paint() {
    return Paint()
      ..color = this.colour;
  }

  @override
  void render(Canvas canvas) {
    var character = Rect.fromLTWH(position.x, position.y, size.x, size.y);
    canvas.drawRect(character, paint());
  }

  void updateColour(Color newColour) {
    this.colour = newColour;
  }
}