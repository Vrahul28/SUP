import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kDarkblueColor = const Color(0xF0182439);
Color kDarkblueColor2 = const Color(0xF0344B75);
Color kbluelightColor = const Color(0xFF344F7C);
Color kGinColor = const Color(0xFFDDE6FA);
Color kGinColor2 = const Color(0xFFECF3FF);
Color kBlueColor = const Color(0xFFC9C9E8);
Color kSpiritedGreen = const Color(0xFFC1DFCB);
Color kFoamColor = const Color(0xFFEBFDF2);
Color kGreyColor = Colors.grey.shade600;

TextStyle kBillTextStyle = GoogleFonts.poppins(
  color: kDarkblueColor,
  fontSize: 15.0,
);

TextStyle get subHeadingStyle {
  return GoogleFonts.poppins(
      textStyle: TextStyle(
        // color: Get.isDarkMode ? Colors.white : Colors.black,
        color:kDarkblueColor,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ));
}