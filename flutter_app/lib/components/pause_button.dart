import 'package:flame/components.dart';
import 'package:flame/gestures.dart';
import 'package:flutter_app/screens/game_play.dart';

class PauseButton extends SpriteComponent with Tappable, HasGameRef<MyGame> {
  final String pause_icon = "pause.jpg";
  static var pauseButtonSize = Vector2(50.0, 50.0);
  static var pauseButtonPosition = Vector2(0, 0);
  var pauseComponent;

  PauseButton(Sprite pauseSprite)
      : super(size: PauseButton.pauseButtonSize, sprite: pauseSprite) {
    super.position = pauseButtonPosition;
  }

  @override
  bool onTapDown(TapDownInfo info) {
    gameRef.pauseEngine();
    gameRef.overlays.add('PauseMenu');
    return true;
  }
}
