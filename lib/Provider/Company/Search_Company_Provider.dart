import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:acp/company/companymodel.dart';
import 'package:flutter/cupertino.dart';

import '../../company/companymethods.dart';

class SearchCompanyProvider extends ChangeNotifier{
  List<Company> _searchlist= [];
  List<Company> get searchList => _searchlist;

  late int _companycount;
  int get companycount => _companycount;

  Future<bool> searchCompany(List<int> companyId, List<int> towerId,String unitNo) async{
    String url= "http://111.223.92.154:8091/acp_api/companyManagementSearch.php";
    String completeurl= url;

    HttpOverrides.global = MyHttpOverrides();

    Map<String,  dynamic> jsonData= {
      "company_name": companyId,
      "tower":  towerId,
      "unit_no": unitNo
    };

    // Convert the map to a JSON string
    String jsonBody = jsonEncode(jsonData);
    print(jsonBody);

    var response = await http.post(
        Uri.parse(completeurl),
        headers: <String, String>{
          'Accept': 'application/json'
        },
        body: jsonBody
    );

    try{
      if(response.statusCode==200){
        _searchlist.clear();
        var jsonresponse= jsonDecode(response.body);
        print(jsonresponse);
        for(var item in jsonresponse){
          final company= Company.fromJson(item);
          _searchlist.add(company);
        }
        _companycount = _searchlist.where((element) => element.companyId != null && element.companyId!.isNotEmpty).length;

        return true;
      }else{
        print("Error: ${response.statusCode}");
        print(response.body); // To see the exact error
        return false;
      }

    }catch(e){
      print(e);
      return false;
    }
  }
}