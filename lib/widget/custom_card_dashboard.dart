import 'package:acp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCardDashboard extends StatelessWidget {
  final String text;
  final Icon icon;
  final Color color;
  final VoidCallback onTap;
  const CustomCardDashboard({
    required this.text,
    required this.icon,
    required this.color,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: kDarkblueColor,
        child: Container(
          padding: EdgeInsets.only(left: 20.0,right: 20.0,top: 20.0,bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50, height: 50,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: icon,
              ),
              SizedBox(height: 20),
              Text(text,style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                color: Colors.white
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
