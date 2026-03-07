import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final Icons;
  final int lines;
  final String? errorMsg;
  final bool obsuretext;
  const CustomTextfield({
    required this.controller,
    required this.hinttext,
    required this.lines,
    this.Icons,
    this.errorMsg,
    required this.obsuretext,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kDarkblueColor,
      maxLines: lines,
      style: GoogleFonts.poppins(
        color: kDarkblueColor,
        fontWeight: FontWeight.w600,
        fontSize: 15.0,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMsg;
        }
        return null;
      },
      controller: controller,
      obscureText: obsuretext,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(18.0),
        filled: true,
        fillColor:  kGinColor,
        prefixIcon: Icon(
          Icons,
          size: 24.0,
          color: kDarkblueColor,
        ),
        hintText: hinttext,
        // labelText: 'Search',
        hintStyle: GoogleFonts.poppins(
          color: kDarkblueColor,
          fontWeight: FontWeight.w600,
          fontSize: 15.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: kGinColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: kDarkblueColor),
        ),
      ),
    );
  }
}
