import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../company/companymethods.dart';

class EditStaffProvider extends ChangeNotifier{

  Future<bool> updateStaff(String id, String companyid, firstname, lastname, nric, corporateemail, staff_phone, jobPosition, tower, unit_no, activation_date, enrollQR, enrollFR, consent,image) async{
    String url= "http://111.223.92.154:8091/acp_api/staffManagement.php?id=$id";
    String completeurl= url;

    SharedPreferences pref= await SharedPreferences.getInstance();
    HttpOverrides.global = MyHttpOverrides();

    Map<String, String> body = {
      "id": id,
      "first_name": firstname,
      "last_name": lastname,
      "nric_number": nric,
      "corporate_email": corporateemail,
      "staff_phone": staff_phone,
      "staff_job_position": jobPosition,
      "tower_id[0]": tower,
      "unit_number": unit_no,
      "activation_and_expiration_date": activation_date,
      "consent_to_terms_and_conditions": consent,
      "staff_email": corporateemail,
      "image_data": image,
      "company_id[0]": companyid,
      "full_name": pref.getString('full_name') ?? "",
      "user_id": pref.getString('userId') ?? "",
      "userRole": pref.getString('userRole') ?? "",
    };

    // Conditionally add enrollFR based on qr value
    if (enrollQR == "1") {
      body["enroll_qr"] = enrollQR;
    }

    if (enrollFR == "1") {
      body["enroll_fr"] = enrollFR;
    }

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
        print(responseBody['message']);
        notifyListeners();
      }
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

}