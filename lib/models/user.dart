import 'package:flutter/cupertino.dart';

class User {
  String id;
  String name;
  String email;
  String photoUrl;
  String ranking;
  int score;

  User({
    @required this.name,
    @required this.email,
    this.id,
    this.photoUrl,
    this.ranking,
    this.score,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      score: json['score'],
      id: json['id'],
      photoUrl: json['photoUrl'],
      ranking: json['ranking'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'email': this.email,
        'score': this.score,
        'id': this.id,
        'photoUrl': this.photoUrl,
        'ranking': this.ranking,
      };
}
