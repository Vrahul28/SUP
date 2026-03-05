import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../company/companymethods.dart';

class InsertCompanyProvider extends ChangeNotifier{
  late int id1;
  late int id2;

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

    String url= "http://111.223.92.154:8091/acp_api/companyManagement.php";
    String completeUrl= url;

    SharedPreferences pref= await SharedPreferences.getInstance();

    HttpOverrides.global = MyHttpOverrides();

    var response = await http.post(
        Uri.parse(completeUrl),
        headers: <String, String>{
          'Accept': 'application/json'
        },
        body: {
          "company_name": companyName,
          "kiosk_display_name": displayName,
          "contact_person": contactPerson,
          "uag": uag,
          "contact_no": contactNo,
          "suntec_reit": suntechReit.toString(),
          "suntec_property": suntechProperty.toString(),
          "vendor": vendor.toString(),
          "vms": vms.toString(),
          "full_name": pref.getString('full_name'),
          "user_id": pref.getString('userId'),
          "userRole":pref.getString('userRole'),
          "towerArray": jsonEncode(towerArray),
          "floorArray":  jsonEncode(floorArray),
          "unitNoArray": jsonEncode(unitnoArray),
          "areaArray": jsonEncode(areaArray),
          "occupancyArray": jsonEncode(occupancyArray),
          "staffCountArray": jsonEncode(staffcountArray),
        }
    );

    try{
      if(response.statusCode==200){
        var responseBody= jsonDecode(response.body);
        debugPrint(responseBody['message']);
      }
      return true;
    }catch(e){
      debugPrint(e.toString());
      return false;
    }

  }


  //Update Company
  Future<bool> updateCompany(
      String id,
      companyname,
      displayname,
      uag,
      contactperson,
      contactno,
      List towerarray,
      List floorarray,
      List unitnoarray,
      List areaarray,
      List occupancyarray,
      List staffcountarray,
      bool vms,
      bool suntecProperty,
      bool vendor,
      bool suntecReit
      ) async{
    String url= "http://111.223.92.154:8091/acp_api/companyManagement.php?comp_id=$id";
    String completeUrl= url;

    HttpOverrides.global = MyHttpOverrides();

    debugPrint(towerarray.toString());

    // Create the request body as a Map
    Map<String, String> body = {
      "id": id,
      "company_name": companyname,
      "kiosk_display_name": displayname,
      "uag": uag,
      "contact_person": contactperson,
      "contact_no": contactno,
      "suntec_reit": suntecReit.toString(),
      "suntec_property": suntecProperty.toString(),
      "vendor": vendor.toString(),
      "vms": vms.toString(),
      "full_name": "Admin",
      "user_id": "23",
      "userRole": "5",
      "towerArray": towerarray.toString(), // Pass integer arrays
      "floorArray": floorarray.toString(),
      "unitNoArray": unitnoarray.toString(),
      "areaArray": areaarray.toString(),
      "occupancyArray": occupancyarray.toString(),
      "staffCountArray": staffcountarray.toString(),
    };

    // debugPrint the body to console before making the request
    debugPrint("Request Body: $body");

    var response = await http.post(
        Uri.parse(completeUrl),
        headers: <String, String>{
          'Accept': 'application/json'
        },

        body: body
    );

    try{
      if(response.statusCode==200){
        var responseBody= jsonDecode(response.body);
        debugPrint(responseBody);
      }
      return true;

    }catch(e){
      debugPrint(e.toString());
      return false;
    }
  }
}