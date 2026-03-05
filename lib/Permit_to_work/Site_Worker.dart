
import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../utils/Textform_field.dart';
import '../utils/colors.dart';

class SiteWorker extends StatefulWidget {
  final TextEditingController controller, controller2, controller3,controller4;
  const SiteWorker({
    required this.controller,
    required this.controller2,
    required this.controller3,
    required this.controller4,
    super.key});

  @override
  State<SiteWorker> createState() => _SiteWorkerState();
}

class _SiteWorkerState extends State<SiteWorker> {
  int? _selectedValue;
  String countryValue = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 730,
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
              "Worker 1",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),
            SizedBox(height: 20),
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
            SizedBox(height: 5),
            CustomTextfield(
              controller: widget.controller,
              errorMsg: 'First Name',
              hinttext: '',
              lines: 1,
              obsuretext: false,
              Icons: null,
              // Icons: Icons.person,
            ),

            SizedBox(height: 20),
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
            SizedBox(height: 5),
            CustomTextfield(
              controller: widget.controller2,
              errorMsg: 'Last Name',
              hinttext: '',
              lines: 1,
              Icons: null,
              obsuretext: false,
              // Icons: Icons.person,
            ),

            SizedBox(height: 20),
            Text(
              "Role*",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),

            // Radio buttons in a Row
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: Text('Supervisor'),
                    value: 1,
                    groupValue: _selectedValue,
                    activeColor: kDarkblueColor,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedValue = value!;
                        debugPrint(_selectedValue.toString());
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text('Worker'),
                    value: 2,
                    groupValue: _selectedValue,
                    activeColor: kDarkblueColor,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedValue = value!;
                        debugPrint(_selectedValue.toString());
                      });
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            Text(
              "Contact Number*",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),
            SizedBox(height: 5),
            IntlPhoneField(
              controller: widget.controller3,
              style: GoogleFonts.poppins(
                color: kDarkblueColor,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor:  kGinColor,
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
              initialCountryCode: 'IN', // Default to India
              onChanged: (phone) {
                debugPrint(phone.completeNumber); // Output complete number with country code
              },
              onCountryChanged: (country) {
                debugPrint('Country changed to: ' + country.name);
              },
              dropdownTextStyle: GoogleFonts.poppins(
                  color: kDarkblueColor,
                  fontWeight: FontWeight.w600
              ),
            ),
            Text(
              "Nationality*",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),
            SizedBox(height: 5),
            CSCPickerPlus(
              flagState: CountryFlag.ENABLE,
              disabledDropdownDecoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: kDarkblueColor,
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              dropdownDecoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: kGinColor,
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              dropdownHeadingStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              showCities: false,
              showStates: false,
              searchBarRadius: 10,
              selectedItemStyle: GoogleFonts.poppins(
                  color: kDarkblueColor,
                  fontWeight: FontWeight.w500,
                  height: 3,
                  fontSize: 15
              ),
              defaultCountry: CscCountry.India,
              countryDropdownLabel: countryValue,
              onCountryChanged: (value) {
                setState(() {
                  countryValue = value;
                });
              },
            ),

            SizedBox(height: 10),
            Text(
              "NRIC/FIN #*",
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
              controller: widget.controller4,
              errorMsg: 'NRIC/FIN #',
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
