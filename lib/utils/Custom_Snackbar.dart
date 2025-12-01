import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class CustomSnackbar {
  final String text;

  CustomSnackbar({required this.text});

  SnackBar getSnackbar() {
    return SnackBar(
      backgroundColor: Colors.white,
      content: Text(text , style: GoogleFonts.poppins(
        color: kDarkblueColor,
        fontWeight: FontWeight.w600,
        fontSize: 15.0,
      ),),
      duration: Duration(seconds: 3),
    );
  }
}