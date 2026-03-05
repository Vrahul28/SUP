import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../../company/companymethods.dart';
import '../../staff/addstaff/addStaff_model.dart';
import '../../staff/staffmodel.dart';

class StaffProvider extends ChangeNotifier{
  TextEditingController companyId = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController staffCodeClass = TextEditingController();
  TextEditingController totalStaff = TextEditingController();
  TextEditingController totalStaff1 = TextEditingController();

  @override
  void dispose() {
    companyId.dispose();
    company.dispose();
    staffCodeClass.dispose();
    totalStaff.dispose();
    totalStaff1.dispose();
    super.dispose();
  }
  
  String staffId= "";
  String companyId1= '';
  bool isSearchStaff= false;

  List<Staff> _stafflist= [];
  List<Staff> get staffList => _stafflist;

  List<Addstaff> _addStaffData= [];
  List<Addstaff> get addStaffList => _addStaffData;

  List<Staff> _searchlist= [];
  List<Staff> get searchList => _searchlist;

  late int _staffcount;
  int get staffcount => _staffcount;

  late int _count;
  int get count => _count;

  //Get Staff List
  Future<void> getAllStaffList(String? query, String? query2) async{
    // String url= "http://access.apm.sg/report_api/staffListing.php";
    // String url= "http://111.223.92.154:8091/acp_api/staffManagement.php";
    String url= "http://111.223.92.154:85/restApplicationUser/restStaff/staff/filterStaff";
    String completeUrl= url;

    HttpOverrides.global = MyHttpOverrides();

    // Create a JSON map for the request body
    Map<String, dynamic> jsonData = {
      "tower": [],
      "company": [],
      "cardNumber": "",
      "emailId": "",
      "staffName": "",
      "staffId": "",
      "pageNo": "",
      "pageSize": "",
      "userId": "1935"
    };

    // Convert the map to a JSON string
    String jsonBody = jsonEncode(jsonData);
    debugPrint(jsonBody);

    var response = await http.post(
      Uri.parse(completeUrl),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: jsonBody
    );

    try{
      if(response.statusCode==200){
        _stafflist.clear();
        var jsonResponse= jsonDecode(response.body);
        for(var item in jsonResponse){
          final allStaffList= Staff.fromJson(item);
          _stafflist.add(allStaffList);
        }
        _count= _stafflist.where((element) => element.company != null && element.company!.length > 0).length;
      }
    }catch(e){
      debugPrint(e.toString());
    }
    notifyListeners();
  }

 //Add Staff

  Future<void> getAddStaffList(String id) async{
    String url= "http://111.223.92.154:8091/acp_api/staffManagement.php?id=$id";
    String completeUrl= url;
    debugPrint(completeUrl);

    HttpOverrides.global = MyHttpOverrides();

    var response = await http.get(
      Uri.parse(completeUrl),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    try{
      if(response.statusCode==200){
        _addStaffData.clear();
        var jsonResponse= jsonDecode(response.body);
        for(var item in jsonResponse){
          final allStaffList= Addstaff.fromJson(item);
          _addStaffData.add(allStaffList);
        }
      }
    }catch(e){
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  //Delete Staff
  Future<bool> deleteStaff(String id) async{
    String url= "http://111.223.92.154:8091/acp_api/staffManagement.php?id=$id";
    String completeUrl= url;

    HttpOverrides.global = MyHttpOverrides();

    Map<String, String> jsonData = {
      "id": id,
    };

    var response = await http.delete(
        Uri.parse(completeUrl),
        body: jsonEncode(jsonData)
    );

    try{
      if(response.statusCode==200){
        var responseBody= jsonDecode(response.body);
        print('Response: $responseBody');
        notifyListeners();
      }
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  //Search Staff
  Future<bool> searchStaff(List<int> companyId, String staff) async{
    String url= "http://111.223.92.154:8091/acp_api/staffManagementSearch.php";
    String completeUrl= url;

    HttpOverrides.global = MyHttpOverrides();

    // Create a JSON map for the request body
    Map<String, dynamic> jsonData = {
      "company_name": companyId,
      "staff_name": staff,
    };

    // Convert the map to a JSON string
    String jsonBody = jsonEncode(jsonData);
    print(jsonBody);

    var response = await http.post(
        Uri.parse(completeUrl),
        headers: <String, String>{
          'Accept': 'application/json'
        },
        body: jsonBody
    );

    try{
      if(response.statusCode==200){
        _searchlist.clear();
        var jsonResponse= jsonDecode(response.body);

        for(var item in jsonResponse){
          final staff= Staff.fromJson(item);
          _searchlist.add(staff);
        }

        _staffcount = _searchlist.where((element) => element.staffId != null).length;
      }
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }


}