import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/models/user.dart';
import 'package:tictactoe/providers/user_provider.dart';
import 'package:tictactoe/screens/components/front_cards/scoreboard_card.dart';

class ScoreboardsScreen extends StatefulWidget {
  @override
  _ScoreboardsScreenState createState() => _ScoreboardsScreenState();
}

class _ScoreboardsScreenState extends State<ScoreboardsScreen> {
  Stream<QuerySnapshot> _stream;
  List<User> _users = List<User>();
  String _arrowPath;
  String _avatarPath;
  String _starPath;

  @override
  void didChangeDependencies() {
    _stream = Provider.of<UserProvider>(context, listen: false).getAllUsers();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildHeader(),
            _buildBody(),
          ],
        ),
      ),
    );
  }

  _buildHeader() {
    return Stack(
      children: <Widget>[
        Image.asset('assets/images/scoreboard_logo.png'),
        Positioned.fill(
          child: Text(
            'Scoreboards',
            style: GoogleFonts.play(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  StreamBuilder<QuerySnapshot> _buildBody() {
    return StreamBuilder<QuerySnapshot>(
      stream: _stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
            break;
          default:
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  'Future scoreboards will be displayed here!',
                  style: GoogleFonts.play(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              );
            } else {
              _populateUsers(snapshot.data);

              //TODO - Setup a method that only populate the users list with new users

              Comparator<User> scoreComparator =
                  (a, b) => a.score.compareTo(b.score);
              _users.sort(scoreComparator);
              return ListView.builder(
                shrinkWrap: true,
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  _setPathsByIndex(index);

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: ScoreboardCard(
                      score: _users[index].score,
                      position: index + 1,
                      photoUrl: _users[index].photoUrl,
                      name: _users[index].displayName,
                      arrowPath: _arrowPath,
                      circleAvatarPath: _avatarPath,
                      starPath: _starPath,
                    ),
                  );
                },
              );
            }
        }
      },
    );
  }

  void _populateUsers(QuerySnapshot data) {
    for (int i = 0; i < data.documents.length; i++) {
      User user = User.fromJson(data.documents[i].data);
      _users.add(user);
    }
  }

  _setPathsByIndex(int index) {
    if (index == 0) {
      _arrowPath = 'arrow_up_first';
      _starPath = 'star_first';
      _avatarPath = 'circle_first';
    } else if (index == 1) {
      _arrowPath = 'arrow_up_second';
      _starPath = 'star_second';
      _avatarPath = 'circle_second';
    } else if (index == 2) {
      _arrowPath = 'arrow_up_third';
      _starPath = 'star_third';
      _avatarPath = 'circle_third';
    } else {
      _arrowPath = 'arrow_down_regular';
      _starPath = 'star_regular';
      _avatarPath = 'circle_regular';
    }
  }
}
