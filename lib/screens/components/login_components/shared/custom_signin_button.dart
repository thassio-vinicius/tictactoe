import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSignInButton extends StatelessWidget {
  final Function onLoginTap;
  final String buttonText;
  final Color buttonColor;

  CustomSignInButton({
    @required this.onLoginTap,
    @required this.buttonColor,
    @required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
      child: InkWell(
        onTap: onLoginTap,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.60,
          height: MediaQuery.of(context).size.height * 0.10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: buttonColor, width: 6)),
          child: Center(
            child: Text(
              buttonText,
              style: GoogleFonts.montserratAlternates(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
