import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:acp/blacklist/blacklistmodel.dart';
import 'package:flutter/cupertino.dart';
import '../../company/companymethods.dart';

class ViewBlacklistProvider extends ChangeNotifier{

  List<VisitorBlacklist> _addVisitorData= [];
  List<VisitorBlacklist> get addVisitorList => _addVisitorData;

  Future<void> viewBlackList(String id) async{
    String url= "http://111.223.92.154:8091/acp_api/visitorBlacklist.php?id=$id";
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
        _addVisitorData.clear();
        var jsonresponse= jsonDecode(response.body);
        for(var item in jsonresponse){
          final allstafflist= VisitorBlacklist.fromJson(item);
          _addVisitorData.add(allstafflist);
        }
      }
    }catch(e){
      print(e);
    }
    notifyListeners();
  }


}