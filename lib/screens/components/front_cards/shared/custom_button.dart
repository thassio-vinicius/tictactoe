import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String buttonLabel;
  final Color buttonColor;
  final double percentageWidth;

  CustomButton({
    @required this.onTap,
    @required this.buttonColor,
    @required this.buttonLabel,
    this.percentageWidth = 0.60,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width * percentageWidth,
          height: MediaQuery.of(context).size.height * 0.10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: buttonColor, width: 6)),
          child: Center(
            child: Text(
              buttonLabel,
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
