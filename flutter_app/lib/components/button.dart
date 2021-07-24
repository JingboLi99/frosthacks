import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/gestures.dart';
import 'package:flutter_app/screens/game_play.dart';

class Button extends PositionComponent with Tappable, HasGameRef<MyGame>{

  Vector2 size;
  Color colour;
  bool down = false;

  Button(Vector2 size, Color colour) {
    this.size = size;
    this.colour = colour;
  }

  @override
  void render(Canvas canvas) {
    var grid = Rect.fromLTWH(x, y, width, height);
    canvas.drawRect(grid, Paint()..color = this.colour);
    super.render(canvas);
  }

  @override
  bool onTapDown(TapDownInfo info){
    down = !down;
    gameRef.buttonToggled(this.colour, down);
    return true;
  }

  @override
  bool onTapUp(TapUpInfo info) {
    return super.onTapUp(info);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  Future<void> onLoad() {
    return super.onLoad();
  }



}