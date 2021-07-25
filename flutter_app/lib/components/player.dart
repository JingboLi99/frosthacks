import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter_app/screens/game_play.dart';

class Player extends PositionComponent with HasGameRef<MyGame>{

  Color colour;
  Vector2 position;
  Vector2 size;

  Player(Vector2 position, Vector2 size, Color colour) {
    this.position = position;
    this.size = size;
    this.colour = colour;
  }

  Paint paint() {
    return Paint()..color = this.colour;
  }

  @override
  void render(Canvas canvas) {
    var character = Rect.fromLTWH(position.x, position.y, width, height);
    canvas.drawRect(character, paint());

    super.render(canvas);
  }

  void updateColour(Color newColour) {
    this.colour = newColour;
  }

  //not sure if necessary just added these 2 to be safe
  @override
  Future<void> onLoad() {
    return super.onLoad();
  }
  @override
  void update(double dt) {
    super.update(dt);
  }


}