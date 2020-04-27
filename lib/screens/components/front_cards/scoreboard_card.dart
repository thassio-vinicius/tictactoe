import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/utils/hex_color.dart';

class ScoreboardCard extends StatelessWidget {
  final String name;
  final String starPath;
  final String circleAvatarPath;
  final String arrowPath;
  final int score;
  final int position;
  final photoUrl;

  ScoreboardCard({
    @required this.score,
    @required this.position,
    @required this.name,
    @required this.arrowPath,
    @required this.circleAvatarPath,
    @required this.starPath,
    this.photoUrl,
  });

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
        Image.asset('assets/images/$circleAvatarPath.png'),
        Positioned.fill(
          child: photoUrl == null
              ? Image.asset(
                  'assets/images/user_example.png',
                  fit: BoxFit.scaleDown,
                )
              : Image.network(
                  photoUrl,
                  fit: BoxFit.scaleDown,
                ),
        )
      ],
    );
  }

  _buildPlayerNameAndPosition() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          name,
          style: GoogleFonts.montserratAlternates(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),
        ),
        Stack(
          children: <Widget>[
            Image.asset('assets/images/icons/$starPath.png'),
            Positioned.fill(
              child: Text(
                '$positionº',
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
          '$score pts',
          style: GoogleFonts.montserratAlternates(
            fontWeight: FontWeight.w800,
            fontSize: 14,
            color: HexColor('#F7EC40'),
          ),
        ),
        Image.asset('assets/images/icons/$arrowPath.png')
      ],
    );
  }
}
