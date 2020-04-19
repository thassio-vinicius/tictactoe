import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:tictactoe/models/tictac_button.dart';
import 'package:tictactoe/screens/components/marker_circle.dart';
import 'package:tictactoe/screens/components/marker_cross.dart';

class PlayersProvider extends ChangeNotifier {
  List<TicTacButton> _buttonsList;
  List<int> _player1Moves = [];
  List<int> _player2Moves = [];
  Widget _player1Marker = CrossMarker();
  Widget _player2Marker = CircleMarker();
  bool _player1Winner = false;
  bool _player2Winner = false;
  bool _tie = false;
  String _playerInitials;
  int _score = 0;
  int _currentPlayer = 1;

  List<TicTacButton> get buttonsList => _buttonsList;
  List<int> get player1Moves => _player1Moves;
  List<int> get player2Moves => _player2Moves;
  Widget get player1Marker => _player1Marker;
  Widget get player2Marker => _player2Marker;
  bool get player1Winner => _player1Winner;
  bool get player2Winner => _player2Winner;
  bool get tie => _tie;
  String get playerInitials => _playerInitials;
  int get score => _score;
  int get currentPlayer => _currentPlayer;

  void initGame() {
    _buttonsList = List.generate(9, (index) => TicTacButton(id: index));
    _player2Winner = false;
    _player1Winner = false;
    _tie = false;
    _currentPlayer = 1;
    _player1Moves.clear();
    _player2Moves.clear();
  }

  void makeMove(TicTacButton button) async {
    if (_currentPlayer == 1) {
      button.marker = _player1Marker;
      //button.bg = Colors.red;
      _currentPlayer = 2;
      _player1Moves.add(button.id);
    } else {
      button.marker = _player2Marker;
      //button.bg = Colors.black;
      _currentPlayer = 1;
      _player2Moves.add(button.id);
    }
    button.enabled = false;
    _player1Winner = _checkForWinners(_player1Moves);
    _player2Winner = _checkForWinners(_player2Moves);
    if (!player1Winner && !player2Winner) {
      if (_buttonsList.every((p) => p.marker != null)) {
        _tie = true;
      } else {
        if (_currentPlayer == 2) await _cpuMove();
      }
    }

    notifyListeners();
  }

  _checkForWinners(List playerMoves) {
    bool winner = false;

    // row 1
    if (playerMoves.contains(0) &&
        playerMoves.contains(1) &&
        playerMoves.contains(2)) {
      winner = true;
    }

    // row 2
    if (playerMoves.contains(3) &&
        playerMoves.contains(4) &&
        playerMoves.contains(5)) {
      winner = true;
    }

    // row 3
    if (playerMoves.contains(6) &&
        playerMoves.contains(7) &&
        playerMoves.contains(8)) {
      winner = true;
    }

    // col 1
    if (playerMoves.contains(0) &&
        playerMoves.contains(3) &&
        playerMoves.contains(6)) {
      winner = true;
    }

    // col 2
    if (playerMoves.contains(1) &&
        playerMoves.contains(4) &&
        playerMoves.contains(7)) {
      winner = true;
    }

    // col 3
    if (playerMoves.contains(2) &&
        playerMoves.contains(5) &&
        playerMoves.contains(8)) {
      winner = true;
    }

    //diagonals
    if (playerMoves.contains(0) &&
        playerMoves.contains(4) &&
        playerMoves.contains(8)) {
      winner = true;
    }

    if (playerMoves.contains(2) &&
        playerMoves.contains(4) &&
        playerMoves.contains(6)) {
      winner = true;
    }

    notifyListeners();

    return winner;
  }

  _cpuMove() async {
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

    makeMove(_buttonsList[i]);
    notifyListeners();
  }
}
