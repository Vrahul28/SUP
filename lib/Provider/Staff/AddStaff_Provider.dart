import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../company/companymethods.dart';
import '../../staff/addstaff/addStaff_model.dart';

class AddStaffProvider extends ChangeNotifier{
  List<Addstaff> _addStaffData= [];
  List<Addstaff> get addStaffList => _addStaffData;

  Future<void> getAddStaffList(String id) async{
    String url= "http://111.223.92.154:8091/acp_api/staffManagement.php?id=$id";
    String completeUrl= url;
    print(completeUrl);

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
      print(e);
    }
    notifyListeners();
  }

}