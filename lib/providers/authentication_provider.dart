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

    checkAndAddUser(auth: auth);
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

        checkAndAddUser(auth: auth);
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

    await checkAndAddUser(auth: auth);
  }

  checkAndAddUser({AuthResult auth, User user, bool isSignUp = false}) async {
    var userAsMap;
    if (auth != null) {
      userAsMap = User(
        displayName: auth.user.displayName,
        email: auth.user.email,
        photoUrl: auth.user.photoUrl,
        uid: auth.user.uid,
      ).toJson();
    }

    await _firestore.collection('users').getDocuments().then((docs) {
      if (docs.documents.isEmpty) {
        _firestore
            .collection('users')
            .document(userAsMap['email'])
            .setData(userAsMap);
      } else {
        for (int i = 0; i < docs.documents.length; i++) {
          if (isSignUp) {
            if (docs.documents[i].data['email'] != user.email) {
              _firestore
                  .collection('users')
                  .document(user.email)
                  .setData(user.toJson());
            }
          } else {
            if (docs.documents[i].data['email'] != auth.user.email) {
              _firestore
                  .collection('users')
                  .document(userAsMap['email'])
                  .setData(userAsMap);
            }
          }
        }
      }
    });
  }
}

enum LoginOptions { anonymous, facebook, google, email }
