import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/utils/hex_color.dart';

class ScoreboardCard extends StatefulWidget {
  @override
  _ScoreboardCardState createState() => _ScoreboardCardState();
}

class _ScoreboardCardState extends State<ScoreboardCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3),
        borderRadius: BorderRadius.all(
          Radius.circular(14),
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildPlayerAvatar(),
          _buildPlayerNameAndPosition(),
          _buildPlayerScore()
        ],
      ),
    );
  }

  _buildPlayerAvatar() {
    return Stack(
      children: <Widget>[
        Image.asset('assets/images/circle_first.png'),
        Positioned.fill(
            child: CircleAvatar(
          backgroundColor: Colors.red,
        ))
      ],
    );
  }

  _buildPlayerNameAndPosition() {
    return Column(
      children: <Widget>[
        Text(
          'NameFor Testing Alright',
          style: GoogleFonts.montserratAlternates(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),
        ),
        Stack(
          children: <Widget>[
            Image.asset('assets/images/icons/star_first.png'),
            Center(
              child: Text(
                '1º',
                style: GoogleFonts.montserratAlternates(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
          ],
        )
      ],
    );
  }

  _buildPlayerScore() {
    return Row(
      children: <Widget>[
        Text(
          '500 pts',
          style: GoogleFonts.montserratAlternates(
            fontWeight: FontWeight.w800,
            fontSize: 14,
            color: HexColor('#F7EC40'),
          ),
        ),
        Image.asset('assets/images/icons/arrow_up_first.png')
      ],
    );
  }
}
