import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String text;
  const TextWidget({required this.text,super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w500
          )
        )
    );
  }
}
