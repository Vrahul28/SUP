import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../../company/companymethods.dart';

class DeleteBlacklistProvider extends ChangeNotifier{

  Future<bool> deleteVisitor(String id) async{
    String url= "http://111.223.92.154:8091/acp_api/visitorBlacklist.php?id=$id";
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
      return false;
    }
  }
}