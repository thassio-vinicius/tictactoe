import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/providers/authentication_provider.dart';
import 'package:tictactoe/screens/home_screen.dart';
import 'package:tictactoe/utils/hex_color.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
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
              width: MediaQuery.of(context).size.width * 0.70,
              height: MediaQuery.of(context).size.height * 0.50,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(2.0, 4.0),
                    blurRadius: 24,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildLoginOption(
                      loginText: 'Log in with Facebook',
                      buttonColor: HexColor('#8AD0F6'),
                      onLoginTap: () => _onLoginTap(LoginOptions.facebook),
                    ),
                    _buildLoginOption(
                      loginText: 'Log in with Google',
                      buttonColor: Colors.white,
                      onLoginTap: () => _onLoginTap(LoginOptions.google),
                    ),
                    _buildLoginOption(
                      loginText: 'Log in with e-mail',
                      buttonColor: HexColor('#6FB352'),
                      onLoginTap: () => _onLoginTap(LoginOptions.email),
                    ),
                    _buildLoginOption(
                      loginText: 'Sign in anonymously',
                      buttonColor: HexColor('#CB2376'),
                      onLoginTap: () => _onLoginTap(LoginOptions.anonymous),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLoginOption({
    Function onLoginTap,
    String loginText,
    Color buttonColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
      child: InkWell(
        onTap: onLoginTap,
        child: Text(
          loginText,
          style: GoogleFonts.montserratAlternates(
            fontSize: 20,
            color: buttonColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _onLoginTap(LoginOptions options) async {
    switch (options) {
      case LoginOptions.anonymous:
        await Provider.of<AuthenticationProvider>(context, listen: false)
            .anonymousSignIn();
        break;
      case LoginOptions.facebook:
        await Provider.of<AuthenticationProvider>(context, listen: false)
            .facebookSignIn(options);
        break;
      case LoginOptions.google:
        await Provider.of<AuthenticationProvider>(context, listen: false)
            .googleSignIn();
        break;
      case LoginOptions.email:
        await Provider.of<AuthenticationProvider>(context, listen: false)
            .emailSignIn('thassinhoster@gmail.com', '123456');
        break;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(),
      ),
    );
  }
}
