import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../company/companymethods.dart';

class ResendotpProvider extends ChangeNotifier{

  Future<bool> resendOTP(String email, String userId, String status) async{
    String url= "http://111.223.92.154:8091/acp_api/resendOtp.php";
    String completeUrl= url;

    HttpOverrides.global = MyHttpOverrides();

    var response = await http.post(
        Uri.parse(completeUrl),
        headers: <String, String>{
          'Accept': 'application/json'
        },
        body: {
          "email" : email,
          "user_id" : userId,
          "status" : status,
        }
    );

    try{
      if(response.statusCode==200){
        var responseBody= jsonDecode(response.body);
        debugPrint(responseBody);
        return true;
      }
    }catch(e){
      debugPrint(e.toString());
      return false;
    }
    return false;
  }

}