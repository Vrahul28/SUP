import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../company/companymethods.dart';

class InsertBlacklistProvider extends ChangeNotifier{

  TextEditingController visitor= TextEditingController();
  TextEditingController document= TextEditingController();
  bool isUpdateBlacklist= false;
  bool viewBlacklist= false;
  late String blackListId;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    visitor.dispose();
    document.dispose();
  }

  void clearController(){
    visitor.clear();
    document.clear();
  }

  Future<bool> addBlacklist(String visitorName, documentNumber) async{
    String url= "http://111.223.92.154:8091/acp_api/visitorBlacklist.php";
    String completeUrl= url;

    SharedPreferences pref= await SharedPreferences.getInstance();
    HttpOverrides.global = MyHttpOverrides();

    var response = await http.post(
        Uri.parse(completeUrl),
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
        debugPrint(responseBody['message']);
      }
      return true;
    }catch(e){
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> updateBlacklist(String id, visitorName, documentNumber) async{
    String url= "http://111.223.92.154:8091/acp_api/visitorBlacklist.php?id=$id";
    String completeUrl= url;

    HttpOverrides.global = MyHttpOverrides();

    var response = await http.post(
        Uri.parse(completeUrl),
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
        debugPrint(responseBody['message']);
        notifyListeners();
      }
      return true;
    }catch(e){
      debugPrint(e.toString());
      return false;
    }
  }
}