
import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../utils/Textform_field.dart';
import '../../utils/colors.dart';

class SiteWorkerProvider extends ChangeNotifier{

  // List to store the dynamic containers
  List<Widget> Workercontainers = [];

  List<TextEditingController> firstnameControllers = [];
  List<TextEditingController> lastnameControllers = [];
  List<TextEditingController> phonenoControllers = [];
  List<TextEditingController> nricControllers = [];

  // Store selected values for radio buttons and country picker
  List<int> selectedRoleValues = [];
  List<String> selectedCountryValues = [];

  // Function to add a new container
  void addNewWorker(BuildContext context) {
    // Create new controllers for the equipment name and quantity
    TextEditingController firstnameController = TextEditingController();
    TextEditingController lastnameController = TextEditingController();
    TextEditingController phonenoController = TextEditingController();
    TextEditingController nricController = TextEditingController();

    // Add controllers to the list
    firstnameControllers.add(firstnameController);
    lastnameControllers.add(lastnameController);
    phonenoControllers.add(phonenoController);
    nricControllers.add(nricController);

    // Default radio button value (1 for Supervisor)
    selectedRoleValues.add(1);
    // Default country (empty initially)
    selectedCountryValues.add('');

    // Add the new container to the list

    Workercontainers.add(buildWorkerContainer(context,firstnameController, lastnameController,phonenoController,nricController,Workercontainers.length));
    notifyListeners();
  }

  // Function to remove a container
  void removeWorker(int index) {
    Workercontainers.removeAt(index);
    firstnameControllers.removeAt(index);
    lastnameControllers.removeAt(index);
    phonenoControllers.remove(index);
    nricControllers.remove(index);
    selectedRoleValues.removeAt(index);
    selectedCountryValues.removeAt(index);

    notifyListeners();
  }

  // Function to build the equipment container
  Widget buildWorkerContainer(BuildContext context,TextEditingController firstname, TextEditingController lastname,TextEditingController phoneno, TextEditingController nric,int index) {
    int index = Workercontainers.length;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 750,
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
                  "Worker ${index + 1 + 1}" ,
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
                    removeWorker(index);
                  },
                ),
              ],
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
              controller: firstname,
              errorMsg: 'First Name',
              hinttext: '',
              lines: 1,
              obsuretext: false,
              Icons: null,
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
              controller: lastname,
              errorMsg: 'Last Name',
              hinttext: '',
              lines: 1,
              obsuretext: false,
              Icons: null,
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
                    groupValue: selectedRoleValues[index],
                    activeColor: kDarkblueColor,
                    onChanged: (value) {
                      selectedRoleValues[index] = value!;
                      notifyListeners();
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text('Worker'),
                    value: 2,
                    groupValue: selectedRoleValues[index],
                    activeColor: kDarkblueColor,
                    onChanged: (value) {
                      selectedRoleValues[index] = value!;
                      debugPrint(value.toString());
                      notifyListeners();
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
              controller: phoneno,
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
              countryDropdownLabel: selectedCountryValues[index].isNotEmpty ? selectedCountryValues[index] : 'Select Country',
              onCountryChanged: (value) {
                selectedCountryValues[index] = value;
                notifyListeners();
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
              controller: nric,
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