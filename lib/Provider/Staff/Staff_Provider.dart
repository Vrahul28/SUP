import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../../company/companymethods.dart';
import '../../staff/staffmodel.dart';

class StaffProvider extends ChangeNotifier{
  List<Staff> _stafflist= [];
  List<Staff> get staffList => _stafflist;

  late int _count;
  int get count => _count;

  Future<void> getAllStaffList(String? query, String? query2) async{

    // String url= "http://access.apm.sg/report_api/staffListing.php";
    String url= "http://111.223.92.154:8091/acp_api/staffManagement.php";
    String completeurl= url;

    HttpOverrides.global = MyHttpOverrides();

    var response = await http.get(
      Uri.parse(completeurl),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    try{
      if(response.statusCode==200){
        _stafflist.clear();
        var jsonresponse= jsonDecode(response.body);
        for(var item in jsonresponse){
          final allstafflist= Staff.fromJson(item);
          _stafflist.add(allstafflist);
        }

        _count= _stafflist.where((element) => element.company != null && element.company!.length > 0).length;
      }
    }catch(e){
      print(e);
    }
    notifyListeners();
  }
}