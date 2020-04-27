import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/screens/components/front_cards/menu_card.dart';
import 'package:tictactoe/screens/components/front_cards/signin_card.dart';
import 'package:tictactoe/screens/components/front_cards/signoptions_card.dart';
import 'package:tictactoe/screens/components/front_cards/signup_card.dart';
import 'package:tictactoe/screens/options_screen.dart';

class BackgroundScreen extends StatefulWidget {
  final Screens screens;

  BackgroundScreen({@required this.screens});

  @override
  _BackgroundScreenState createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends State<BackgroundScreen> {
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
                      if ((widget.screens == Screens.initialScreen) ||
                          (widget.screens == Screens.signInScreen))
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
      case Screens.homeScreen:
        return MenuCard();
        break;
      case Screens.optionsScreen:
        return OptionsScreen();
        break;
    }
  }
}

enum Screens {
  initialScreen,
  signUpScreen,
  signInScreen,
  homeScreen,
  optionsScreen
}
