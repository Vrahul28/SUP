import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import '../utils/colors.dart';

class SelectSourceField extends StatefulWidget {
  final TextEditingController controller1;
  final String hint;

  const SelectSourceField({
    super.key,
    required this.controller1,
    required this.hint,
  });

  @override
  State<SelectSourceField> createState() => _SelectSourceFieldState();
}

class _SelectSourceFieldState extends State<SelectSourceField> {
  List<String> selectedSource = [];

  @override
  void initState() {
    super.initState();
    // Ensure that the controller text is parsed into a list for the initial value
    if (widget.controller1.text.isNotEmpty) {
      selectedSource = widget.controller1.text.split(', ').map((e) => e.trim()).toList();
    } else {
      selectedSource = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: Colors.grey), // Set your desired border color
          ),
          child: MultiSelectFormField(
            autovalidate: AutovalidateMode.disabled,
            chipBackGroundColor: Colors.white,
            chipLabelStyle: TextStyle(color: kDarkblueColor),
            dialogTextStyle: GoogleFonts.poppins(
              color: kDarkblueColor,
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
            ),
            title: Text(
              widget.hint,
              style: GoogleFonts.poppins(
                color: kDarkblueColor,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
            ),
            dataSource: const [
              {"display": "kiosk", "value": "kiosk"},
              {"display": "vms", "value": "vms"},
              {"display": "concierge", "value": "concierge"},
            ],
            textField: 'display',
            fillColor: kGinColor,
            checkBoxActiveColor: kDarkblueColor,
            valueField: 'value',
            okButtonLabel: 'OK',
            cancelButtonLabel: 'CANCEL',
            // initialValue: widget.controller1.text.isNotEmpty
            //     ? widget.controller1.text.split(', ')
            //     : [],
            initialValue: selectedSource,
            onSaved: (value) {
                if (value == null) return;
                setState(() {
                  selectedSource = value.cast<String>();
                });
                widget.controller1.text = selectedSource.join(', ');

            },
          ),
        )
    );
  }
}


class SelectReportType extends StatefulWidget {
  final TextEditingController controller1;
  final String hint;

  const SelectReportType({
    super.key,
    required this.controller1,
    required this.hint,

  });

  @override
  State<SelectReportType> createState() => _SelectReportTypeState();
}


class _SelectReportTypeState extends State<SelectReportType> {
  List<String> reportTypes = ['Daily', 'Weekly', 'Monthly'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
      child: TypeAheadField(
        hideWithKeyboard: false,
        hideOnSelect: true,
        controller: widget.controller1,
        direction: VerticalDirection.up,
        builder: (context, controller, focusNode) {
          return TextFormField(
            controller: controller,
            focusNode: focusNode,
            cursorColor: kDarkblueColor,
            style: GoogleFonts.poppins(
              color: kDarkblueColor,
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(18.0),
              filled: true,
              fillColor:  kGinColor,
              prefixIcon: Icon(
                LineAwesomeIcons.location_arrow_solid,
                size: 24.0,
                color: kDarkblueColor,
              ),
              hintText: widget.hint,
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
        },
        suggestionsCallback: (pattern) async {
          return reportTypes
              .where((type) => type.toLowerCase().contains(pattern.toLowerCase()))
              .toList();
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion, style: GoogleFonts.poppins(
              color: kbluelightColor,
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
            )),
          );
        },
        emptyBuilder: (context) => SizedBox(
          height: 50,
          child: Center(
            child: Text(
                'No Report Type Found.',
                style: GoogleFonts.poppins(
                  color: kbluelightColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                )
            ),
          ),
        ),
        onSelected: (suggestion){
          widget.controller1.text = suggestion;
          },
      ),
    );
  }
}