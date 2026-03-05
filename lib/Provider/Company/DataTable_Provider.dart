import 'package:flutter/cupertino.dart';

class DatatableProvider extends ChangeNotifier{

  List<String> towers = [];
  List<String> floors = [];
  List<String> unitnos = [];
  List<String> areas = [];
  List<String> occupancys = [];
  List<String> staffnos = [];

  // Add data to the lists and notify listeners
  void addCompanyData({
    required String tower,
    required String floor,
    required String unitno,
    required String area,
    required String occupancy,
    required String staffno,
  }) {
    towers.add(tower);
    floors.add(floor);
    unitnos.add(unitno);
    areas.add(area);
    occupancys.add(occupancy);
    staffnos.add(staffno);

    notifyListeners(); // Notifies consumers to rebuild
  }

  // Update data at a specific index
  void updateCompanyData({
    required int index,
    required String tower,
    required String floor,
    required String unitno,
    required String area,
    required String occupancy,
    required String staffno,
  }) {
    // Check if the index is valid
    if (index >= 0 && index < towers.length) {
      towers[index] = tower;
      floors[index] = floor;
      unitnos[index] = unitno;
      areas[index] = area;
      occupancys[index] = occupancy;
      staffnos[index] = staffno;

      notifyListeners(); // Notifies consumers to rebuild
    } else {
      debugPrint("Invalid index: $index");
    }
  }

  // Method to delete data at a specific index
  void deleteCompanyData(int index) {
    if (index >= 0 && index < towers.length) {
      towers.removeAt(index);
      floors.removeAt(index);
      unitnos.removeAt(index);
      areas.removeAt(index);
      occupancys.removeAt(index);
      staffnos.removeAt(index);

      notifyListeners(); // Notifies consumers to rebuild
    } else {
      debugPrint("Invalid index: $index");
    }
  }

  // Clear all the lists (if needed)
  void clearData() {
    towers.clear();
    floors.clear();
    unitnos.clear();
    areas.clear();
    occupancys.clear();
    staffnos.clear();
    notifyListeners();
  }

}