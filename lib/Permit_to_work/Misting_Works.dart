import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../utils/Textform_field.dart';
import '../utils/colors.dart';
import 'Date_picker.dart';
import 'Time_picker.dart';

class MistingWorks extends StatefulWidget {
  final TextEditingController controller, controller2, controller3,controller4,controller5;
  final TextEditingController controller6, controller7, controller8,controller9,controller10;
  const MistingWorks({
    required this.controller,
    required this.controller2,
    required this.controller3,
    required this.controller4,
    required this.controller5,

    required this.controller6,
    required this.controller7,
    required this.controller8,
    required this.controller9,
    required this.controller10,
    super.key
  });

  @override
  State<MistingWorks> createState() => _MistingWorksState();
}

class _MistingWorksState extends State<MistingWorks> {
  int? _selectedValue;
  int? _selectedValue2;
  bool undertaking= false;
  PlatformFile? selectedFile;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedFile = result.files.first;
      });
    }
  }

  void _removeFile() {
    setState(() {
      selectedFile = null;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 2050,
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
              "Hot Works / Dust Generation / Misting works",
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
              "Explain in detail the activities that will be undertaken for works:*",
              softWrap: true,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            const SizedBox(height: 5),
            CustomTextfield(
              controller: widget.controller,
              errorMsg: 'First Name',
              hinttext: '',
              lines: 5,
              obsuretext: false,
              Icons: null,
              // Icons: Icons.person,
            ),
            SizedBox(height: 20),
            Text(
              "Duration of Working at Height Activities",
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            const SizedBox(height: 20),
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
            DateTimePicker(controller: widget.controller2,hinttext: "Start Date",),
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
            TimePicker(controller1: widget.controller3,),

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
            DateTimePicker(controller: widget.controller4,hinttext: "End Date",),
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
            TimePicker(controller1: widget.controller5),

            const SizedBox(height: 20),
            Text(
              "Workers Name List",
              softWrap: true,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 530,
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
                    SizedBox(height: 20),
                    Text(
                      "Is this person undertaking working at heights?*",
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: Text('Yes'),
                            value: 1,
                            groupValue: _selectedValue,
                            activeColor: kDarkblueColor,
                            onChanged: (int? value) {
                              setState(() {
                                _selectedValue = value!;
                                undertaking= true;
                                print(_selectedValue);
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: Text('No'),
                            value: 2,
                            groupValue: _selectedValue,
                            activeColor: kDarkblueColor,
                            onChanged: (int? value) {
                              setState(() {
                                _selectedValue = value!;
                                undertaking= false;
                                print(_selectedValue);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Visibility(
                      visible: undertaking,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                    groupValue: _selectedValue2,
                                    activeColor: kDarkblueColor,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _selectedValue2 = value!;
                                        print(_selectedValue);
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    title: Text('Worker'),
                                    value: 2,
                                    groupValue: _selectedValue2,
                                    activeColor: kDarkblueColor,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _selectedValue2 = value!;
                                        print(_selectedValue);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Submit Certificate*",
                              style:  GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500
                                  )
                              ),
                            ),
                            const SizedBox(height: 20),
                            MaterialButton(
                              minWidth: 50,
                              height: 50,
                              color: kDarkblueColor,
                              onPressed: _pickFile,
                              child: Text("Upload", style: TextStyle(color: Colors.white),),
                            ),
                            if (selectedFile != null) ...[
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      selectedFile!.name,
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400
                                          )
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.close, color: Colors.red),
                                    onPressed: _removeFile,
                                  ),
                                ],
                              ),
                            ],

                          ],
                        )
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Fire Watch Personnel",
              softWrap: true,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "First Name*",
              softWrap: true,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            const SizedBox(height: 5),
            CustomTextfield(
              controller: widget.controller6,
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
              softWrap: true,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            const SizedBox(height: 5),
            CustomTextfield(
              controller: widget.controller7,
              errorMsg: 'Last Name',
              hinttext: '',
              lines: 1,
              obsuretext: false,
              Icons: null,
              // Icons: Icons.person,
            ),
            const SizedBox(height: 20),
            Text(
              "Phone Number*",
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
              controller: widget.controller8,
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
                print(phone.completeNumber); // Output complete number with country code
              },
              onCountryChanged: (country) {
                print('Country changed to: ' + country.name);
              },
              dropdownTextStyle: GoogleFonts.poppins(
                  color: kDarkblueColor,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Shift Start Time*",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),
            const SizedBox(height: 5),
            TimePicker(controller1: widget.controller9,),
            const SizedBox(height: 20),
            Text(
              "Shift End Time*",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),
            const SizedBox(height: 5),
            TimePicker(controller1: widget.controller10,),
          ],
        ),
      ),
    );
  }
}
