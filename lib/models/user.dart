import 'package:flutter/cupertino.dart';

class User {
  String uid;
  String displayName;
  String email;
  String photoUrl;
  String ranking;
  int score;

  User({
    @required this.displayName,
    @required this.email,
    this.uid,
    this.photoUrl,
    this.ranking,
    this.score,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      displayName: json['displayName'],
      email: json['email'],
      score: json['score'],
      uid: json['uid'],
      photoUrl: json['photoUrl'],
      ranking: json['ranking'],
    );
  }

  Map<String, dynamic> toJson() => {
        'displayName': this.displayName,
        'email': this.email,
        'score': this.score,
        'uid': this.uid,
        'photoUrl': this.photoUrl,
        'ranking': this.ranking,
      };
}
