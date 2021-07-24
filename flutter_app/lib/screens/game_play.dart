import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class GamePlay extends StatelessWidget {
  GamePlay({Key key}) : super(key: key);
  final myGame = MyGame();

  Widget pauseMenuBuilder(BuildContext buildContext, MyGame game) {
    return Center(
        child: Container(
            width: 100,
            height: 100,
            color: const Color(0XFFFF0000),
            child: const Center(
              child: Text("Paused"),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GameWidget(
      game: myGame,
      overlayBuilderMap: {'PauseMenu': pauseMenuBuilder},
    ));
  }
}

class MyGame extends BaseGame with TapDetector {
  static const int squareSpeed = 400;
  Rect squarePos;
  int squareDirection = 1;
  SpriteComponent pauseButton;
  final pauseButtonPosition = Vector2(0, 0);
  final pauseButtonSize = Vector2(50, 50);
  bool pauseButtonPressed = false;

  @override
  Future<void> onLoad() async {
    squarePos = Rect.fromLTWH(0, 0, 100, 100);

    // renders pause button
    final pauseSprite = await Sprite.load('pause.jpg');
    pauseButton = SpriteComponent(size: pauseButtonSize, sprite: pauseSprite);
    pauseButton.position = pauseButtonPosition;
    add(pauseButton);
  }

  static final squarePaint = BasicPalette.white.paint();

  @override
  void update(double dt) {
    super.update(dt);
    squarePos = squarePos.translate(squareSpeed * squareDirection * dt, 0);

    if (squareDirection == 1 && squarePos.right > size.x) {
      squareDirection = -1;
    } else if (squareDirection == -1 && squarePos.left < 0) {
      squareDirection = 1;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(squarePos, squarePaint);
  }

  @override
  void onTapUp(TapUpInfo event) {
    if (overlays.isActive('PauseMenu')) {
      overlays.remove("PauseMenu");
      resumeEngine();
    } else {
      final pauseButtonLoc = pauseButtonPosition & pauseButtonSize;
      // pause button pressed
      pauseButtonPressed =
          pauseButtonLoc.contains(event.eventPosition.game.toOffset());
      if (pauseButtonPressed) {
        pauseEngine();
        overlays.add('PauseMenu');
      }
    }
  }
}
