import '../single_player_game.dart';

enum GameDifficulty { Easy, Medium, Hard }

abstract class AI {
  List<int> getMove(List<List<GameState>> board, int turns);

  List<List<int>> getEmptyCells(List<List<GameState>> board) {
    List<List<int>> emptyCells = List<List<int>>();
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == GameState.Blank) {
          emptyCells.add([i, j]);
        }
      }
    }
    return emptyCells;
  }
}
