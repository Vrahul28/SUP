import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../appDashboard/dashboard/Total_Companies_Count.dart';
import '../../company/companymethods.dart';

class TotalCountProvider extends ChangeNotifier{
  List<TotalCount> _total= [];
  late int _count;
  int get count => _count;

  Future<void> getTotalCompanies() async{

    String url= "http://111.223.92.154:8091/acp_api/companyManagement.php?total=true";
    String completeUrl= url;

    HttpOverrides.global = MyHttpOverrides();

    var response = await http.get(
      Uri.parse(completeUrl),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    try{
      if(response.statusCode==200){
        _total.clear();
        var jsonresponse= jsonDecode(response.body);
        var totalData = jsonresponse[0];
        _count = int.tryParse(totalData['total']) ?? 0;
        print(_count);
        notifyListeners();
      }
    }catch(e){
      print(e);
    }
  }

}