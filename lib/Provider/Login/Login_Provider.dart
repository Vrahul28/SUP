import 'dart:convert';
import 'dart:io';
import 'package:acp/OTP_Page.dart';
import 'package:acp/Provider/Dashboard/Application_dashboard_Provider.dart';
import 'package:acp/Provider/Login/OTP_Provider.dart';
import 'package:acp/urls/urls.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../appDashboard/gridlist.dart';
import '../../appDashboard/main_dashboard/main_dashboard.dart';
import '../../company/companymethods.dart';
import 'package:http/http.dart' as http;
import '../../login/userPreference.dart';
import '../../utils/Custom_Snackbar.dart';
import '../../utils/colors.dart';
import '../Dashboard/Total_Count_Provider.dart';
import '../Dashboard/Visitor_Acess_Provider.dart';
import '../Staff/Staff_Provider.dart';


class LoginProvider extends ChangeNotifier{
  final UserPreference user= UserPreference();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();


  String? userId;
  String? email1;
  String? status;
  bool isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginAdmin(String email, String password, BuildContext context) async{
    isLoading= true;
    notifyListeners();

    String url= "http://111.223.92.154:85/restApplicationUser/restApplicationUser/login";
    debugPrint(url);

    HttpOverrides.global = MyHttpOverrides();
    SharedPreferences pref= await SharedPreferences.getInstance();

    Map<String,  dynamic> jsonData= {
      "username": email,
      "password": password,
      "country": "",
      "ipAddress": ""
    };
    //
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

        userId = data["userId"].toString();
        email1 = data["email"];

        pref.setString("userId", userId!);
        bool success= await user.saveUser(email, password);

        if(success){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return OtpPage();
                },
              )
          );
          loginTODashboard(context);
        }

        isLoading = false;
        notifyListeners();
      }else if(response.statusCode==500){
        Fluttertoast.showToast(msg: "Internal Server Error",textColor: kDarkblueColor,fontSize: 15.0,backgroundColor: Colors.white);
      }
    }catch(e){
      debugPrint("Login error: $e");
      isLoading = false;
      notifyListeners();
    }
  }


  List companyStaffDashboard= admin;
  Future<void> newList(String userRole) async{
    if(userRole == "1"){
      companyStaffDashboard= admin;
    }else if(userRole == "10"){
      companyStaffDashboard= staff;
    }
  }


  Future<void> loginTODashboard(BuildContext context) async{
    final appProvider= Provider.of<ApplicationDashboardProvider>(context,listen: false);
    final otpProvider = Provider.of<OtpProvider>(context, listen: false);
    final visitorProvider= Provider.of<VistorAcessProvider>(context, listen: false);

    // appProvider.isAdmin(otpProvider.userRole);
    // visitorProvider.isAdmin(otpProvider.userRole);
    // newList(otpProvider.userRole);

    await appProvider.isAdmin("1");
    await visitorProvider.isAdmin("5");
    await newList("5");
    notifyListeners();
  }

}