import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/providers/authentication_provider.dart';
import 'package:tictactoe/screens/background_screen.dart';
import 'package:tictactoe/screens/components/front_cards/shared/custom_button.dart';
import 'package:tictactoe/utils/hex_color.dart';

class SignOptionsCard extends StatefulWidget {
  @override
  _SignOptionsCardState createState() => _SignOptionsCardState();
}

class _SignOptionsCardState extends State<SignOptionsCard> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CustomButton(
          buttonLabel: 'Sign in with e-mail',
          buttonColor: HexColor('#CB2376'),
          onTap: () => _onLoginTap(LoginOptions.email, context),
        ),
        CustomButton(
          buttonLabel: 'Sign in anonymously',
          buttonColor: HexColor('#6FB352'),
          onTap: () => _onLoginTap(LoginOptions.anonymous, context),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.17,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _signUpOption(),
              _buildDividers(),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _googleFacebookSignOptions(
                asset: 'assets/images/icons/google_logo.png',
                onTap: () => _onLoginTap(LoginOptions.google, context),
                label: 'Sign In with Google',
              ),
              _googleFacebookSignOptions(
                asset: 'assets/images/icons/facebook_logo.png',
                onTap: () => _onLoginTap(LoginOptions.facebook, context),
                label: 'Sign In with Facebook',
              ),
            ],
          ),
        )
      ],
    );
  }

  _onLoginTap(LoginOptions options, BuildContext context) async {
    switch (options) {
      case LoginOptions.anonymous:
        await Provider.of<AuthenticationProvider>(context, listen: false)
            .anonymousSignIn();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => BackgroundScreen(screens: Screens.homeScreen),
          ),
        );
        break;
      case LoginOptions.facebook:
        await Provider.of<AuthenticationProvider>(context, listen: false)
            .facebookSignIn(options);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => BackgroundScreen(screens: Screens.homeScreen),
          ),
        );
        break;
      case LoginOptions.google:
        await Provider.of<AuthenticationProvider>(context, listen: false)
            .googleSignIn();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => BackgroundScreen(screens: Screens.homeScreen),
          ),
        );
        break;
      case LoginOptions.email:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    BackgroundScreen(screens: Screens.signInScreen)));
        break;
    }
  }

  _signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Doesn't have an account? ",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
        ),
        InkWell(
          onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      BackgroundScreen(screens: Screens.signUpScreen))),
          child: Text(
            'Sign Up!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }

  _buildDividers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _dividerLine(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'OR',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        _dividerLine(),
      ],
    );
  }

  _googleFacebookSignOptions({String asset, String label, Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: <Widget>[
              Image.asset(asset),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: HexColor('#4E4E4E'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _dividerLine() => Container(
        width: MediaQuery.of(context).size.width * 0.30,
        height: 1,
        color: Colors.white,
      );
}
