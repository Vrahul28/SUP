import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/Textform_field.dart';
import '../../utils/colors.dart';

class EquipmentProvider extends ChangeNotifier{
  // List to store the dynamic containers
  List<Widget> containers = [];

// Controllers for the text fields (Equipment Name and Quantity)
  List<TextEditingController> equipmentControllers = [];
  List<TextEditingController> quantityControllers = [];

// Function to add a new container
  void addNewEquipment(BuildContext context) {
    // Create new controllers for the equipment name and quantity
    TextEditingController equipmentController = TextEditingController();
    TextEditingController quantityController = TextEditingController();

    // Add controllers to the list
    equipmentControllers.add(equipmentController);
    quantityControllers.add(quantityController);

    // Add the new container to the list

    containers.add(buildEquipmentContainer(context,equipmentController, quantityController));
    notifyListeners();

  }

// Function to remove a container
  void removeEquipment(int index) {
    containers.removeAt(index);
    equipmentControllers.removeAt(index);
    quantityControllers.removeAt(index);

    notifyListeners();
  }

// Function to build the equipment container
  Widget buildEquipmentContainer(BuildContext context,TextEditingController equipmentController, TextEditingController quantityController) {
    int index = containers.length;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 260,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 10.0, bottom: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Equipment Name*",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      )
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: kDarkblueColor),
                  onPressed: () {
                    removeEquipment(index);
                  },
                ),
              ],
            ),
            SizedBox(height: 5),
            CustomTextfield(
              controller: equipmentController,
              errorMsg: 'Equipment Name',
              hinttext: '',
              lines: 1,
              Icons: null,
              obsuretext: false,
            ),
            SizedBox(height: 20),
            Text(
              "Quantity*",
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 5),
            CustomTextfield(
              controller: quantityController,
              errorMsg: 'Quantity',
              hinttext: '',
              lines: 1,
              Icons: null,
              obsuretext: false,
            ),
          ],
        ),
      ),
    );
  }

}