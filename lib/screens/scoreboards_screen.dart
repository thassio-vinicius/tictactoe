import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/front_cards/Scoreboard_card.dart';

class ScoreboardsScreen extends StatefulWidget {
  @override
  _ScoreboardsScreenState createState() => _ScoreboardsScreenState();
}

class _ScoreboardsScreenState extends State<ScoreboardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: SingleChildScrollView(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset('assets/images/scoreboard_logo.png'),
          ScoreboardCard(),
          ScoreboardCard(),
          ScoreboardCard(),
          ScoreboardCard(),
          ScoreboardCard()
        ],
      ))),
    );
  }
}
