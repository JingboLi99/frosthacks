import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/game_play.dart';
import 'package:flutter_app/util/save_data.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key key}) : super(key: key);

  @override
  MainMenuState createState() => MainMenuState();
}

class MainMenuState extends State<MainMenu> {
  @override
  void initState() {
    super.initState();
    SaveData.getHighScore();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SaveData.getHighScore(),
        builder: (context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            return Center(
                child: Card(
                    color: Colors.redAccent.withOpacity(0.4),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 200, vertical: 15)),
                          Text("Main Menu", style: TextStyle(fontSize: 28)),
                          ElevatedButton(
                              child:
                                  Text("Play", style: TextStyle(fontSize: 28)),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => GamePlay()));
                              }),
                          Text("Highscore: " + snapshot.data.toString(),
                              style: TextStyle(fontSize: 28))
                        ])));
          } else
            return Container();
        });
  }
}
