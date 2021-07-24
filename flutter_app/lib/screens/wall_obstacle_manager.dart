import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter_app/screens/wall_obstacle.dart';

class WallObstacleManager extends Component {
  Random random;
  Timer timer;
  int spawnLevel;
  
  WallObstacleManager() {
    random = Random();
    spawnLevel = 0;
    timer = Timer(4, repeat: true, callback: () {
      spawnRandomWall();
    });
  }

  /// This method is responsible for spawning a wall of random [WallType]
  void spawnRandomWall() {
    final randomNumber = random.nextInt(WallType.values.length);
    final randomWallType = WallType.values.elementAt(randomNumber);
    final newWall = WallObstacle(randomWallType);
    gameRef.addLater(newWall);
  }

  @override
  Future<void> onLoad() async{
    super.onLoad();
  }

  /// This method starts the [timer]. It get called when this [WallManager]
  /// gets added to an [Game] instance.
  @override
  void onMount() {
    super.onMount();
    timer.start();
  }

  @override
  void render(Canvas c) {}

  @override
  void update(double dt) {
    timer.update(dt);

    var newSpawnLevel = (gameRef.score ~/ 500);
    if (spawnLevel < newSpawnLevel) {
      spawnLevel = newSpawnLevel;

      var newWaitTime = (4 / (1 + (0.1 * spawnLevel)));

      timer.stop();
      timer = Timer(newWaitTime, repeat: true, callback: (){
        spawnRandomWall();
      });
      timer.start();
    }
  }

  void reset() {
    spawnLevel = 0;
    timer = Timer(4, repeat: true, callback: () {
      spawnRandomWall();
    });
    timer.start();
  }
}