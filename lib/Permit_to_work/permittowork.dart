import 'package:acp/Permit_to_work/Text_Widget.dart';
import 'package:acp/Provider/Permit_to_Work/Permit_to_Work_Provider.dart';
import 'package:acp/Provider/Permit_to_Work/Site_Worker_Provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../Provider/Permit_to_Work/Parking_details_Provider.dart';
import '../utils/Textform_field.dart';
import '../utils/colors.dart';
import 'CheckboxStateManager.dart';
import 'Checkbox_Text.dart';
import 'Date_picker.dart';
import 'Equipment_list.dart';
import 'Misting_Works.dart';
import 'Parking_details.dart';
import 'Signature_Pad.dart';
import 'Site_Worker.dart';
import 'Time_picker.dart';
import 'Wokring_at_Height.dart';

final TextEditingController firstname= TextEditingController();
final TextEditingController startdate= TextEditingController();
final TextEditingController enddate= TextEditingController();
final TextEditingController startTime= TextEditingController();
final TextEditingController endTime= TextEditingController();
final TextEditingController Contactno= TextEditingController();
final TextEditingController Contactno1= TextEditingController();

// Worker
final TextEditingController firstname_worker= TextEditingController();
final TextEditingController lastname_worker= TextEditingController();
final TextEditingController phoneno_worker= TextEditingController();
final TextEditingController nric_worker= TextEditingController();

// Parking
final TextEditingController firstname_parking= TextEditingController();
final TextEditingController lastname_parking= TextEditingController();
final TextEditingController vehicleReg_parling= TextEditingController();
final TextEditingController parking_location= TextEditingController();
final TextEditingController startdate_parking= TextEditingController();
final TextEditingController starttime_parking= TextEditingController();
final TextEditingController enddate_parling= TextEditingController();
final TextEditingController endtime_location= TextEditingController();

// Working height
final TextEditingController detail_work= TextEditingController();
final TextEditingController startdate_work= TextEditingController();
final TextEditingController starttime_work= TextEditingController();
final TextEditingController enddate_work= TextEditingController();
final TextEditingController endtime_work= TextEditingController();

// Misiting Work
final TextEditingController detail_misit= TextEditingController();
final TextEditingController startdate_misit= TextEditingController();
final TextEditingController starttime_misit= TextEditingController();
final TextEditingController enddate_misit= TextEditingController();
final TextEditingController endtime_misit= TextEditingController();
final TextEditingController firstname_misit= TextEditingController();
final TextEditingController lastname_misit= TextEditingController();
final TextEditingController phone_misit= TextEditingController();
final TextEditingController shiftstart_misit= TextEditingController();
final TextEditingController shiftend_misit= TextEditingController();

class PermitToWork extends StatefulWidget {
  const PermitToWork({super.key});

  @override
  State<PermitToWork> createState() => _PermitToWorkState();
}

class _PermitToWorkState extends State<PermitToWork> {
  String? _selectedOption1;
  String? _selectedOption2;
  String? _selectedOption3;
  bool value = false;
  bool parking= false;
  bool workHeight= false;
  bool misitingWork= false;

