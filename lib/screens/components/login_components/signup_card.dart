import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/screens/components/login_components/shared/confirm_button.dart';
import 'package:tictactoe/screens/components/login_components/shared/custom_textfield.dart';

class SignUpCard extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String url;
    //TODO - delete this variable and implement image picker

    return Container(
      height: MediaQuery.of(context).size.height * 0.60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Create your account',
            style: GoogleFonts.montserratAlternates(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          CircleAvatar(
            backgroundImage: url == null
                ? AssetImage('assets/images/logo.png')
                : NetworkImage(url),
            radius: 40,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            width: MediaQuery.of(context).size.width * 0.90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CustomTextField(
                  controller: _nameController,
                  hint: 'name',
                ),
                CustomTextField(
                  controller: _emailController,
                  hint: 'e-mail',
                ),
                CustomTextField(
                  controller: _passwordController,
                  hint: 'password',
                  obscureText: true,
                ),
                ConfirmButton(
                  isSignUpOption: true,
                  email: _emailController.text,
                  password: _passwordController.text,
                  displayName: _nameController.text,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
