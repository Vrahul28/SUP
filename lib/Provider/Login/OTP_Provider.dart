import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:acp/urls/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<bool> sendOTP(String email, String userId, String Otp, BuildContext context) async{
    String url= Urls.otpAPI;
    String completeUrl= url;

    HttpOverrides.global = MyHttpOverrides();

    var response = await http.post(
        Uri.parse(completeUrl),
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
          _fullName= responseBody['full_name'];
          _userRole= responseBody['userRole'];
          _username= responseBody['username'];
          _companyId= responseBody['company_id'];

          pref.setString('full_name', _fullName);
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
      debugPrint(e.toString());
      return false;
    }
    return false;
  }


}