import 'package:flutter/material.dart';
import 'package:tic_tac_toe/single_player_game.dart';

import 'ai/ai.dart';

class DifficultyLevelDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Choose a level',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
            ListTile(
              title: Text(
                'Easy',
                textAlign: TextAlign.center,
              ),
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SinglePlayerGame(
                            difficulty: GameDifficulty.Easy,
                          ),
                    ),
                  ),
            ),
            ListTile(
              title: Text(
                'Medium',
                textAlign: TextAlign.center,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Hard',
                textAlign: TextAlign.center,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
