import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/Textform_field.dart';
import 'Date_picker.dart';
import 'Time_picker.dart';

class ParkingDetails extends StatefulWidget {
  final TextEditingController controller, controller2, controller3,controller4,controller5,controller6,controller7,controller8;
  const ParkingDetails({
    required this.controller,
    required this.controller2,
    required this.controller3,
    required this.controller4,
    required this.controller5,
    required this.controller6,
    required this.controller7,
    required this.controller8,
    super.key
  });

  @override
  State<ParkingDetails> createState() => _ParkingDetailsState();
}

class _ParkingDetailsState extends State<ParkingDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 940,
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
            SizedBox(height: 20),
            Text(
              "Item 1",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "First Name*",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),
            const SizedBox(height: 5),
            CustomTextfield(
              controller: widget.controller,
              errorMsg: 'First Name',
              hinttext: '',
              lines: 1,
              obsuretext: false,
              Icons: null,
              // Icons: Icons.person,
            ),

            const SizedBox(height: 20),
            Text(
              "Last Name*",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),
            const SizedBox(height: 5),
            CustomTextfield(
              controller: widget.controller2,
              errorMsg: 'Last Name',
              hinttext: '',
              lines: 1,
              Icons: null,
              obsuretext: false,
              // Icons: Icons.person,
            ),

            const SizedBox(height: 20),
            Text(
              "Vehicle Registration Plate Number*",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),
            const SizedBox(height: 5),
            CustomTextfield(
              controller: widget.controller3,
              errorMsg: 'Vehicle Registration',
              hinttext: '',
              lines: 1,
              Icons: null,
              obsuretext: false,
              // Icons: Icons.person,
            ),

            SizedBox(height: 20),
            Text(
              "Parking Location*",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),
            const SizedBox(height: 5),
            CustomTextfield(
              controller: widget.controller4,
              errorMsg: 'Parking Location',
              hinttext: '',
              lines: 1,
              Icons: null,
              obsuretext: false,
              // Icons: Icons.person,
            ),
            //
            Text(
              "Start Date*",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),
            const SizedBox(height: 5),
            DateTimePicker(controller: widget.controller5,hinttext: "Start Date",),
            const SizedBox(height: 20),
            Text(
              "Start Time*",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),
            const SizedBox(height: 5),
            TimePicker(controller1: widget.controller6,),

            const SizedBox(height: 20),
            Text(
              "End Date*",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),
            const SizedBox(height: 5),
            DateTimePicker(controller: widget.controller7,hinttext: "End Date",),
            const SizedBox(height: 20),
            Text(
              "End Time*",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),
            const SizedBox(height: 5),
            TimePicker(controller1: widget.controller8),

          ],
        ),
      ),
    );
  }
}
