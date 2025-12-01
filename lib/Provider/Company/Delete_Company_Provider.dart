import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import '../../company/companymethods.dart';

class DeleteCompanyProvider extends ChangeNotifier{
  Future<bool> deleteCompany(String id) async{
    String url= "http://111.223.92.154:8091/acp_api/companyManagement.php?comp_id=$id";
    String completeurl= url;

    HttpOverrides.global = MyHttpOverrides();

    Map<String, String> jsonData = {
      "id": id,
    };

    var response = await http.delete(
        Uri.parse(completeurl),
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
}