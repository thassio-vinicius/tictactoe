import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/models/user.dart';
import 'package:tictactoe/providers/authentication_provider.dart';
import 'package:tictactoe/screens/home_screen.dart';
import 'package:tictactoe/utils/hex_color.dart';

enum Screens { initialScreen, signUpScreen, signInScreen }

class SignOptionsScreen extends StatefulWidget {
  final Screens screens;

  SignOptionsScreen({@required this.screens});

  @override
  _SignOptionsScreenState createState() => _SignOptionsScreenState();
}

class _SignOptionsScreenState extends State<SignOptionsScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/logo.png'),
                      Text(
                        'Sign In with your account',
                        style: GoogleFonts.play(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      _switchBetweenCards(widget.screens),
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }

  _switchBetweenCards(Screens screens) {
    switch (screens) {
      case Screens.initialScreen:
        return _buildSignOptionsCard();
        break;
      case Screens.signUpScreen:
        return _buildSignUpCard();
        break;
      case Screens.signInScreen:
        return _buildSignInCard();
        break;
    }
  }

  Widget _buildSignInCard() {
    return Column(
      children: <Widget>[
        _customTextField(controller: _emailController, label: 'e-mail'),
        _customTextField(
          controller: _passwordController,
          label: 'password',
          obscureText: true,
        ),
        _confirmButton(),
      ],
    );
  }

  Column _buildSignOptionsCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _customSignInOptions(
          buttonText: 'Sign in with e-mail',
          buttonColor: HexColor('#CB2376'),
          onLoginTap: () => _onLoginTap(LoginOptions.email),
        ),
        _customSignInOptions(
          buttonText: 'Sign in anonymously',
          buttonColor: HexColor('#6FB352'),
          onLoginTap: () => _onLoginTap(LoginOptions.anonymous),
        ),
        _signUpOption(),
        _buildDivider(),
        Column(
          children: <Widget>[
            _googleFacebookSignOptions(
              asset: 'assets/images/google_logo.png',
              onTap: () => _onLoginTap(LoginOptions.google),
              label: 'Sign In with Google',
            ),
            _googleFacebookSignOptions(
              asset: 'assets/images/facebook_logo.png',
              onTap: () => _onLoginTap(LoginOptions.facebook),
              label: 'Sign In with Facebook',
            ),
          ],
        )
      ],
    );
  }

  Widget _customSignInOptions({
    Function onLoginTap,
    String buttonText,
    Color buttonColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
      child: InkWell(
        onTap: onLoginTap,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.50,
          height: MediaQuery.of(context).size.height * 0.10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: buttonColor, width: 6)),
          child: Text(
            buttonText,
            style: GoogleFonts.montserratAlternates(
              fontSize: 18,
              color: buttonColor,
              fontWeight: FontWeight.w800,
            ),
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

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(),
          ),
        );
        break;
      case LoginOptions.facebook:
        await Provider.of<AuthenticationProvider>(context, listen: false)
            .facebookSignIn(options);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(),
          ),
        );
        break;
      case LoginOptions.google:
        await Provider.of<AuthenticationProvider>(context, listen: false)
            .googleSignIn();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(),
          ),
        );
        break;
      case LoginOptions.email:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    SignOptionsScreen(screens: Screens.signInScreen)));
        break;
    }
  }

  _buildSignUpCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Create your account',
          style: GoogleFonts.montserratAlternates(
            fontWeight: FontWeight.bold,
            color: HexColor('#6FB352'),
            fontSize: 24,
          ),
        ),
        CircleAvatar(
          child: Placeholder(),
          radius: 40,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _customTextField(
              controller: _nameController,
              label: 'name',
            ),
            _customTextField(
              controller: _emailController,
              label: 'e-mail',
            ),
            _customTextField(
              controller: _passwordController,
              label: 'password',
              obscureText: true,
            ),
            _confirmButton(),
          ],
        )
      ],
    );
  }

  TextField _customTextField({
    TextEditingController controller,
    bool obscureText = false,
    String label,
  }) =>
      TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: Colors.black, fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
          contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        ),
      );

  _confirmButton() {
    return InkWell(
      onTap: () =>
          _onConfirmTap(isSignUpOption: widget.screens == Screens.signUpScreen),
      child: Text(
        'Confirm',
        style: GoogleFonts.montserratAlternates(
          fontSize: 24,
          color: HexColor('#8AD0F6'),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _onConfirmTap({bool isSignUpOption}) async {
    User user = User(
      email: _emailController.text,
      password: _passwordController.text,
      displayName: _nameController.text,
    );

    print(user);
    print(user.password);
    print(user.email);
    print(user.displayName);

    if (isSignUpOption) {
      await Provider.of<AuthenticationProvider>(context, listen: false)
          .checkAndAddUser(isSignUp: true, user: user);
    } else {
      await Provider.of<AuthenticationProvider>(context, listen: false)
          .emailSignIn(_emailController.text, _passwordController.text);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(),
      ),
    );
  }

  _signUpOption() {
    return Row(
      children: <Widget>[
        Text(
          "Doesn't have an account?",
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
                      SignOptionsScreen(screens: Screens.signUpScreen))),
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

  _buildDivider() {
    return Row(
      children: <Widget>[
        _divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            'OR',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        _divider(),
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
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: HexColor('#4E4E4E'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _divider() => Container(
        width: MediaQuery.of(context).size.width * 0.30,
        height: 1,
        color: Colors.white,
      );
}
