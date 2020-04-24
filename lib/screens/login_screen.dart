import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/screens/components/login_components/signin_card.dart';
import 'package:tictactoe/screens/components/login_components/signoptions_card.dart';
import 'package:tictactoe/screens/components/login_components/signup_card.dart';

class SignOptionsScreen extends StatefulWidget {
  final Screens screens;

  SignOptionsScreen({@required this.screens});

  @override
  _SignOptionsScreenState createState() => _SignOptionsScreenState();
}

class _SignOptionsScreenState extends State<SignOptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.fill,
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 36),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: MediaQuery.of(context).size.width * 0.30,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      if (!(widget.screens == Screens.signUpScreen))
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.play(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                        ),
                      _switchBetweenCards(widget.screens),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _switchBetweenCards(Screens screens) {
    switch (screens) {
      case Screens.initialScreen:
        return SignOptionsCard();
        break;
      case Screens.signUpScreen:
        return SignUpCard();
        break;
      case Screens.signInScreen:
        return SignInCard();
        break;
    }
  }
}

enum Screens { initialScreen, signUpScreen, signInScreen }
