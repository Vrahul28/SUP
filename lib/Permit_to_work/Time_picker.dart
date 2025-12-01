import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../utils/colors.dart';

class TimePicker extends StatelessWidget {
  final TextEditingController controller1;

  TimePicker({
    Key? key,
    required this.controller1,
  }) : super(key: key);

  List<String> _generateTimeSlots() {
    List<String> timeSlots = [];
    DateTime startTime = DateTime(0, 1, 1, 0, 0); // Start at 12:00 AM
    DateTime endTime = DateTime(0, 1, 1, 23, 45); // End at 11:45 PM

    while (startTime.isBefore(endTime) || startTime == endTime) {
      timeSlots.add(DateFormat.jm().format(startTime)); // Format time to AM/PM
      startTime = startTime.add(Duration(minutes: 15)); // Add 15 minutes
    }

    return timeSlots;
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String?>(
        hideWithKeyboard: true,
      controller: controller1,
        builder: (context, controller, focusNode) {
          return TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a time';
                }
                return null;
              },
              style: GoogleFonts.poppins(
                color: kDarkblueColor,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
              controller: controller1,
              decoration: InputDecoration(
                filled: true,
                fillColor: kGinColor,
                prefixIcon: Icon(
                  Icons.schedule, // Change to a more relevant icon
                  size: 24.0,
                  color: kDarkblueColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: kGinColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: kDarkblueColor),
                ),
              )
          );
        },
        suggestionsCallback: (pattern) async {
          List<String> timeSlots = _generateTimeSlots();
          return timeSlots
              .where((timeSlot) =>
              timeSlot.toLowerCase().contains(pattern.toLowerCase()))
              .toList();
        },
        itemBuilder: (context, String? suggestion) {
          return ListTile(
            title: Text(
              suggestion ?? '',
              style: GoogleFonts.poppins(
                color: kbluelightColor,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
            ),
          );
        },
        emptyBuilder: (context) => SizedBox(
          height: 50,
          child: Center(
            child: Text('No Time Found.',
                style: GoogleFonts.poppins(
                  color: kbluelightColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                )),
          ),
        ),
        onSelected: (String? suggestion) {
          if (suggestion != null) {
            controller1.text = suggestion;
          }
        },
      );

  }
}