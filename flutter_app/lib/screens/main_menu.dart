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
            return Material(
                type: MaterialType.transparency,
                child: Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 3)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: 25,
                                        height: 100,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 10),
                                        decoration: BoxDecoration(
                                            color: const Color(0xfff44336))),
                                    Container(
                                        width: 25,
                                        height: 100,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                            color: const Color(0xff2196f3))),
                                    Container(
                                        width: 25,
                                        height: 100,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                            color: const Color(0xffffeb3b))),
                                    Container(
                                        width: 25,
                                        height: 100,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                            color: const Color(0xff8a6c94))),
                                    Container(
                                        width: 25,
                                        height: 100,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                            color: const Color(0xfff99738))),
                                    Container(
                                        width: 25,
                                        height: 100,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                            color: const Color(0xff90c097))),
                                    Container(
                                        width: 25,
                                        height: 100,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                            color: const Color(0xffffffff))),
                                    Container(
                                        width: 25,
                                        height: 100,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                            color: const Color(0xffb19676)))
                                  ]),
                              Text("Colour Match",
                                  style: TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: ElevatedButton(
                                    child: Text("Play",
                                        style: TextStyle(fontSize: 28)),
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GamePlay()));
                                    }),
                              ),
                              Text("Highscore: " + snapshot.data.toString(),
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.white))
                            ]))));
          } else
            return Container();
        });
  }
}
