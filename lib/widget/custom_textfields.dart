import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';

class CustomUsernameTextFields extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool hidden;
  final IconButton? suffixIcon;
  const CustomUsernameTextFields({
    required this.controller,
    required this.hint,
    required this.icon,
    required this.hidden,
    this.suffixIcon,
    super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.poppins(
        color: kDarkblueColor,
        fontWeight: FontWeight.w600,
        fontSize: 15.0,
      ),
      cursorColor: kDarkblueColor,
      controller: controller,
      obscureText: hidden,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(18.0),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(
            icon,
            size: 24.0,
            color: kDarkblueColor,
          ),
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: kGinColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: kDarkblueColor),
          ),
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
            color: kDarkblueColor,
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
          )
      ),
    );
  }
}
