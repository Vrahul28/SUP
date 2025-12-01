import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckboxText extends StatefulWidget {
  final String text;
   final bool? value;
  final ValueChanged<bool> onChanged;
  const CheckboxText({required this.text, required this.value,required this.onChanged,super.key});

  @override
  State<CheckboxText> createState() => _CheckboxTextState();
}

class _CheckboxTextState extends State<CheckboxText> {
  late bool? _localValue;  // Local state to manage checkbox value

  @override
  void initState() {
    super.initState();
    _localValue = widget.value; // Initialize local value with widget's value
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: widget.value,
          onChanged: (bool? newValue) {
            setState(() {
              _localValue = newValue;
            });
            widget.onChanged(newValue!);  // Notify parent widget
          },
        ),
        Flexible(
          child: Text(
            widget.text,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500
              ),
            ),
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
