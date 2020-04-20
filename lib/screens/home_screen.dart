import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/providers/game_provider.dart';
import 'package:tictactoe/screens/game_screen.dart';
import 'package:tictactoe/screens/options_screen.dart';
import 'package:tictactoe/screens/scoreboards_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            _gameOption(
              optionDescription: 'Player VS CPU',
              onOptionPressed: () => _playOption(isPlayerVsCpu: true),
            ),
            _gameOption(
              optionDescription: 'Player VS Player',
              onOptionPressed: () => _playOption(isPlayerVsCpu: false),
            ),
            _gameOption(
              optionDescription: 'Show scoreboards',
              onOptionPressed: () => _showScoreBoards,
            ),
            _gameOption(
              optionDescription: 'Options',
              onOptionPressed: () => _showOptions,
            ),
          ],
        ),
      ),
    );
  }

  Widget _gameOption({String optionDescription, Function onOptionPressed}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: onOptionPressed,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Center(
            child: Text(
              optionDescription,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _playOption({bool isPlayerVsCpu}) {
    Provider.of<GameProvider>(context, listen: false)
        .setGameplayOption(isPlayerVsCpu: isPlayerVsCpu);

    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => GameScreen(),
      ),
    );
  }

  _showOptions() {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OptionsScreen(),
      ),
    );
  }

  _showScoreBoards() {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ScoreboardsScreen(),
      ),
    );
  }
}
