import 'dart:convert';
import 'dart:io';

import 'package:acp/login/userPreference.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../../company/companymethods.dart';
import '../../staff/addstaff/addStaff_model.dart';
import '../../staff/staffmodel.dart';

class StaffProvider extends ChangeNotifier{
  int totalListStaff= 0;
  bool isLoading = false;
  bool isSearchResult = false;

  List<Staff> _stafflist = [];
  List<Staff> get staffList => _stafflist;

  List<Staff> _searchlist = [];
  List<Staff> get searchList => _searchlist;

  List<AddStaff> _addStaffData= [];
  List<AddStaff> get addStaffList => _addStaffData;

  int _staffcount = 0;
  int get staffcount => _staffcount;

  int _count = 0;
  int get count => _count;

  TextEditingController companyId = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController staffCodeClass = TextEditingController();
  TextEditingController cardNo = TextEditingController();
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

  //Get Staff List
  Future<void> getAllStaffList(String? query, String? query2) async{
    isLoading = true;
    notifyListeners();

    String url= "http://111.223.92.154:85/restApplicationUser/restStaff/staff/filterStaff";
    HttpOverrides.global = MyHttpOverrides();

    UserPreference user= UserPreference();

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
      "userId": await user.getUserId()
    };

    // Convert the map to a JSON string
    String jsonBody = jsonEncode(jsonData);
    debugPrint(jsonData.toString());

    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/json"
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
        totalListStaff= _stafflist.length;
        isSearchResult = false;
      }
    }catch(e){
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

 //Add Staff

  Future<void> getAddStaffList(String id) async {

    String url = "http://111.223.92.154:85/restApplicationUser/restStaff/staff/viewstaff/$id";
    debugPrint(url);

    HttpOverrides.global = MyHttpOverrides();

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    try {
      if (response.statusCode == 200) {

        _addStaffData.clear();
        var jsonResponse = jsonDecode(response.body);
        final staff = AddStaff.fromJson(jsonResponse);
        _addStaffData.add(staff);

      }
    } catch (e) {
      debugPrint(e.toString());
    }

    notifyListeners();
  }

  //Delete Staff
  Future<bool> deleteStaff(String id, String userId) async{
    String url= "http://111.223.92.154:85/restApplicationUser/restStaff/staff/deletestaff/$staffId/$userId";
    String completeUrl= url;

    HttpOverrides.global = MyHttpOverrides();

    var response = await http.get(
        Uri.parse(completeUrl),
    );

    try{
      if(response.statusCode==201){
        var responseBody= jsonDecode(response.body);
        debugPrint('Response: $responseBody');
        getAllStaffList('','');
        notifyListeners();
      }
      return true;
    }catch(e){
      debugPrint(e.toString());
      return false;
    }
  }

  //Search Staff
  Future<bool> searchStaff(List<int> companyId, String staff, String cardNo) async{
    isLoading = true;
    notifyListeners();

    String url= "http://111.223.92.154:85/restApplicationUser/restStaff/staff/filterStaff";

    HttpOverrides.global = MyHttpOverrides();

    // Create a JSON map for the request body
    Map<String, dynamic> jsonData = {
      "tower": [],
      "company": companyId,
      "cardNumber": cardNo,
      "emailId": "",
      "staffName": staff,
      "staffId": "",
      "pageNo": "",
      "pageSize": "",
      "userId": "1935"
    };

    // Convert the map to a JSON string
    String jsonBody = jsonEncode(jsonData);
    debugPrint(jsonData.toString());

    var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json"
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
        isSearchResult = true;
        isLoading = false;
        notifyListeners();
      }
      return true;
    }catch(e){
      print(e);
      return false;
    }


  }


}