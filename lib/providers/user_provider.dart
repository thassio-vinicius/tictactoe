import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tictactoe/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user;
  Firestore _firestore = Firestore();

  User get user => _user;

  set user(User value) {
    _user = value;
    notifyListeners();
  }

  void updateUserScore() async {
    int score = user.score++;

    await _firestore
        .collection('users')
        .document(user.email)
        .updateData({'score': score});

    notifyListeners();
  }

  Stream<QuerySnapshot> getAllUsers() {
    var query = _firestore.collection('users').snapshots();

    return query;
  }
}
