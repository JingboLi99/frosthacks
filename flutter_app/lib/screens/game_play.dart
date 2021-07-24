import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class GamePlay extends StatelessWidget {
  GamePlay({Key key}) : super(key: key);
  final myGame = MyGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GameWidget(game: myGame));
  }
}

class MyGame extends Game {
  static const int squareSpeed = 200;
  Rect squarePos;
  int squareDirection = -1;
  MyGame() {
    _buildHud();
  }

  @override
  Future<void> onLoad() async {
    squarePos = Rect.fromLTWH(size.x, 0, 10, 100);
  }

  static final squarePaint = BasicPalette.white.paint();

  @override
  void update(double dt) {
    squarePos = squarePos.translate(squareSpeed * squareDirection * dt, 0);

    if (squarePos.left < 0) {
      squarePos = Rect.fromLTWH(size.x, 0, 10, 100);
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(squarePos, squarePaint);
  }

  Widget _buildHud() {
    return IconButton(
        icon: Icon(Icons.pause, color: Colors.white, size: 30),
        onPressed: () {});
  }
}
