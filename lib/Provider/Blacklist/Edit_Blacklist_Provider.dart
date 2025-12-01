import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../company/companymethods.dart';

class EditBlacklistProvider extends ChangeNotifier{

  Future<bool> updateBlacklist(String id, visitorName, documentNumber) async{
    String url= "http://111.223.92.154:8091/acp_api/visitorBlacklist.php?id=$id";
    String completeurl= url;

    HttpOverrides.global = MyHttpOverrides();

    var response = await http.post(
        Uri.parse(completeurl),
        headers: <String, String>{
          'Accept': 'application/json'
        },
        body: {
          "id": id,
          "full_name": "Admin",
          "user_id": "112",
          "userRole":"5",
          "visitor_name": visitorName,
          "document_number": documentNumber,
        }
    );

    try{
      if(response.statusCode==200){
        var responseBody= jsonDecode(response.body);
        print(responseBody['message']);
        notifyListeners();
      }
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

}