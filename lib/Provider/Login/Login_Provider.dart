import 'dart:convert';
import 'dart:io';
import 'package:acp/Provider/Dashboard/Application_dashboard_Provider.dart';
import 'package:acp/Provider/Login/OTP_Provider.dart';
import 'package:acp/urls/urls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../appDashboard/gridlist.dart';
import '../../appDashboard/main_dashboard/main_dashboard.dart';
import '../../company/companymethods.dart';
import 'package:http/http.dart' as http;
import '../../login/userPreference.dart';
import '../../utils/Custom_Snackbar.dart';
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
    String url= Urls.loginAPI;
    String completeUrl= url;

    HttpOverrides.global = MyHttpOverrides();
    SharedPreferences pref= await SharedPreferences.getInstance();

    var response = await http.post(
        Uri.parse(completeUrl),
        headers: <String, String>{
          'Accept': 'application/json'
        },
        body: {
          "username": "vrahul2248@gmail.com",
          "password": "Rahul@123",
          "country": "",
          "ipAddress": ""
        }
    );
    try{
      if(response.statusCode==200){
        final data = jsonDecode(response.body);

        if(data['status'] == "1"){
          userId = data["userId"];
          email1 = data["email"];

          pref.setString("userId", userId!);
          bool success= await user.saveUser(email, password);

          if(success){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MainDashboard();
                  },
                )
            );
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) {
            //       return const Dashboard2();
            //     })
            // );

            loginTODashboard(context);
            await Provider.of<TotalCountProvider>(context, listen: false).getTotalCompanies();
            await Provider.of<StaffProvider>(context,listen: false).getAllStaffList("", "");
          }

          isLoading = false;
          notifyListeners();
        }else{
          isLoading = false;
          final scaffoldMessengerState = ScaffoldMessenger.of(context);
          scaffoldMessengerState.showSnackBar(
              CustomSnackbar(text: data['message']).getSnackbar()
          );
          notifyListeners();
        }
      }
    }catch(e){
      debugPrint("Login error: $e");
      isLoading = false;
      notifyListeners();
    }
  }


  List companyStaffDashboard= admin;
  Future<void> newList(String userRole) async{
    if(userRole == "5"){
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