import 'dart:convert';
import 'dart:io';
import 'package:acp/Provider/Dashboard/Application_dashboard_Provider.dart';
import 'package:acp/Provider/Login/OTP_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../appDashboard/gridlist.dart';
import '../../company/companymethods.dart';
import 'package:http/http.dart' as http;
import '../../utils/Custom_Snackbar.dart';
import '../Dashboard/Visitor_Acess_Provider.dart';


class LoginProvider extends ChangeNotifier{

  late String _userid= '';
  String get userid => _userid;
  late String _email= '';
  String get email => _email;
  late String _status= '';
  String get status => _status;



  Future<bool> loginAdmin(String email, String password, BuildContext context) async{
    String url= "http://111.223.92.154:8091/acp_api/login.php";
    String completeurl= url;

    HttpOverrides.global = MyHttpOverrides();
    SharedPreferences pref= await SharedPreferences.getInstance();

    var response = await http.post(
        Uri.parse(completeurl),
        headers: <String, String>{
          'Accept': 'application/json'
        },
        body: {
          "email" : email,
          "password" : password
        }
    );

    try{
      if(response.statusCode==200){
        var responseBody= jsonDecode(response.body);
        print(responseBody);
        if(responseBody['status'] == "1"){
          _userid= responseBody['userId'];
          _email= responseBody['email'];
          _status= responseBody['status'];

          pref.setString('userId',  _userid);
          return true;
        }else{
          print("Error");
          final scaffoldMessengerState = ScaffoldMessenger.of(context);
          scaffoldMessengerState.showSnackBar(
              CustomSnackbar(text: responseBody['message']).getSnackbar()
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


  List CompanyStaffDashboard= admin;
  void newlist(String userRole){
    // if(userRole == "5"){
    //   CompanyStaffDashboard= admin;
    // }else if(userRole == "10"){
    //   CompanyStaffDashboard= staff;
    // }
  }


  void loginTODashboard(BuildContext context) async{
    final appProvider= Provider.of<ApplicationDashboardProvider>(context,listen: false);
    final otpProvider = Provider.of<OtpProvider>(context, listen: false);
    final visitorProvider= Provider.of<VistorAcessProvider>(context, listen: false);

    appProvider.isAdmin(otpProvider.userRole);
    visitorProvider.isAdmin(otpProvider.userRole);
    newlist(otpProvider.userRole);
    notifyListeners();
  }

}