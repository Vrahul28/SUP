import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

import '../../company/companymethods.dart';

class EditCompanyProvider extends ChangeNotifier{

  Future<bool> updateCompany(String id,companyname, displayname,uag,contactperson, contactno, List towerarray, List floorarray,List unitnoarray,List areaarray,List occupancyarray,List staffcountarray, bool vms, bool suntecProperty,bool vendor, bool suntecReit) async{
    String url= "http://111.223.92.154:8091/acp_api/companyManagement.php?comp_id=$id";
    String completeurl= url;

    HttpOverrides.global = MyHttpOverrides();

    print(towerarray.toString());

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

    // Print the body to console before making the request
    print("Request Body: $body");

    var response = await http.post(
        Uri.parse(completeurl),
        headers: <String, String>{
          'Accept': 'application/json'
        },

        body: body
    );

    try{
      if(response.statusCode==200){
        var responseBody= jsonDecode(response.body);
        print(responseBody);
      }
      return true;

    }catch(e){
      print(e);
      return false;
    }
  }
}