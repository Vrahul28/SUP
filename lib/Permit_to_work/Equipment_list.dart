import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/Textform_field.dart';
import '../utils/colors.dart';

class EquipmentList extends StatelessWidget {
  final TextEditingController controller;
  const EquipmentList({
    required this.controller,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 260,
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black12,
              width: 2
          )
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 10.0, bottom: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Equipment Name*",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      )
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: kDarkblueColor),
                  onPressed: () {

                  },
                ),
              ],
            ),
            SizedBox(height: 5),
            CustomTextfield(
              controller: controller,
              errorMsg: 'Equipment Name',
              hinttext: '',
              lines: 1,
              Icons: null,
              obsuretext: false,
              // Icons: Icons.person,
            ),
            SizedBox(height: 20),
            Text(
              "Quantity*",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),
            SizedBox(height: 5),
            CustomTextfield(
              controller: controller,
              errorMsg: 'Quantity',
              hinttext: '',
              lines: 1,
              obsuretext: false,
              Icons: null,
            ),
          ],
        ),

      ),
    );
  }
}

