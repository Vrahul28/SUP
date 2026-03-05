import 'dart:async';
import 'package:acp/appDashboard/dashboard2/dashboard2.dart';
import 'package:acp/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/Dashboard/Total_Count_Provider.dart';
import '../Provider/Login/Login_Provider.dart';
import '../Provider/Staff/Staff_Provider.dart';
import '../appDashboard/main_dashboard/main_dashboard.dart';
import '../login/userPreference.dart';


class SplashService {
  final UserPreference user = UserPreference();

  void login(BuildContext context) async{
    final loginProvider= context.read<LoginProvider>();
    user.getUser().then((value) async {
      if (value.isEmpty) {
        Timer(
          Duration(seconds: 2),
              () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              )
          ),
        );
      } else {
        await Provider.of<TotalCountProvider>(context, listen: false).getTotalCompanies();
        await Provider.of<StaffProvider>(context,listen: false).getAllStaffList("", "");
        await loginProvider.loginTODashboard(context);

        Timer(
          Duration(seconds: 2),
              () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainDashboard(),
              )
          ),
        );
      }
    }).onError((error, stackTrace) {
      print('Error in splash service: ${error.toString()}');
    });
  }

}