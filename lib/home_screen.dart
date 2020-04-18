import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoe/custom_alertdialog.dart';
import 'package:tictactoe/tictac_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TicTacButton> _buttonsList;
  List _player1Moves;
  List _player2Moves;
  int _currentPlayer;

  @override
  void initState() {
    _buttonsList = _initList();
    super.initState();
  }

  List<TicTacButton> _initList() {
    _player1Moves = List();
    _player2Moves = List();

    _currentPlayer = 1;

    var ticTacButtons = <TicTacButton>[];

    for (int i = 0; i < 9; i++) ticTacButtons.add(TicTacButton(id: i));

    return ticTacButtons;
  }

  _checkForWinners() {
    var winner = -1;
    if (_player1Moves.contains(1) &&
        _player1Moves.contains(2) &&
        _player1Moves.contains(3)) {
      winner = 1;
    }
    if (_player2Moves.contains(1) &&
        _player2Moves.contains(2) &&
        _player2Moves.contains(3)) {
      winner = 2;
    }

    // row 2
    if (_player1Moves.contains(4) &&
        _player1Moves.contains(5) &&
        _player1Moves.contains(6)) {
      winner = 1;
    }
    if (_player2Moves.contains(4) &&
        _player2Moves.contains(5) &&
        _player2Moves.contains(6)) {
      winner = 2;
    }

    // row 3
    if (_player1Moves.contains(7) &&
        _player1Moves.contains(8) &&
        _player1Moves.contains(9)) {
      winner = 1;
    }
    if (_player2Moves.contains(7) &&
        _player2Moves.contains(8) &&
        _player2Moves.contains(9)) {
      winner = 2;
    }

    // col 1
    if (_player1Moves.contains(1) &&
        _player1Moves.contains(4) &&
        _player1Moves.contains(7)) {
      winner = 1;
    }
    if (_player2Moves.contains(1) &&
        _player2Moves.contains(4) &&
        _player2Moves.contains(7)) {
      winner = 2;
    }

    // col 2
    if (_player1Moves.contains(2) &&
        _player1Moves.contains(5) &&
        _player1Moves.contains(8)) {
      winner = 1;
    }
    if (_player2Moves.contains(2) &&
        _player2Moves.contains(5) &&
        _player2Moves.contains(8)) {
      winner = 2;
    }

    // col 3
    if (_player1Moves.contains(3) &&
        _player1Moves.contains(6) &&
        _player1Moves.contains(9)) {
      winner = 1;
    }
    if (_player2Moves.contains(3) &&
        _player2Moves.contains(6) &&
        _player2Moves.contains(9)) {
      winner = 2;
    }

    //diagonal
    if (_player1Moves.contains(1) &&
        _player1Moves.contains(5) &&
        _player1Moves.contains(9)) {
      winner = 1;
    }
    if (_player2Moves.contains(1) &&
        _player2Moves.contains(5) &&
        _player2Moves.contains(9)) {
      winner = 2;
    }

    if (_player1Moves.contains(3) &&
        _player1Moves.contains(5) &&
        _player1Moves.contains(7)) {
      winner = 1;
    }
    if (_player2Moves.contains(3) &&
        _player2Moves.contains(5) &&
        _player2Moves.contains(7)) {
      winner = 2;
    }

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => new CustomAlertDialog("Player 1 Won",
                "Press the reset button to start again.", resetGame));
      } else {
        showDialog(
            context: context,
            builder: (_) => new CustomAlertDialog("Player 2 Won",
                "Press the reset button to start again.", resetGame));
      }
    }

    return winner;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      _buttonsList = _initList();
    });
  }

  void _makeMove(TicTacButton button) {
    setState(() {
      if (_currentPlayer == 1) {
        button.value = "X";
        //button.bg = Colors.red;
        _currentPlayer = 2;
        _player1Moves.add(button.id);
      } else {
        button.value = "0";
        //button.bg = Colors.black;
        _currentPlayer = 1;
        _player2Moves.add(button.id);
      }
      button.enabled = false;
      int winner = _checkForWinners();
      if (winner == -1) {
        if (_buttonsList.every((p) => p.value != "")) {
          showDialog(
              context: context,
              builder: (_) => new CustomAlertDialog("Game Tied",
                  "Press the reset button to start again.", resetGame));
        } else {
          _currentPlayer == 2 ? _cpuMove() : null;
        }
      }
    });
  }

  _cpuMove() {
    var emptyButtons = List();
    var tempList = List.generate(9, (i) => i + 1);
    for (var buttonId in tempList) {
      if (!(_player1Moves.contains(buttonId) ||
          _player2Moves.contains(buttonId))) {
        emptyButtons.add(buttonId);
      }
    }

    Random r = Random();
    int randomIndex = r.nextInt(emptyButtons.length - 1);
    int moveId = emptyButtons[randomIndex];
    int i = _buttonsList.indexWhere((element) => element.id == moveId);
    _makeMove(_buttonsList[i]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 9.0,
                mainAxisSpacing: 9.0),
            itemCount: _buttonsList.length,
            itemBuilder: (context, i) => new SizedBox(
              width: 100.0,
              height: 100.0,
              child: new RaisedButton(
                padding: const EdgeInsets.all(8.0),
                onPressed: _buttonsList[i].enabled
                    ? () => _makeMove(_buttonsList[i])
                    : null,
                child: new Text(
                  _buttonsList[i].value,
                  style: new TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                //color: buttonsList[i].bg,
                //disabledColor: buttonsList[i].bg,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
