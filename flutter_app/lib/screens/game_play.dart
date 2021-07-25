import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/button.dart';
import 'package:flutter_app/components/pause_button.dart';
import 'package:flutter_app/components/player.dart';
import 'package:flutter_app/components/wall_obstacle.dart';
import 'package:flutter_app/screens/main_menu.dart';
import 'package:flutter_app/util/save_data.dart';

class GamePlay extends StatefulWidget {
  GamePlay({Key key}) : super(key: key);

  @override
  GamePlayState createState() => GamePlayState();
}

class GamePlayState extends State<GamePlay> {
  var myGame = MyGame();

  Widget pauseMenuBuilder(BuildContext buildContext, MyGame game) {
    return Center(
        child: Container(
            height: 250,
            width: 300,
            color: const Color(0XFFFF0000),
            child: Card(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text("Paused", style: TextStyle(fontSize: 40)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  ElevatedButton(
                      child: Text("Resume", style: TextStyle(fontSize: 26)),
                      onPressed: () {
                        game.overlays.remove("PauseMenu");
                        game.resumeEngine();
                      }),
                  ElevatedButton(
                      child: Text("Restart", style: TextStyle(fontSize: 26)),
                      onPressed: () => {
                            setState(() {
                              myGame = MyGame();
                            })
                          }),
                  ElevatedButton(
                      child: Text("Main Menu", style: TextStyle(fontSize: 26)),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => MainMenu()));
                      }),
                ]))));
  }

  Widget gameOverBuilder(BuildContext buildContext, MyGame game) {
    return FutureBuilder(
        future: SaveData.getHighScore(),
        builder: (context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            return Center(
                child: Container(
                    height: 250,
                    width: 300,
                    color: const Color(0XFFFF0000),
                    child: Card(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Text("Game Over!", style: TextStyle(fontSize: 35)),
                          Text("Your score: " + game.score.toString(),
                              style: TextStyle(fontSize: 26)),
                          Text("Highscore: " + snapshot.data.toString(),
                              style: TextStyle(fontSize: 26)),
                          ElevatedButton(
                              child: Text("Restart",
                                  style: TextStyle(fontSize: 26)),
                              onPressed: () => {
                                    setState(() {
                                      myGame = MyGame();
                                    })
                                  }),
                          ElevatedButton(
                              child: Text("Main Menu",
                                  style: TextStyle(fontSize: 26)),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => MainMenu()));
                              })
                        ]))));
          } else {
            return Center(child: Container(height: 200, width: 275));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GameWidget(game: myGame, overlayBuilderMap: {
      'PauseMenu': pauseMenuBuilder,
      'GameOver': gameOverBuilder
    }));
  }
}

class MyGame extends BaseGame with HasTappableComponents {
  //For the Player
  Size screenSize;
  Player player;

  //For the Grid
  List<Button> grid = [];
  List<Color> coloursChosen = [];

  //For counting score
  TextComponent scoreCounter;
  int score = 0;

  //For wall obstacles
  double elapsedTime = 0;
  static const double baseWallTimeInterval = 3.3;
  List<WallObstacle> wallArray = [];
  int nearestWallIndex;

  //to calculate screen size
  void calScreenSize() {
    screenSize = Size(canvasSize.toOffset().dx, canvasSize.toOffset().dy);
  }

  Future<void> addPauseButton() async {
    // renders pause button
    final pauseSprite = await Sprite.load('pause.png');
    SpriteComponent pauseButton = PauseButton(pauseSprite);
    add(pauseButton);
  }

  //grid creation method and helpers
  void addGrid() {
    double cardSize = screenSize.width / 12;
    double spacer = screenSize.width / 32;
    double gridX = screenSize.width / 2.75;
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

  void addScoreCounter() {
    scoreCounter = TextComponent(score.toString(),
        textRenderer: TextPaint(
            config: TextPaintConfig(
                fontSize: 50.0,
                fontFamily: 'Awesome Font',
                color: Colors.white)));
    scoreCounter.position = Vector2(screenSize.width / 2, 30);
    add(scoreCounter);
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
    var playerY = (screenSize.height / 3.5).floorToDouble();
    var playerSize = (screenSize.width / 18).floorToDouble();
    player = Player(
        Vector2(playerX, playerY), Vector2.all(playerSize), Colors.white);
    add(player);

    // add wall obstacles
    double wallHeight = (screenSize.height / 3).floorToDouble();
    WallObstacle wall = WallObstacle(
        Vector2(screenSize.width.floorToDouble(),
            (screenSize.height / 2.5).floorToDouble()),
        wallHeight,
        score);
    add(wall);
    wallArray.add(wall);

    //add grid
    addGrid();
    // add pause button
    addPauseButton();

    addScoreCounter();
  }

  @override
  void update(double dt) {
    if (nearestWallIndex == null) {
      nearestWallIndex = 0;
    }

    if (wallArray.length > 0) {
      if (wallArray[nearestWallIndex].wallPos.left <=
          player.position.x + player.size.x) {
        if (wallArray[nearestWallIndex].color == player.colour) {
          score += 1;
          wallArray.removeAt(nearestWallIndex);
          scoreCounter.text = score.toString();
        } else {
          overlays.add('GameOver');
          pauseEngine();
          SaveData.saveHighScore(score);
        }
      }

      // prevents overtaking
      for (int i = 0; i < wallArray.length; i++) {
        if (wallArray[i].wallPos.left <
            wallArray[nearestWallIndex].wallPos.left) {
          nearestWallIndex = i;
        }
      }
    }

    elapsedTime += dt;
    var wallTimeInterval = baseWallTimeInterval - (score * 0.2);
    if (wallTimeInterval < 1) {
      wallTimeInterval = 1;
    }
    double wallHeight = (screenSize.height / 3).floorToDouble();
    if (elapsedTime > wallTimeInterval) {
      // add wall obstacles
      WallObstacle wall = WallObstacle(
          Vector2(screenSize.width.floorToDouble(),
              (screenSize.height / 2.5).floorToDouble()),
          wallHeight,
          score);
      add(wall);
      wallArray.add(wall);
      elapsedTime = 0;
    }
    super.update(dt);
  }
}
