import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../company/companymethods.dart';

class InsertCompanyProvider extends ChangeNotifier{
  bool isLoading= false;

  int id1=0;
  late int id2;
  int towerID= 0;

  List<String> towers= [];
  List<String> floors= [];
  List<String> unitNos= [];
  List<String> areas= [];
  List<String> occupancyList= [];
  List<String> staffNos= [];

  late int count;
  bool isUpdateCompany= false;
  bool isAddCompany= false;
  bool isSwitchOn = false;
  bool isSwitchOn2 = false;
  bool isSwitchOn3 = false;
  bool isSwitchOn4 = false;
  bool viewCompany= false;
  bool isEdited= false;

  String tower11= "";
  String unitNo11= "";


  TextEditingController companyName= TextEditingController();
  TextEditingController displayName= TextEditingController();
  TextEditingController uag= TextEditingController();
  TextEditingController contactName= TextEditingController();
  TextEditingController contactNo= TextEditingController();
  TextEditingController towerCompany= TextEditingController();
  TextEditingController floor= TextEditingController();
  TextEditingController unitNo= TextEditingController();
  TextEditingController area= TextEditingController();
  TextEditingController occupancy= TextEditingController();
  TextEditingController staffNo= TextEditingController();

  void clearController(){
    companyName.clear();
    displayName.clear();
    uag.clear();
    contactName.clear();
    contactNo.clear();
    towerCompany.clear();
    floor.clear();
    unitNo.clear();
    area.clear();
    occupancy.clear();
    staffNo.clear();
  }

  //Add Company
  Future<bool> addCompany(
      String companyName,
      displayName,
      uag,
      contactPerson,
      contactNo,
      List<String> towerArray,
      List<String> floorArray,
      List<String> unitnoArray,
      List<String> areaArray,
      List<String> occupancyArray,
      List<String> staffcountArray,
      bool vms,
      bool suntechProperty,
      bool vendor,
      bool suntechReit
      ) async{

    isLoading = true;
    notifyListeners();

    // String url= "http://111.223.92.154:8091/acp_api/companyManagement.php";
    String url= "http://111.223.92.154:85/restApplicationUser/restCompany/company/addoreditcompany";
    SharedPreferences pref= await SharedPreferences.getInstance();
    HttpOverrides.global = MyHttpOverrides();

    /// Build companyTowerData dynamically
    List<Map<String, dynamic>> companyTowerData = [];

    for (int i = 0; i < towerArray.length; i++) {
      companyTowerData.add({
        "tower": towerArray[i],
        "floor": floorArray[i],
        "units": [unitnoArray[i]],
        "areas": [areaArray[i]],
        "occupancies": [occupancyArray[i]],
        "noOfStaff": [staffcountArray[i]]
      });
    }

    /// Convert list to JSON string
    String towerDataJson = jsonEncode(companyTowerData);

    var response = await http.post(
      Uri.parse(url),
      body: {
        "company": companyName,
        "contactNo": contactNo,
        "uAGS": uag,
        "kioskDisplayName": displayName,
        "contactPerson": contactPerson,
        "companySR": suntechReit.toString(),
        "companySP": suntechProperty.toString(),
        "companyVendor": vendor.toString(),
        "showVMS": vms.toString(),
        "createdBy": pref.getString('userId') ?? "",
        "companyTowerData": towerDataJson
      },
    );

    debugPrint("Status Code: ${response.statusCode}");

    try{
      if(response.statusCode==200){
        var responseBody= jsonDecode(response.body);
        debugPrint("Add Company API: $responseBody");

        isLoading = false;
        notifyListeners();
      }
      return true;
    }catch(e){
      debugPrint(e.toString());
      isLoading = false;
      notifyListeners();
      return false;
    }
  }


  //Update Company
  Future<bool> updateCompany(
      String companyId,
      String companyName,
      displayName,
      uag,
      contactPerson,
      contactNo,
      List<String> towerArray,
      List<String> floorArray,
      List<String> unitnoArray,
      List<String> areaArray,
      List<String> occupancyArray,
      List<String> staffcountArray,
      bool vms,
      bool suntechProperty,
      bool vendor,
      bool suntechReit
      ) async{



    String url= "http://111.223.92.154:85/restApplicationUser/restCompany/company/addoreditcompany";
    SharedPreferences pref= await SharedPreferences.getInstance();
    HttpOverrides.global = MyHttpOverrides();
    /// Build companyTowerData dynamically
    List<Map<String, dynamic>> companyTowerData = [];

    // for (int i = 0; i < towerArray.length; i++) {
    //   companyTowerData.add({
    //     "tower": towerArray[i],
    //     "floor": floorArray[i],
    //     "units": [unitnoArray[i]],
    //     "areas": [areaArray[i]],
    //     "occupancies": [occupancyArray[i]],
    //     "noOfStaff": [staffcountArray[i]]
    //   });
    // }

    isLoading = true;
    notifyListeners();

    /// Convert list to JSON string
    String towerDataJson = jsonEncode(companyTowerData);
    var response = await http.post(
      Uri.parse(url),
      body: {
        'companyID':companyId,
        "company": companyName,
        "contactNo": contactNo,
        "uAGS": uag,
        "kioskDisplayName": displayName,
        "contactPerson": contactPerson,
        "companySR": suntechReit.toString(),
        "companySP": suntechProperty.toString(),
        "companyVendor": vendor.toString(),
        "showVMS": vms.toString(),
        "createdBy": pref.getString('userId') ?? "",
        "companyTowerData": towerDataJson
      },
    );

    debugPrint("Status Code: ${response.statusCode}");

    try{
      if(response.statusCode==200){
        var responseBody= jsonDecode(response.body);
        debugPrint("Update Company API: $responseBody");
        isLoading = false;
        notifyListeners();
      }
      return true;
    }catch(e){
      debugPrint(e.toString());
      isLoading = false;
      notifyListeners();
      return false;
    }

  }

  //Edit Company Tower Data
  Future<bool> editCompanyTowerData(
      int compId,
      int floorId,
      int towerId,
      String unitNo,
      String area,
      String occupancy,
      String staffNo,
      bool isEdit,
      int id
      ) async{

    String url= "http://111.223.92.154:85/restApplicationUser/restCompany/company/editcompanytowerdata";
    debugPrint(url);

    HttpOverrides.global = MyHttpOverrides();
    SharedPreferences pref= await SharedPreferences.getInstance();

    Map<String,  dynamic> jsonData= {
      "companyID": compId,
      "floorID": floorId,
      "towerID": towerId,
      "unitNo": unitNo,
      "area": area,
      "occupancy": occupancy,
      "noOfStaff": staffNo,
      "iD": isEdit? id: ""
    };

    // // Convert the map to a JSON string
    String jsonBody = jsonEncode(jsonData);
    debugPrint(jsonData.toString());

    var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonBody
    );
    try{
      if(response.statusCode==200){
        final data = jsonDecode(response.body);
        debugPrint(response.body);
        return true;
      }

    }catch(e){
      debugPrint("Edit Company Tower Data: $e");
      return false;
    }
    return false;
  }



}