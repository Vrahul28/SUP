import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../company/companymethods.dart';
import '../../utils/Custom_Snackbar.dart';

class OtpProvider extends ChangeNotifier{

  late String _fullname;
  late String _userRole;
  late String _username;
  late String _companyId;
  late SharedPreferences pref;

  String get fullname => _fullname;
  String get userRole => _userRole;
  String get username => _username;
  String get companyId => _companyId;

  OtpProvider() {
    _initializePreferences();
  }

  // Initialize SharedPreferences
  Future<void> _initializePreferences() async {
    pref = await SharedPreferences.getInstance();
    notifyListeners();
  }

  Future<bool> sendOTP(String email, String userId, String Otp, BuildContext context) async{
    String url= "http://111.223.92.154:8091/acp_api/otp_2fa.php";
    String completeurl= url;

    HttpOverrides.global = MyHttpOverrides();

    var response = await http.post(
        Uri.parse(completeurl),
        headers: <String, String>{
          'Accept': 'application/json'
        },
        body: {
          "email" : email,
          "user_id" : userId,
          "otp" : Otp,
        }
    );

    try{
      if(response.statusCode==200){
        var responseBody= jsonDecode(response.body);
        if(responseBody['status'] == "success"){
          _fullname= responseBody['full_name'];
          _userRole= responseBody['userRole'];
          _username= responseBody['username'];
          _companyId= responseBody['company_id'];

          pref.setString('full_name', _fullname);
          pref.setString('userRole', _userRole);
          pref.setString('username',_username);
          pref.setString("company_id", _companyId);

          return true;
        }else{
          final scaffoldMessengerState = ScaffoldMessenger.of(context);
          scaffoldMessengerState.showSnackBar(
              CustomSnackbar(text: "Invalid OTP").getSnackbar()
          );
          return false;
        }
      }
    }catch(e){
      print(e);
      return false;
    }
    return false;
  }


}