  CheckboxStateManager checkboxManager = CheckboxStateManager();
  @override
  Widget build(BuildContext context) {
    final Equip= Provider.of<EquipmentProvider>(context,listen: false);
    final Worker= Provider.of<SiteWorkerProvider>(context,listen: false);
    final Parking= Provider.of<ParkingDetailsProvider>(context,listen: false);
    return PopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: kDarkblueColor,
              iconTheme: const IconThemeData(
                color: Colors.white, // Changing the arrow color to white
              ),
              title:Text("Permit To Work",
                style: GoogleFonts.poppins(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
            ),

            SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(
                      height: 20,
                    ),
                  Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 10.0, bottom: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextWidget(text: "This form is for Permit to Work Submissions with a lead time of more than 2 days.",),
                          SizedBox(height: 10),
                          const TextWidget(text: "For urgent PTW submissions with a lead time of less than 2 days, please click here."),
                          const SizedBox(height: 10),
                          const TextWidget(text: "Contractors undertaking works within general areas of the Centre are required to undertake this permit. An approved permit is required for all works within public foyers, LAN and/or maintenance rooms."),
                          SizedBox(height: 10),
                          const TextWidget(text: "This permit is not required for works within event spaces which have been contracted by clients for event usage."),
                          const SizedBox(height: 35),
                          Text(
                            "Applicant's Particulars",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500
                              )
                            ),
                          ),
                          SizedBox(height: 25),
                          Text(
                            "Name*",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                )
                            ),
                          ),
                          SizedBox(height: 10),
                          CustomTextfield(
                            controller: firstname,
                            errorMsg: 'First name requried.',
                            hinttext: 'First Name',
                            lines: 1,
                            Icons: Icons.person_outline,
                            obsuretext: false,
                          ),
                          const SizedBox(height: 10),
                          CustomTextfield(
                            controller: firstname,
                            errorMsg: 'Last name requried.',
                            hinttext: 'Last Name',
                            lines: 1,
                            Icons: Icons.person_outline,
                            obsuretext: false,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Company Name*",
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
                            controller: firstname,
                            errorMsg: 'Company name requried.',
                            hinttext: 'Company Name',
                            lines: 1,
                            Icons: LineAwesomeIcons.building,
                            obsuretext: false,
                          ),
                          const SizedBox(height: 20),
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
                            controller: Contactno,
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
                          SizedBox(height: 0),
                          Text(
                            "Email*",
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
                            controller: firstname,
                            errorMsg: 'Email requried.',
                            hinttext: 'Email',
                            lines: 1,
                            Icons: Icons.email_outlined,
                            obsuretext: false,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "NRIC* (Please only provide the last 4 digits, i.e. 123A)",
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
                            controller: firstname,
                            errorMsg: 'NRIC requried.',
                            hinttext: 'NRIC',
                            lines: 1,
                            Icons: Icons.paste_sharp,
                            obsuretext: false,
                          ),

                          SizedBox(height: 20),
                          Text(
                            "Suntec Representative*",
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
                            controller: firstname,
                            errorMsg: 'Suntec Representative requried.',
                            hinttext: '',
                            lines: 1,
                            Icons: null,
                            obsuretext: false,
                          ),
                          SizedBox(height: 40),
                          Text(
                            "Details of Proposed Work",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500
                                )
                            ),
                          ),
                          SizedBox(height: 25),
                          Text(
                            "Explain in detail the work that will be undertaken:*",
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
                              controller: firstname,
                              errorMsg: 'Suntec Representative required.',
                              hinttext: '',
                              lines: 5,
                            Icons: null,
                            obsuretext: false,
                            ),

                          SizedBox(height: 20),
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
                          SizedBox(height: 5),
                          DateTimePicker(controller: startdate,hinttext: "Start Date",),
                          SizedBox(height: 20),
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
                          SizedBox(height: 5),
                          TimePicker(controller1: startTime,),

                          SizedBox(height: 20),
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
                          SizedBox(height: 5),
                          DateTimePicker(controller: enddate,hinttext: "End Date",),
                          SizedBox(height: 20),
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
                          SizedBox(height: 5),
                          TimePicker(controller1: endTime),

                          SizedBox(height: 20),
                          Text(
                            "Nature of Works*",
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
                            controller: firstname,
                            errorMsg: 'Nature of Works',
                            hinttext: '',
                            lines: 1,
                            Icons: null,
                            obsuretext: false,
                          ),

                          SizedBox(height: 20),
                          Text(
                            "Location(s) within Suntec Convention Centre*",
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
                            controller: firstname,
                            errorMsg: 'Location(s)',
                            hinttext: '',
                            lines: 1,
                            Icons: null,
                            obsuretext: false,
                          ),
                          SizedBox(height: 40),
                          Text(
                            "Name List of On-Site Workers",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500
                                )
                            ),
                          ),
                          SizedBox(height: 20),
                          SiteWorker(
                            controller: firstname_worker,
                            controller2: lastname_worker,
                            controller3: phoneno_worker,
                            controller4: nric_worker,
                          ),
                          Consumer<SiteWorkerProvider>(
                            builder: (BuildContext context, value, Widget? child) {
                              return ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.only(top: 20),
                                itemCount: value.Workercontainers.length,
                                itemBuilder: (context, index) {
                                  return value.Workercontainers[index];
                                },
                              );
                            },
                          ),
                          SizedBox(height: 15),
                          MaterialButton(
                            minWidth: 50,
                            height: 50,
                            color: kDarkblueColor,
                            onPressed: () {
                              Worker.addNewWorker(context);
                            },
                            child: Text("+Add Worker", style: TextStyle(color: Colors.white),),
                          ),
                          SizedBox(height: 40),
                          Text(
                            "Equipment List",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500
                                )
                            ),
                          ),
                          Text(
                            "Please state the equipment that will be used during your works:",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500
                                )
                            ),
                          ),
                          SizedBox(height: 20),
                          EquipmentList(controller: firstname),
                            Consumer<EquipmentProvider>(
                              builder: (BuildContext context, value, Widget? child) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(top: 20),
                                  itemCount: value.containers.length,
                                  itemBuilder: (context, index) {
                                    return value.containers[index];
                                  },
                                );
                              },
                            ),
                          SizedBox(height: 10),
                          MaterialButton(
                            minWidth: 80,
                            height: 50,
                            color: kDarkblueColor,
                            onPressed: () {
                              Equip.addNewEquipment(context);
                            },
                            child: Text("+Add New equipment", style: TextStyle(color: Colors.white),),
                          ),
                          SizedBox(height: 40),
                          Text(
                            "Will you require parking at the loading bay during the PTW duration?*",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                )
                            ),
                          ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'yes',
                            groupValue: _selectedOption1,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption1= value;
                                parking= true;
                              });
                            },
                          ),
                          Text('Yes',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                              )
                          ),
                          ),
                          Radio<String>(
                            value: 'no',
                            groupValue: _selectedOption1,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption1 = value;
                                parking= false;
                              });
                            },
                          ),
                          Text('No',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                )
                            ),
                          ),
                        ],
                      ),
                          const SizedBox(height: 20),
                          Visibility(
                            visible: parking,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Parking Details",
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500
                                        )
                                    ),
                                  ),
                                  ParkingDetails(
                                    controller: firstname_parking,
                                    controller2: lastname_parking,
                                    controller3: vehicleReg_parling,
                                    controller4: parking_location,
                                    controller5: startdate_parking,
                                    controller6: starttime_parking,
                                    controller7: enddate_parling,
                                    controller8: enddate_parling,
                                  ),
                                  Consumer<ParkingDetailsProvider>(
                                    builder: (BuildContext context, value, Widget? child) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.only(top: 20),
                                        itemCount: value.Workercontainers.length,
                                        itemBuilder: (context, index) {
                                          return value.Workercontainers[index];
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  MaterialButton(
                                    minWidth: 50,
                                    height: 50,
                                    color: kDarkblueColor,
                                    onPressed: () {
                                      Parking.addNewParking(context);
                                    },
                                    child: Text("+Add Item", style: TextStyle(color: Colors.white),),
                                  ),
                                ],
                              )
                          ),
                          SizedBox(height:20),
                          Text(
                            "Working at Heights - Will the contractor have activities that are above 3m in height?*",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                )
                            ),
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'yes',
                                groupValue: _selectedOption2,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOption2 = value;
                                    workHeight= true;
                                  });
                                },
                              ),
                              Text('Yes',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500
                                    )
                                ),
                              ),
                              Radio<String>(
                                value: 'no',
                                groupValue: _selectedOption2,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOption2 = value;
                                    workHeight= false;
                                  });
                                },
                              ),
                              Text('No',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500
                                    )
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Visibility(
                            visible: workHeight,
                              child: WorkingAtHeight(
                                controller: detail_work,
                                controller2: startdate_work,
                                controller3: starttime_work,
                                controller4: enddate_work,
                                controller5: endtime_work,
                              )
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Will the contractor have activities that involve Hot Works /Dust Generation /Misting Works?*",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                )
                            ),
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'yes',
                                groupValue: _selectedOption3,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOption3 = value;
                                    misitingWork= true;
                                  });
                                },
                              ),
                              Text('Yes',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500
                                    )
                                ),
                              ),
                              Radio<String>(
                                value: 'no',
                                groupValue: _selectedOption3,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOption3 = value;
                                    misitingWork= false;
                                  });
                                },
                              ),
                              Text('No',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500
                                    )
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Visibility(
                            visible: misitingWork,
                              child: MistingWorks(
                                controller: detail_misit,
                                controller2: startdate_misit,
                                controller3: starttime_misit,
                                controller4: enddate_misit,
                                controller5: endtime_misit,
                                controller6: firstname_misit,
                                controller7: lastname_misit,
                                controller8: phone_misit,
                                controller9: shiftstart_misit,
                                controller10: shiftend_misit,
                              )
                          ),
                          const SizedBox(height: 40),
                          Text(
                            "I, the applicant, confirm the above information is correct and confirm the below requirements have been met:*",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                )
                            ),
                          ),
                          SizedBox(height: 10),
                          CheckboxText(
                            value: checkboxManager.value1,
                            onChanged: (bool? newValue) {
                              setState(() {
                                checkboxManager.toggleValue(1);
                              });
                            },
                            text: "I have read and accepted Suntec Singapore’s Terms & Conditions, which are applicable to this application.",
                          ),
                          const SizedBox(height: 5),
                          CheckboxText(
                            value: checkboxManager.value2,
                            onChanged: (newValue) {
                              setState(() {
                                checkboxManager.toggleValue(2);
                              });
                            },
                            text: "I confirm I will abide by the Rules & Regulations as laid out by Suntec Singapore.",
                          ),
                          SizedBox(height: 5),
                          CheckboxText(
                            value: checkboxManager.value3,
                            onChanged: (newValue) {
                              setState(() {
                                checkboxManager.toggleValue(3);
                              });
                            },
                            text: "In accordance with the Data Protection Act 2012, and Suntec Singapore’s Data Protection Policy, I agree to allow Suntec Singapore to collect, use and disclose my personal data which I have provided in this form, for the purpose of processing the booking, marketing and any other intended purposes.",
                          ),
                          SizedBox(height: 5),
                          CheckboxText(
                            value: checkboxManager.value4,
                            onChanged: (newValue) {
                              setState(() {
                                checkboxManager.toggleValue(4);
                              });
                            },
                            text: "All contractors have been briefed on the Safe Working Procedures [SWP]",
                          ),
                          SizedBox(height: 5),
                          CheckboxText(
                            value: checkboxManager.value5,
                            onChanged: (newValue) {
                              setState(() {
                                checkboxManager.toggleValue(5);
                              });
                            },
                            text: "All contracted have been briefed on the Risk Assessment [RA]",
                          ),
                          SizedBox(height: 5),
                          CheckboxText(
                            value: checkboxManager.value6,
                            onChanged: (newValue) {
                              setState(() {
                                checkboxManager.toggleValue(6);
                              });
                            },
                            text: "Adequate and rigid lifeline has been provided",
                          ),
                          SizedBox(height: 5),
                          CheckboxText(
                            value: checkboxManager.value7,
                            onChanged: (newValue) {
                              setState(() {
                                checkboxManager.toggleValue(7);
                              });
                            },
                            text: "I fully understand the nature of the work and safety conditions that must be met, and undertake the responsibility inspecting the safety conditions relating to the work to be performed",
                          ),
                          SizedBox(height: 5),
                          CheckboxText(
                            value: checkboxManager.value8,
                            onChanged: (newValue) {
                              setState(() {
                                checkboxManager.toggleValue(8);
                              });
                            },
                            text: "I confirm that all staff / contractors are fully vaccinated [both doses, plus 14 days]",
                          ),
                          SizedBox(height: 5),
                          CheckboxText(
                            value: checkboxManager.value9,
                            onChanged: (newValue) {
                              setState(() {
                                checkboxManager.toggleValue(9);
                              });
                            },
                            text: "I confirm that all on-site staff are included in the worker list found in the approved PTW",
                          ),
                          SizedBox(height: 5),
                          CheckboxText(
                            value: checkboxManager.value10,
                            onChanged: (newValue) {
                              setState(() {
                                checkboxManager.toggleValue(10);
                              });
                            },
                            text: "I confirm that all on-site staff are legally permitted to work",
                          ),
                          SizedBox(height: 30),
                          Text(
                            "Applicant's Signature*",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                )
                            ),
                          ),
                          const SizedBox(height: 10),
                          const SignaturePad()
                        ],
                      ),
                    )
                  ]
                )
            )
          ],
        ),

      ),
    );
  }
}
