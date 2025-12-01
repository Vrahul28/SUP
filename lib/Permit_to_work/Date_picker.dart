import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class DateTimePicker extends StatefulWidget {
  final TextEditingController controller;
  final String hinttext;
  const DateTimePicker({
    required this.controller,
    required this.hinttext,
    super.key});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {

  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: selectedDate.add(Duration(days: 14)));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        String date= "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
        controller.text = date;
      });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kDarkblueColor,
      style: GoogleFonts.poppins(
        color: kDarkblueColor,
        fontWeight: FontWeight.w600,
        fontSize: 15.0,
      ),
      keyboardType: TextInputType.datetime,
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(18.0),
        filled: true,
        fillColor:  kGinColor,
        prefixIcon: IconButton(
          icon: Icon(Icons.calendar_month,size: 24.0,color: kDarkblueColor),
          onPressed: () {
            _selectDate(context,widget.controller);
          },
        ),
        hintText: widget.hinttext,
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


