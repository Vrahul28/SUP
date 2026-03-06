import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:acp/urls/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../appDashboard/main_dashboard/main_dashboard.dart';
import '../../company/companymethods.dart';
import '../../utils/Custom_Snackbar.dart';

class OtpProvider extends ChangeNotifier{

  TextEditingController otp= TextEditingController();

  late String _fullName;
  late String _userRole;
  late String _username;
  late String _companyId;
  late SharedPreferences pref;

  String get fullName => _fullName;
  String get userRole => _userRole;
  String get username => _username;
  String get companyId => _companyId;

  String username1= "";
  String userID= "";
  String status= "";


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    otp.dispose();
  }

  OtpProvider() {
    _initializePreferences();
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  // Initialize SharedPreferences
  Future<void> _initializePreferences() async {
    pref = await SharedPreferences.getInstance();
    notifyListeners();
  }

  Future<bool> sendOTP(String Otp,String email, BuildContext context) async{
    String url= Urls.otpAPI;
    String completeUrl= url;

    HttpOverrides.global = MyHttpOverrides();

    Map<String,  dynamic> jsonData= {
      "otp":Otp,
      "emailId": email
    };

    // Convert the map to a JSON string
    String jsonBody = jsonEncode(jsonData);
    debugPrint(jsonBody);

    var response = await http.post(
        Uri.parse(completeUrl),
        headers: <String, String>{
          "Content-Type": "application/json",
        },
        body: jsonBody
    );

    try{
      debugPrint(response.statusCode.toString());
      debugPrint("Response Body: ${response.body}");
      if(response.statusCode==200){
        return true;
      }
    }catch(e){
      debugPrint(e.toString());
      return false;
    }
    return false;
  }


}