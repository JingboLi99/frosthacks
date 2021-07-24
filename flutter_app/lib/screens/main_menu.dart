import 'package:flutter/material.dart';
import 'package:flutter_app/screens/game_play.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Card(
                color: Colors.black.withOpacity(0.4),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 30)),
                      Text("Main Menu", style: TextStyle(fontSize: 28)),
                      ElevatedButton(
                          child: Text("Play", style: TextStyle(fontSize: 28)),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => GamePlay()));
                          })
                    ]))));
  }
}
