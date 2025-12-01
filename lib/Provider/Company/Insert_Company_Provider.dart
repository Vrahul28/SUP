import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../company/companymethods.dart';

class InsertCompanyProvider extends ChangeNotifier{
  Future<bool> addCompany(String companyname, displayname,uag,contactperson, contactno, List<String> towerarray, List<String> floorarray,List<String> unitnoarray,List<String> areaarray,List<String> occupancyarray,List<String> staffcountarray, bool vms, bool suntecProperty,bool vendor, bool suntecReit) async{
    String url= "http://111.223.92.154:8091/acp_api/companyManagement.php";
    String completeurl= url;

    SharedPreferences pref= await SharedPreferences.getInstance();

    HttpOverrides.global = MyHttpOverrides();

    var response = await http.post(
        Uri.parse(completeurl),
        headers: <String, String>{
          'Accept': 'application/json'
        },
        body: {
          "company_name": companyname,
          "kiosk_display_name": displayname,
          "contact_person": contactperson,
          "uag": uag,
          "contact_no": contactno,
          "suntec_reit": suntecReit.toString(),
          "suntec_property": suntecProperty.toString(),
          "vendor": vendor.toString(),
          "vms": vms.toString(),
          "full_name": pref.getString('full_name'),
          "user_id": pref.getString('userId'),
          "userRole":pref.getString('userRole'),
          "towerArray": jsonEncode(towerarray),
          "floorArray":  jsonEncode(floorarray),
          "unitNoArray": jsonEncode(unitnoarray),
          "areaArray": jsonEncode(areaarray),
          "occupancyArray": jsonEncode(occupancyarray),
          "staffCountArray": jsonEncode(staffcountarray),
        }
    );

    try{
      if(response.statusCode==200){
        var responseBody= jsonDecode(response.body);
        print(responseBody['message']);
      }
      return true;
    }catch(e){
      print(e);
      return false;
    }

  }
}