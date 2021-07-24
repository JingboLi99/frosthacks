import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/button.dart';
import 'package:flutter_app/components/player.dart';

class GamePlay extends StatelessWidget {
  GamePlay({Key key}) : super(key: key);
  final myGame = MyGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GameWidget(game: myGame));
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

  static const int squareSpeed = 200;
  Rect squarePos;
  int squareDirection = -1;
  MyGame() {
    _buildHud();
  }

  static final squarePaint = BasicPalette.white.paint();

  //to calculate screen size
  void calScreenSize() {
    screenSize = Size(canvasSize.toOffset().dx, canvasSize.toOffset().dy);
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
    squarePos = Rect.fromLTWH(size.x, 0, 10, 100);

    // create and add in the player component
    calScreenSize();
    var playerX = (screenSize.width / 4).floorToDouble();
    var playerY = (screenSize.height / 4).floorToDouble();
    player = Player(Vector2(playerX, playerY), Vector2(20, 20), Colors.white);
    add(player);

    //add grid
    addGrid();

    return super.onLoad();
  }

  @override
  void update(double dt) {
    squarePos = squarePos.translate(squareSpeed * squareDirection * dt, 0);

    if (squarePos.left < 0) {
      squarePos = Rect.fromLTWH(size.x, 0, 10, 100);
    }

    /* if(isGameOver){
      overlays.add('GameOver)
      pauseEngine();
    } */

    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(squarePos, squarePaint);

    super.render(canvas);
  }

  Widget _buildHud() {
    return IconButton(
        icon: Icon(Icons.pause, color: Colors.white, size: 30),
        onPressed: () {});
  }
}
