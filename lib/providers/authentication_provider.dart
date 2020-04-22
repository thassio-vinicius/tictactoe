import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tictactoe/models/user.dart';

class AuthenticationProvider extends ChangeNotifier {
  FirebaseUser _user;
  var _auth = FirebaseAuth.instance;
  Firestore _firestore = Firestore();

  FirebaseUser get user => _user;

  emailSignIn(String email, String password) async {
    AuthResult auth = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    _checkAndAddUser(auth: auth);
  }

  anonymousSignIn() async {
    AuthResult auth = await _auth.signInAnonymously();

    return auth;
  }

  facebookSignIn(LoginOptions options) async {
    //var googleSignIn = await GoogleSignIn.games().signIn();

    var facebookSignIn =
        await FacebookLogin().logIn(['email', 'public_profile']);
    var credential = FacebookAuthProvider.getCredential(
        accessToken: facebookSignIn.accessToken.token);

    AuthResult auth;

    switch (facebookSignIn.status) {
      case FacebookLoginStatus.loggedIn:
        auth = await _auth.signInWithCredential(credential);

        _checkAndAddUser(auth: auth);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("Facebook login cancelled");
        break;
      case FacebookLoginStatus.error:
        print(facebookSignIn.errorMessage);
        break;
    }
  }

  googleSignIn() async {
    var googleSignIn = await GoogleSignIn.standard().signIn();

    var tokens = await googleSignIn.authentication;

    var credential = GoogleAuthProvider.getCredential(
        idToken: tokens.idToken, accessToken: tokens.accessToken);

    AuthResult auth = await _auth.signInWithCredential(credential);

    await _checkAndAddUser(auth: auth);
  }

  _checkAndAddUser({AuthResult auth}) async {
    var user = User(
      displayName: auth.user.displayName,
      email: auth.user.email,
      photoUrl: auth.user.photoUrl,
      uid: auth.user.uid,
    ).toJson();

    await _firestore.collection('users').getDocuments().then((docs) {
      if (docs.documents.isEmpty) {
        _firestore.collection('users').document(user['email']).setData(user);
      } else {
        for (int i = 0; i < docs.documents.length; i++) {
          if (docs.documents[i].data['email'] != auth.user.email) {
            _firestore
                .collection('users')
                .document(user['email'])
                .setData(user);
          }
        }
      }
    });
  }
}

enum LoginOptions { anonymous, facebook, google, email }
