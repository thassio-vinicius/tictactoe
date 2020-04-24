import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/screens/components/login_components/shared/confirm_button.dart';
import 'package:tictactoe/screens/components/login_components/shared/custom_textfield.dart';

class SignInCard extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      width: MediaQuery.of(context).size.width * 0.90,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CustomTextField(controller: _emailController, hint: 'e-mail'),
            CustomTextField(
              controller: _passwordController,
              hint: 'password',
              obscureText: true,
            ),
            ConfirmButton(
              isSignUpOption: false,
              email: _emailController.text,
              password: _passwordController.text,
            ),
          ],
        ),
      ),
    );
  }
}
