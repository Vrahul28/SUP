import 'dart:convert';
import 'dart:io';

import 'package:acp/company/addcompany/floor.dart';
import 'package:acp/login.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import '../../company/companymethods.dart';
import '../../company/companymodel.dart';
import '../../utils/colors.dart';


String tower= '';
class Location extends StatefulWidget {
  final TextEditingController controller1;
  final String hint;

  Location({
    Key? key,
    required this.controller1,
    required this.hint,

  }) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}


class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
      child: TypeAheadField<Company?>(
          hideWithKeyboard: true,
        controller: widget.controller1,
          builder: (context, controller, focusNode) {
            return TextFormField(
              cursorColor: kDarkblueColor,
              style: GoogleFonts.poppins(
                color: kDarkblueColor,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
              controller: widget.controller1,
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
            List<String> predefinedTowers = ['1', '2', '3', '4', '5'];
            return predefinedTowers
                .where((tower) => tower.toLowerCase().contains(pattern.toLowerCase()))
                .map((tower) => Company(towerId: tower)) // Convert the list to Company objects
                .toList();
          },
          itemBuilder: (context, Company? suggestion) {
            final towers = suggestion!;
            return ListTile(
              title: Text(towers.towerId ?? '', style: GoogleFonts.poppins(
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
                  'No Tower Found.',
                  style: GoogleFonts.poppins(
                    color: kbluelightColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  )
              ),
            ),
          ),
          onSelected: (Company? suggestion){
            if (suggestion != null) {
              widget.controller1.text = suggestion.towerId?? '';
              tower=  widget.controller1.text;
              getTower(tower);
              getFloor(tower);
            }
          },
        ),

    );
  }
}

//  Floor

List<Floor> floorData= [];

Future<void> getFloor(String towerID) async{
  floorData.clear();
  String url= "http://111.223.92.154:8091/acp_api/floorManagement.php?tower_id=$towerID";
  String completeUrl= url;

  HttpOverrides.global = MyHttpOverrides();

  var response = await http.get(
    Uri.parse(completeUrl),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded'
    },
  );

  if(response.statusCode==200){
    var jsonresponse= jsonDecode(response.body);
    print(jsonresponse);
    for(var item in jsonresponse){
      final floor= Floor.fromJson(item);
      floorData.add(floor);
    }
  }

}

class FloorTextField extends StatefulWidget {
  final TextEditingController controller1;
  final String hint;

  const FloorTextField({
    super.key,
    required this.controller1,
    required this.hint,

  });

  @override
  State<FloorTextField> createState() => _FloorTextFieldState();
}


class _FloorTextFieldState extends State<FloorTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
      child: TypeAheadField<Floor?>(
        hideWithKeyboard: true,
        builder: (context, controller, focusNode) {
          return TextFormField(
            cursorColor: kDarkblueColor,
            style: GoogleFonts.poppins(
              color: kDarkblueColor,
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
            ),
            controller: widget.controller1,
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
          return floorData
              .where((floor) => floor.floor!.toLowerCase().contains(pattern.toLowerCase()))
              .toList();
        },
        itemBuilder: (context, Floor? suggestion) {
          final floors = suggestion!;
          return ListTile(
            title: Text(floors.floor ?? '', style: GoogleFonts.poppins(
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
                'No Floor Found.',
                style: GoogleFonts.poppins(
                  color: kbluelightColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                )
            ),
          ),
        ),
        onSelected: (Floor? suggestion){
          if (suggestion != null) {
            widget.controller1.text = suggestion.floor?? '';
            tower=  widget.controller1.text;
            getTower(tower);
          }
        },
      ),
    );
  }
}


class Uag extends StatefulWidget {
  final TextEditingController controller1;
  final String hint;

  Uag({
    Key? key,
    required this.controller1,
    required this.hint,
  }) : super(key: key);

  @override
  State<Uag> createState() => _UagState();
}

