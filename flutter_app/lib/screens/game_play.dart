import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/components/button.dart';
import 'package:flutter_app/components/pause_button.dart';
import 'package:flutter_app/components/player.dart';
import 'package:flutter_app/components/wall_obstacle.dart';

class GamePlay extends StatelessWidget {
  GamePlay({Key key}) : super(key: key);
  final myGame = MyGame();

  Widget pauseMenuBuilder(BuildContext buildContext, MyGame game) {
    return Center(
        child: Container(
            width: 200,
            height: 200,
            color: const Color(0XFFFF0000),
            child: Card(
                child: Column(children: [
              Text("Paused", style: TextStyle(fontSize: 28)),
              ElevatedButton(
                  child: Text("Resume", style: TextStyle(fontSize: 28)),
                  onPressed: () {
                    game.overlays.remove("PauseMenu");
                    game.resumeEngine();
                  }),
              ElevatedButton(
                  child: Text("Exit", style: TextStyle(fontSize: 28)),
                  onPressed: SystemNavigator.pop),
            ]))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GameWidget(
            game: myGame, overlayBuilderMap: {'PauseMenu': pauseMenuBuilder}));
  }
}

class MyGame extends BaseGame with HasTappableComponents {
  //For the Player
  Size screenSize;
  Player player;

  //For the Grid
  double cardSize = 60;
  double spacer = 20.0;
  List<Button> grid = [];
  List<Color> coloursChosen = [];

  //For wall obstacles
  int difficultyLevel = 1;
  int score = 0;
  double elapsedTime = 0;
  int wallTimeInterval = 4;
  List wallArray = [];

  //to calculate screen size
  void calScreenSize() {
    screenSize = Size(canvasSize.toOffset().dx, canvasSize.toOffset().dy);
  }

  Future<void> addPauseButton() async {
    // renders pause button
    final pauseSprite = await Sprite.load('pause.jpg');
    SpriteComponent pauseButton = PauseButton(pauseSprite);
    add(pauseButton);
  }

  //grid creation method and helpers
  void addGrid() {
    double gridX = screenSize.width / 4;
    double gridY = screenSize.height / 4 * 3;
    Vector2 gridPosition = Vector2(gridX, gridY);
    List<Color> colors = [Colors.red, Colors.blue, Colors.yellow];

    for (var i = 0; i < 3; i++) {
      //add color card to game
      Button colouredButton = Button(Vector2.all(cardSize), colors[i]);
      colouredButton.position = gridPosition;
      grid.add(colouredButton);
      add(colouredButton);

      //increase position.x every new card
      gridPosition += Vector2(spacer + cardSize, 0);
    }
  }

  void buttonToggled(Color colour, bool pressedDown) {
    if (pressedDown) {
      coloursChosen.add(colour);
    } else {
      coloursChosen.remove(colour);
    }

    if (coloursChosen.length > 0) {
      var newColour = mix(coloursChosen);
      player.updateColour(newColour);
    } else {
      var newColour = Colors.white;
      player.updateColour(newColour);
    }
  }

  Color mix(List<Color> coloursChosen) {
    double r = 0;
    double g = 0;
    double b = 0;

    for (Color colour in coloursChosen) {
      r += colour.red;
      g += colour.green;
      b += colour.blue;
    }
    r = r / coloursChosen.length;
    g = g / coloursChosen.length;
    b = b / coloursChosen.length;

    return Color.fromRGBO(r.toInt(), g.toInt(), b.toInt(), 1);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // create and add in the player component
    calScreenSize();
    var playerX = (screenSize.width / 4).floorToDouble();
    var playerY = (screenSize.height / 4).floorToDouble();
    player = Player(Vector2(playerX, playerY), Vector2(20, 20), Colors.white);
    add(player);

    // add wall obstacles
    WallObstacle wall = WallObstacle(
        Vector2(screenSize.width.floorToDouble(),
            screenSize.height.floorToDouble()),
        difficultyLevel);
    add(wall);
    wallArray.add(wall);
    print(wallArray);

    //add grid
    addGrid();
    // add pause button
    addPauseButton();
  }

  @override
  void update(double dt) {
    /* if(isGameOver){
      overlays.add('GameOver)
      pauseEngine();
    } */
    elapsedTime += dt;
    if (elapsedTime > wallTimeInterval) {
      // add wall obstacles
      WallObstacle wall = WallObstacle(
          Vector2(screenSize.width.floorToDouble(),
              screenSize.height.floorToDouble()),
          difficultyLevel);
      add(wall);
      wallArray.add(wall);
      elapsedTime = 0;
    }

    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}
