import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/providers/game_provider.dart';

import 'components/custom_alertdialog.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  GameProvider _provider;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _provider = Provider.of<GameProvider>(context, listen: false);
    _provider.initGame();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Consumer<GameProvider>(
              builder: (context, provider, child) => GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 9.0,
                        mainAxisSpacing: 9.0),
                    itemCount: provider.buttonsList.length,
                    itemBuilder: (context, i) => SizedBox(
                      width: 100.0,
                      height: 100.0,
                      child: RaisedButton(
                        padding: const EdgeInsets.all(8.0),
                        onPressed: provider.buttonsList[i].enabled
                            ? () {
                                provider.makeMove(provider.buttonsList[i]);
                                _canShowDialog(provider);
                              }
                            : null,
                        child: provider.buttonsList[i].marker,
                        //color: buttonsList[i].bg,
                        //disabledColor: buttonsList[i].bg,
                      ),
                    ),
                  )),
        ),
      ),
    );
  }

  _canShowDialog(GameProvider provider) {
    if (provider.tie) {
      showDialog(
          context: context,
          builder: (_) => CustomAlertDialog("Game Tied",
              "Press the reset button to start again.", _resetGame));
    }
    if (provider.player1Winner || provider.player2Winner) {
      showDialog(
          context: context,
          builder: (_) => CustomAlertDialog(
              "Player ${provider.player1Winner ? '1' : '2'} Won",
              "Press the reset button to start again.",
              _resetGame));
    }
  }

  void _resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      _provider.initGame();
    });
  }
}