class _UagState extends State<Uag> {
  List<String> selectedTowers = [];
  void initState() {
    super.initState();

    // Set initial value when the widget is first created
    selectedTowers = widget.controller1.text.isNotEmpty
        ? widget.controller1.text.split(', ').where((element) => element.isNotEmpty).toList()
        : ['Tower 1', 'Tower 2', 'Tower 3', 'Tower 4', 'Tower 5'];

    widget.controller1.text = selectedTowers.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.grey), // Set your desired border color
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
            {"display": "Tower 1", "value": "Tower 1"},
            {"display": "Tower 2", "value": "Tower 2"},
            {"display": "Tower 3", "value": "Tower 3"},
            {"display": "Tower 4", "value": "Tower 4"},
            {"display": "Tower 5", "value": "Tower 5"},
          ],
          textField: 'display',
          fillColor: kGinColor,
          checkBoxActiveColor: kDarkblueColor,
          valueField: 'value',
          enabled: false,
          okButtonLabel: 'OK',
          cancelButtonLabel: 'CANCEL',
          // hintWidget: Text(
          //   widget.hint,
          //   style: GoogleFonts.poppins(
          //     color: kDarkblueColor,
          //     fontWeight: FontWeight.w600,
          //     fontSize: 15.0,
          //   ),
          // ),

          // initialValue: (usernameController.text =="ara@gmail.com") ? ['Tower 1','Tower 2','Tower 3','Tower 4','Tower 5'] :
          // (usernameController.text == "admin@gmail.com") ? [] : (widget.controller1.text.isNotEmpty ? widget.controller1.text.split(', ') : []),

          initialValue: selectedTowers,

          // onSaved: (value) {
          //     if (value == null) return;
          //     setState(() {
          //       selectedTowers = ['Tower 1','Tower 2','Tower 3','Tower 4','Tower 5'];
          //       widget.controller1.text = selectedTowers.join(', ');
          //     });
          //     // widget.controller1.text = selectedTowers.join('Tower 1, ');
          //
          // },

        ),
      )
    );
  }
}

class Uag1 extends StatefulWidget {
  final TextEditingController controller1;
  final String hint;

  Uag1({
    Key? key,
    required this.controller1,
    required this.hint,
  }) : super(key: key);

  @override
  State<Uag1> createState() => _Uag1State();
}

class _Uag1State extends State<Uag1> {
  List<String> selectedTowers = [];

  @override
  void initState() {
    super.initState();
    // Ensure that the controller text is parsed into a list for the initial value
    if (widget.controller1.text.isNotEmpty) {
      selectedTowers = widget.controller1.text.split(', ').map((e) => e.trim()).toList();
    } else {
      selectedTowers = [];
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
              {"display": "1", "value": "1"},
              {"display": "2", "value": "2"},
              {"display": "3", "value": "3"},
              {"display": "4", "value": "4"},
              {"display": "5", "value": "5"},
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
            initialValue: selectedTowers,
            onSaved: (value) {
              if(usernameController.text == "admin@gmail.com"){
                if (value == null) return;
                setState(() {
                  selectedTowers = value.cast<String>();
                });
                widget.controller1.text = selectedTowers.join(', ');
              }

            },
          ),
        )
    );
  }
}

void dateRange(BuildContext context, TextEditingController Startdate) async{

  DateTime now = DateTime.now();

  DateTimeRange date = DateTimeRange(
    start: now,
    end: now.add(Duration(days: 7)),
  );

  DateTimeRange? range = await showDateRangePicker(
    context: context,
    initialDateRange: date,
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );

  if (range != null) {
    String startDate = "${range.start.month}/${range.start.day}/${range.start.year}";
    String endDate = "${range.end.month}/${range.end.day}/${range.end.year}";

    Startdate.text = "$startDate 12:00 AM - $endDate 11:59 PM";
    print(Startdate.text);
  }

}

