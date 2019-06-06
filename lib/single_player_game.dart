import 'package:flutter/material.dart';
import 'package:tic_tac_toe/themes.dart';

import 'ai/EasyAI.dart';
import 'ai/ai.dart';
import 'circle.dart';
import 'cross.dart';
import 'equal.dart';

enum GameState { Blank, X, O }

class SinglePlayerGame extends StatefulWidget {
  final GameDifficulty difficulty;

  SinglePlayerGame({this.difficulty});

  @override
  _SinglePlayerGameState createState() => _SinglePlayerGameState();
}

class _SinglePlayerGameState extends State<SinglePlayerGame>
    with TickerProviderStateMixin {
  var activePlayer = GameState.X;
  var winner = GameState.Blank;
  var boardState = List<List<GameState>>.generate(
      3, (i) => List<GameState>.generate(3, (j) => GameState.Blank));

  Animation<double> _boardAnimation;
  AnimationController _boardController;
  double _boardOpacity = 1.0;
  bool _showWinnerDisplay = false;
  int _moveCount = 0;
  int _xWins = 0;
  int _oWins = 0;
  int _draws = 0;
  var ai;

  @override
  void initState() {
    _boardController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _boardAnimation = Tween(begin: 1.0, end: 0.0).animate(_boardController)
      ..addListener(() {
        setState(() {
          _boardOpacity = _boardAnimation.value;
        });
      });
    initAI();
    super.initState();
  }

  initAI() {
    switch (widget.difficulty) {
      case GameDifficulty.Easy:
        {
          ai = EasyAI();
          break;
        }
      case GameDifficulty.Medium:
        {
          break;
        }
      case GameDifficulty.Hard:
        {
          break;
        }
    }
  }

  @override
  void dispose() {
    _boardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              scoreBoard,
              Stack(
                children: <Widget>[
                  board,
                  winnerDisplay,
                ],
              ),
              bottomBar,
            ],
          )),
    );
  }

  Widget get scoreBoard => Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            xScore,
            drawScore,
            oScore,
          ],
        ),
      );

  Widget get winnerDisplay => Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: Visibility(
          visible: _showWinnerDisplay,
          child: Opacity(
            opacity: 1.0 - _boardOpacity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (winner == GameState.X)
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: Cross(),
                  ),
                if (winner == GameState.O)
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: Circle(),
                  ),
                Text(
                  (winner == GameState.Blank) ? "It's a draw!" : 'win!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                    fontSize: 56.0,
                  ),
                ),
                if (winner != GameState.Blank)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Image.asset(
                      'assets/ic_party.png',
                      width: 80.0,
                      height: 80.0,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );

  Widget get xScore => Column(
        children: <Widget>[
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: Cross(),
          ),
          Text(
            '$_xWins wins',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: crossColor,
              fontSize: 20.0,
            ),
          ),
        ],
      );

  Widget get oScore => Column(
        children: <Widget>[
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: Circle(),
          ),
          Text(
            '$_oWins wins',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: circleColor,
                fontSize: 20.0),
          )
        ],
      );

  Widget get drawScore => Column(
        children: <Widget>[
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: Equal(),
          ),
          Text(
            '$_draws draws',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: accentColor,
                fontSize: 20.0),
          )
        ],
      );

  Widget get board => Opacity(
        opacity: _boardOpacity,
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              color: Colors.grey[300],
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  return gameButton(row, col);
                },
              ),
            ),
          ),
        ),
      );

  Widget get bottomBar => Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'back',
              child: Icon(Icons.arrow_back),
              backgroundColor: accentColor,
              mini: true,
              onPressed: () => Navigator.pop(context),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(color: Colors.grey[300]),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.difficulty
                      .toString()
                      .substring(widget.difficulty.toString().indexOf('.') + 1),
                  style: TextStyle(
                    fontSize: 14.0,
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              heroTag: 'reset',
              child: Icon(Icons.cached),
              backgroundColor: accentColor,
              mini: true,
              onPressed: () => reset(),
            ),
          ],
        ),
      );

  Widget gameButton(int row, int col) {
    return GestureDetector(
      onTap: (boardState[row][col] == GameState.Blank &&
              winner == GameState.Blank &&
              activePlayer == GameState.X)
          ? () => onGameButtonTap(row, col)
          : null,
      child: Container(
        color: Colors.white,
        child: Center(
          child: gamePiece(row, col),
        ),
      ),
    );
  }

  onGameButtonTap(row, col) {
    _moveCount++;
    boardState[row][col] = activePlayer;
    checkWinningCondition(row, col, activePlayer);
    toggleActivePlayer();
    setState(() {});
  }

  void toggleActivePlayer() {
    if (activePlayer == GameState.X) {
      activePlayer = GameState.O;
      playAI();
    } else
      activePlayer = GameState.X;
  }

  playAI() {
    var move = ai.getMove(boardState, 0);
    var row = move[0];
    var col = move[1];
    onGameButtonTap(row, col);
  }

  gamePiece(int row, int col) {
    if (boardState[row][col] == GameState.X)
      return Cross();
    else if (boardState[row][col] == GameState.O)
      return Circle();
    else
      return null;
  }

  void reset() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        boardState[i][j] = GameState.Blank;
      }
    }
    activePlayer = GameState.X;
    winner = GameState.Blank;
    _moveCount = 0;
    setState(() {
      _showWinnerDisplay = false;
    });
    _boardController.reverse();
  }

  void checkWinningCondition(int row, int col, GameState gameState) {
    //check col condition
    for (int i = 0; i < 3; i++) {
      if (boardState[row][i] != gameState) break;
      if (i == 2) {
        setWinner(gameState);
        return;
      }
    }

    //Check row condition
    for (int i = 0; i < 3; i++) {
      if (boardState[i][col] != gameState) break;
      if (i == 2) {
        setWinner(gameState);
        return;
      }
    }

    //check diagonal
    if (row == col) {
      for (int i = 0; i < 3; i++) {
        if (boardState[i][i] != gameState) break;
        if (i == 2) {
          setWinner(gameState);
          return;
        }
      }
    }

    // check anti-diagonal
    if (row + col == 2) {
      for (int i = 0; i < 3; i++) {
        if (boardState[i][2 - i] != gameState) break;
        if (i == 2) {
          setWinner(gameState);
          return;
        }
      }
    }

    //checkDraw
    if (_moveCount == 9) {
      print('Draw');
      setWinner(GameState.Blank);
      return;
    }
  }

  void setWinner(GameState gameState) {
    print('$gameState wins');
    winner = gameState;
    switch (gameState) {
      case GameState.Blank:
        {
          _draws++;
          break;
        }
      case GameState.X:
        {
          _xWins++;
          break;
        }
      case GameState.O:
        {
          _oWins++;
          break;
        }
    }
    toggleBoardOpacity();
  }

  void toggleBoardOpacity() {
    if (_boardOpacity == 0.0) {
      setState(() {
        _showWinnerDisplay = false;
      });
      _boardController.reverse();
    } else if (_boardOpacity == 1.0) {
      _boardController.forward();
      setState(() {
        _showWinnerDisplay = true;
      });
    }
  }
}
