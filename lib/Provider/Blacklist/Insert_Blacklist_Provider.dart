import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../company/companymethods.dart';

class InsertBlacklistProvider extends ChangeNotifier{

  Future<bool> addBlacklist(String visitorName, documentNumber) async{
    String url= "http://111.223.92.154:8091/acp_api/visitorBlacklist.php";
    String completeurl= url;

    SharedPreferences pref= await SharedPreferences.getInstance();
    HttpOverrides.global = MyHttpOverrides();

    var response = await http.post(
        Uri.parse(completeurl),
        headers: <String, String>{
          'Accept': 'application/json'
        },
        body: {
          "full_name": pref.getString('full_name'),
          "user_id": pref.getString('userId'),
          "userRole":pref.getString('userRole'),
          "visitor_name": visitorName,
          "document_number": documentNumber,
        }
    );

    try{
      if(response.statusCode==200){
        var responseBody= jsonDecode(response.body);
        print(responseBody['message']);
      }
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }
}