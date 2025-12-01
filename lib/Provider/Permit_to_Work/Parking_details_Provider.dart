import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Permit_to_work/Date_picker.dart';
import '../../Permit_to_work/Time_picker.dart';
import '../../utils/Textform_field.dart';
import '../../utils/colors.dart';

class ParkingDetailsProvider extends ChangeNotifier{

  // List to store the dynamic containers
  List<Widget> Workercontainers = [];

  List<TextEditingController> firstnameControllers = [];
  List<TextEditingController> lastnameControllers = [];
  List<TextEditingController> vehicleControllers = [];
  List<TextEditingController> parkinglocationControllers = [];

  List<TextEditingController> dateControllers = [];
  List<TextEditingController> timeControllers = [];
  List<TextEditingController> enddateControllers = [];
  List<TextEditingController> endtimeControllers = [];

  // Store selected values for radio buttons and country picker
  List<int> selectedRoleValues = [];
  List<String> selectedCountryValues = [];

  // Function to add a new container
  void addNewParking(BuildContext context) {
    // Create new controllers for the equipment name and quantity
    TextEditingController firstnameController = TextEditingController();
    TextEditingController lastnameController = TextEditingController();
    TextEditingController vehicleController = TextEditingController();
    TextEditingController parkinglocationController = TextEditingController();

    TextEditingController dateController = TextEditingController();
    TextEditingController timeController = TextEditingController();
    TextEditingController enddateController = TextEditingController();
    TextEditingController endtimeController = TextEditingController();

    // Add controllers to the list
    firstnameControllers.add(firstnameController);
    lastnameControllers.add(lastnameController);
    vehicleControllers.add(vehicleController);
    parkinglocationControllers.add(parkinglocationController);

    dateControllers.add(dateController);
    timeControllers.add(timeController);
    enddateControllers.add(enddateController);
    endtimeControllers.add(endtimeController);


    // Add the new container to the list

    Workercontainers.add(
        buildWorkerContainer(
            context,
            firstnameController,
            lastnameController,
            vehicleController,
            parkinglocationController,

            dateController,
            timeController,
            enddateController,
            endtimeController,
            Workercontainers.length
        ));
    notifyListeners();
  }

  // Function to remove a container
  void removeParking(int index) {
    Workercontainers.removeAt(index);
    firstnameControllers.removeAt(index);
    lastnameControllers.removeAt(index);
    vehicleControllers.remove(index);
    parkinglocationControllers.remove(index);

    dateControllers.removeAt(index);
    timeControllers.removeAt(index);
    enddateControllers.remove(index);
    endtimeControllers.remove(index);

    notifyListeners();
  }

  // Function to build the equipment container
  Widget buildWorkerContainer(BuildContext context,TextEditingController firstname, TextEditingController lastname,TextEditingController vehicle, TextEditingController parkinglocation,TextEditingController date,TextEditingController time,TextEditingController enddate,TextEditingController endtime,int index) {
    int index = Workercontainers.length;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Item ${index + 1 + 1}",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w500
                      )
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: kDarkblueColor),
                  onPressed: () {
                    removeParking(index);
                  },
                ),
              ],
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
              controller: firstname,
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
              controller:lastname,
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
              controller: vehicle,
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
              controller: parkinglocation,
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
            DateTimePicker(controller: date,hinttext: "Start Date",),
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
            TimePicker(controller1: time,),

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
            DateTimePicker(controller: enddate,hinttext: "End Date",),
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
            TimePicker(controller1: endtime),
          ],
        ),
      ),
    );
  }
}