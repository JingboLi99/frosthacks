import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Characters/wall_obstacle.dart';

class GamePlay extends StatelessWidget {
  GamePlay({Key key}) : super(key: key);
  final myGame = MyGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GameWidget(game: myGame));
  }
}

class MyGame extends BaseGame {
  MyGame() {
    _buildHud();
  }

  @override
  Future<void> onLoad() async {
    WallObstacle wall = WallObstacle();
    add(wall);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  Widget _buildHud() {
    return IconButton(
        icon: Icon(Icons.pause, color: Colors.white, size: 30),
        onPressed: () {});
  }
}
