import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/models/user.dart';
import 'package:tictactoe/providers/authentication_provider.dart';
import 'package:tictactoe/screens/home_screen.dart';
import 'package:tictactoe/utils/hex_color.dart';

class ConfirmButton extends StatelessWidget {
  final bool isSignUpOption;
  final String email;
  final String password;
  final String displayName;

  ConfirmButton(
      {@required this.isSignUpOption,
      @required this.email,
      @required this.password,
      this.displayName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onConfirmTap(context, isSignUpOption: isSignUpOption),
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

  _onConfirmTap(BuildContext context, {bool isSignUpOption}) async {
    User user = User(
      email: email.toLowerCase().trim().replaceAll(' ', ''),
      password: password,
      displayName: displayName,
    );

    if (isSignUpOption) {
      await Provider.of<AuthenticationProvider>(context, listen: false)
          .emailSignUp(user: user);
    } else {
      await Provider.of<AuthenticationProvider>(context, listen: false)
          .emailSignIn(
              email.toLowerCase().trim().replaceAll(' ', ''), password);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(),
      ),
    );
  }
}
