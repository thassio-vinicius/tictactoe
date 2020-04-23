import 'package:flutter/cupertino.dart';

class User {
  String uid;
  String displayName;
  String password;
  String email;
  String photoUrl;
  String ranking;
  int score;

  User({
    @required this.displayName,
    @required this.email,
    this.password,
    this.uid,
    this.photoUrl,
    this.ranking,
    this.score,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      displayName: json['displayName'],
      email: json['email'],
      password: json['password'],
      score: json['score'],
      uid: json['uid'],
      photoUrl: json['photoUrl'],
      ranking: json['ranking'],
    );
  }

  Map<String, dynamic> toJson() => {
        'displayName': this.displayName,
        'email': this.email,
        'password': this.password,
        'score': this.score,
        'uid': this.uid,
        'photoUrl': this.photoUrl,
        'ranking': this.ranking,
      };
}
