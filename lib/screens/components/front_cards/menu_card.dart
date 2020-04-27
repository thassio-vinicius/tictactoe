import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/providers/game_provider.dart';
import 'package:tictactoe/screens/components/front_cards/shared/custom_button.dart';
import 'package:tictactoe/screens/game_screen.dart';
import 'package:tictactoe/screens/options_screen.dart';
import 'package:tictactoe/screens/scoreboards_screen.dart';
import 'package:tictactoe/utils/hex_color.dart';

class MenuCard extends StatefulWidget {
  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.70,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomButton(
              percentageWidth: 0.80,
              buttonLabel: 'Player VS CPU',
              buttonColor: HexColor('#6FB352'),
              onTap: () =>
                  _chooseOption(isPlayerVsCpu: true, pageRoute: GameScreen()),
            ),
            CustomButton(
              percentageWidth: 0.80,
              buttonColor: HexColor('#CB2376'),
              buttonLabel: 'Player VS Player',
              onTap: () =>
                  _chooseOption(isPlayerVsCpu: false, pageRoute: GameScreen()),
            ),
            CustomButton(
              percentageWidth: 0.50,
              buttonColor: HexColor('#F7EC40'),
              buttonLabel: 'Scoreboards',
              onTap: () => _chooseOption(pageRoute: ScoreboardsScreen()),
            ),
            CustomButton(
              percentageWidth: 0.50,
              buttonColor: HexColor('#8AD0F6'),
              buttonLabel: 'Options',
              onTap: () => _chooseOption(pageRoute: OptionsScreen()),
            ),
          ],
        ),
      ),
    );
  }

  _chooseOption({bool isPlayerVsCpu, Widget pageRoute}) {
    if (isPlayerVsCpu != null) {
      Provider.of<GameProvider>(context, listen: false)
          .setGameplayOption(isPlayerVsCpu: isPlayerVsCpu);
    }

    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => pageRoute,
      ),
    );
  }
}
