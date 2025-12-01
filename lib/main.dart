import 'package:acp/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/Blacklist/Edit_Blacklist_Provider.dart';
import 'Provider/Blacklist/Insert_Blacklist_Provider.dart';
import 'Provider/Blacklist/View_Blacklist_Provider.dart';
import 'Provider/Blacklist/Visitor_BlackList_Provider.dart';
import 'Provider/Blacklist/delete_Blacklist_Provider.dart';
import 'Provider/Company/Company_Provider.dart';
import 'Provider/Company/DataTable_Provider.dart';
import 'Provider/Company/Delete_Company_Provider.dart';
import 'Provider/Company/Edit_Company_Provider.dart';
import 'Provider/Company/Insert_Company_Provider.dart';
import 'Provider/Company/Search_Company_Provider.dart';
import 'Provider/Company/View_Company_Provider.dart';
import 'Provider/Dashboard/Application_dashboard_Provider.dart';
import 'Provider/Dashboard/Total_Count_Provider.dart';
import 'Provider/Dashboard/Visitor_Acess_Provider.dart';
import 'Provider/Login/Login_Provider.dart';
import 'Provider/Login/OTP_Provider.dart';
import 'Provider/Login/ResendOTP_Provider.dart';
import 'Provider/Permit_to_Work/Parking_details_Provider.dart';
import 'Provider/Permit_to_Work/Permit_to_Work_Provider.dart';
import 'Provider/Permit_to_Work/Site_Worker_Provider.dart';
import 'Provider/Staff/AddStaff_Provider.dart';
import 'Provider/Staff/Edit_Staff_Provider.dart';
import 'Provider/Staff/Insert_Staff_Provider.dart';
import 'Provider/Staff/Staff_Provider.dart';
import 'Provider/Staff/Staff_Search_Provider.dart';
import 'Provider/Staff/delete_Staff_Provider.dart';
import 'Provider/visitor_details_report_provider/visitor_details_report_provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => EquipmentProvider()),
          ChangeNotifierProvider(create: (_) => SiteWorkerProvider()),
          ChangeNotifierProvider(create: (_) => ParkingDetailsProvider()),
          ChangeNotifierProvider(create: (_) => VistorAcessProvider()),
          ChangeNotifierProvider(create: (_) => LoginProvider()),
          ChangeNotifierProvider(create: (_) => OtpProvider()),
          ChangeNotifierProvider(create: (_) => ResendotpProvider()),
          ChangeNotifierProvider(create: (_) => ApplicationDashboardProvider()),
          ChangeNotifierProvider(create: (_) => TotalCountProvider()),
          ChangeNotifierProvider(create: (_) => VisitorBlacklistProvider()),
          ChangeNotifierProvider(create: (_) => InsertBlacklistProvider()),
          ChangeNotifierProvider(create: (_) => EditBlacklistProvider()),
          ChangeNotifierProvider(create: (_) => ViewBlacklistProvider()),
          ChangeNotifierProvider(create: (_) => DeleteBlacklistProvider()),
          ChangeNotifierProvider(create: (_) => CompanyProvider()),
          ChangeNotifierProvider(create: (_) => ViewCompanyProvider()),
          ChangeNotifierProvider(create: (_) => InsertCompanyProvider()),
          ChangeNotifierProvider(create: (_) => EditCompanyProvider()),
          ChangeNotifierProvider(create: (_) => DeleteCompanyProvider()),
          ChangeNotifierProvider(create: (_) => DatatableProvider()),
          ChangeNotifierProvider(create: (_) => SearchCompanyProvider()),
          ChangeNotifierProvider(create: (_) => StaffProvider()),
          ChangeNotifierProvider(create: (_) => AddStaffProvider()),
          ChangeNotifierProvider(create: (_) => InsertStaffProvider()),
          ChangeNotifierProvider(create: (_) => EditStaffProvider()),
          ChangeNotifierProvider(create: (_) => DeleteStaffProvider()),
          ChangeNotifierProvider(create: (_) => StaffSearchProvider()),
          ChangeNotifierProvider(create: (_) => VisitorDetailsReportProvider()),
        ],
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
    home: Splash(),
    debugShowCheckedModeBanner: false,
    );
  }
}

