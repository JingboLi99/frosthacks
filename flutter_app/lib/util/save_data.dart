import 'package:shared_preferences/shared_preferences.dart';

class SaveData {
  static Future<int> getHighScore() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getInt("highscore") ?? 0;
  }

  static saveHighScore(int score) async {
    var prefs = await SharedPreferences.getInstance();
    int current_highscore = prefs.getInt("highscore") ?? 0;
    if (score > current_highscore) {
      await prefs.setInt('highscore', score);
    }
  }
}
