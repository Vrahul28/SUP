import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:acp/company/companymethods.dart';
import 'package:acp/company/companymodel.dart';
import 'package:flutter/cupertino.dart';

class ViewCompanyProvider extends ChangeNotifier{

  List<Company> _viewCompanyData= [];
  List<Company> get viewCompanyData => _viewCompanyData;

  Future<void> viewCompanyList(String id) async{
    String url= "http://111.223.92.154:8091/acp_api/companyManagement.php?comp_id=$id";
    String completeurl= url;
    print(completeurl);

    HttpOverrides.global = MyHttpOverrides();

    var response = await http.get(
      Uri.parse(completeurl),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    try{
      if(response.statusCode==200){
        _viewCompanyData.clear();
        var jsonresponse= jsonDecode(response.body);
        print(jsonresponse);
        for(var item in jsonresponse){
          final allstafflist= Company.fromJson(item);
          _viewCompanyData.add(allstafflist);
        }
      }
    }catch(e){
      print(e);
    }
    notifyListeners();
  }
}