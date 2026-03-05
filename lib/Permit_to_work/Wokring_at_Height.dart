import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/Textform_field.dart';
import '../utils/colors.dart';
import 'Date_picker.dart';
import 'Time_picker.dart';

class WorkingAtHeight extends StatefulWidget {
  final TextEditingController controller, controller2, controller3,controller4,controller5;
  const WorkingAtHeight({
    required this.controller,
    required this.controller2,
    required this.controller3,
    required this.controller4,
    required this.controller5,
    super.key
  });

  @override
  State<WorkingAtHeight> createState() => _WorkingAtHeightState();
}

class _WorkingAtHeightState extends State<WorkingAtHeight> {
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
      height: 1500,
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
              "Working at Height ​[WAH​] Overview",
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
              "Explain in detail the work that will be undertaken at height:*",
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
              "Working at Height Name List",
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
                    const SizedBox(height: 20),
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
                            SizedBox(height: 20),
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
            )

          ],
        ),
      ),
    );
  }
}
