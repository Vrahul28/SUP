import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../company/companymethods.dart';

class InsertStaffProvider extends ChangeNotifier{

  Future<bool> addStaff(String firstname, lastname, nric, corporateemail, staff_phone, jobPosition, tower, unit_no, activation_date, enrollQR, enrollFR, consent,image) async{
    String url= "http://111.223.92.154:8091/acp_api/staffManagement.php";
    String completeurl= url;

    SharedPreferences pref= await SharedPreferences.getInstance();
    HttpOverrides.global = MyHttpOverrides();

    var response = await http.post(
        Uri.parse(completeurl),
        headers: <String, String>{
          'Accept': 'application/json'
        },
        body: {
          "first_name": firstname,
          "last_name": lastname,
          "nric_number": nric,
          "corporate_email": corporateemail,
          "staff_phone": staff_phone,
          "staff_job_position": jobPosition,
          "tower_id": tower,
          "unit_number": unit_no,
          "activation_and_expiration_date": activation_date,
          "enroll_FR": enrollFR,
          "enroll_QR": enrollQR,
          "consent_to_terms_and_conditions": consent,
          "staff_email": corporateemail,
          "image_data": image,
          "company_id": pref.getString('company_id'),
          "full_name": pref.getString('full_name'),
          "user_id": pref.getString('userId'),
          "userRole":pref.getString('userRole'),
        }
    );

    try{
      if(response.statusCode==200){
        var responseBody= jsonDecode(response.body);
        print(responseBody['New card number generated']);
      }
      return true;
    }catch(e){
      print(e);
      return false;
    }

  }

}