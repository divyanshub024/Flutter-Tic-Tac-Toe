import 'package:flutter/material.dart';
import 'package:tic_tac_toe/themes.dart';
import 'package:tic_tac_toe/two_player_game.dart';

import 'circle.dart';
import 'cross.dart';
import 'difficulty_level_dialog.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: Cross(),
                ),
                SizedBox(
                  width: 110.0,
                  height: 110.0,
                  child: Circle(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 110.0,
                  height: 110.0,
                  child: Circle(),
                ),
                SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: Cross(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Tic ',
                    style: TextStyle(
                      color: crossColor,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Tac ',
                    style: TextStyle(
                      color: circleColor,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Toe',
                    style: TextStyle(
                      color: crossColor,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width * 0.8,
                height: 60.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0)),
                child: RaisedButton(
                  child: Text(
                    'Single Player',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) => DifficultyLevelDialog()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width * 0.8,
                height: 60.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0)),
                child: RaisedButton(
                  child: Text(
                    'Multi Player',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TwoPlayerGame())),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
