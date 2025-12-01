import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../company/companymethods.dart';
import '../../company/companymodel.dart';

class CompanyProvider extends ChangeNotifier{
  List<Company> _allcompanydata= [];
  List<Company> get allCompanydate => _allcompanydata;

  late int _count;
  int get count => _count;


  Future<void> getCompany(String? query,String? query2, String? query3) async{

    // String url= "https://access.apm.sg/restApplicationUser/restCompany/company/list";
    String url= "http://111.223.92.154:8091/acp_api/companyManagement.php";
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
        _allcompanydata.clear();
        var jsonresponse= jsonDecode(response.body);
        for(var item in jsonresponse){
          final company= Company.fromJson(item);
          _allcompanydata.add(company);
        }

        // Reverse the list of companies
        _allcompanydata = _allcompanydata.reversed.toList();
        _count = _allcompanydata.where((element) => element.companyName != null && element.companyName!.isNotEmpty).length;

        if (query!.isNotEmpty) {
          Set<Company> uniqueCompanies = Set<Company>();
          for (var item in jsonresponse) {
            final company = Company.fromJson(item);

            if (company.towerId!.toLowerCase().contains(query.toLowerCase())) {
              uniqueCompanies.add(company);
            }
          }

          _allcompanydata.clear();
          _allcompanydata.addAll(uniqueCompanies.toList());

          print(_allcompanydata.length);
        }

        if(query2!.isNotEmpty){
          _allcompanydata= _allcompanydata.where((element) => element.companyName!.toLowerCase()
              .contains(query2.toLowerCase())).toList();

        }

        if(query3!=null){
          _allcompanydata= _allcompanydata.where((element) => element.unitNo!.toLowerCase()
              .contains(query3.toLowerCase())).toList();

        }
      }
    }catch(e){
      print(e);
    }
  notifyListeners();

  }
}