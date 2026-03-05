import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../blacklist/blacklistmodel.dart';
import '../../company/companymethods.dart';

class VisitorBlacklistProvider extends ChangeNotifier{

  TextEditingController documentNo= TextEditingController();
  TextEditingController visitorName= TextEditingController();
  TextEditingController totalBlacklist= TextEditingController();
  String blackListID= "";

  @override
  void dispose() {
    documentNo.dispose();
    visitorName.dispose();
    totalBlacklist.dispose();
    super.dispose();
  }


  //Lists
  List<VisitorBlacklist> _allBlacklistData= [];
  List<VisitorBlacklist> get allBlacklistData => _allBlacklistData;

  final List<VisitorBlacklist> _addVisitorData= [];
  List<VisitorBlacklist> get addVisitorList => _addVisitorData;

  late int _count;
  int get count => _count;

  void clearController(){
    documentNo.clear();
    visitorName.clear();
  }

  //Get BlackList Data
  Future<void> getBlacklistData(String? query,String? query2) async{
    // String url= "https://access.apm.sg/restApplicationUser/restBlackList/visitorBlackList/list";
    String url= "http://111.223.92.154:8091/acp_api/visitorBlacklist.php";
    String completeUrl= url;

    HttpOverrides.global = MyHttpOverrides();

    var response = await http.get(
      Uri.parse(completeUrl),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    if(response.statusCode==200){
      _allBlacklistData.clear();
      var jsonResponse= jsonDecode(response.body);
      for(var item in jsonResponse){
        final blacklist1= VisitorBlacklist.fromJson(item);
        _allBlacklistData.add(blacklist1);
      }

      if (query!.isNotEmpty) {
        Set<VisitorBlacklist> uniqueList = Set<VisitorBlacklist>();
        for (var item in jsonResponse) {
          final blist = VisitorBlacklist.fromJson(item);

          if (blist.documentNumber!.toLowerCase().contains(query.toLowerCase())) {
            uniqueList.add(blist);
          }
        }

        _allBlacklistData.clear();
        _allBlacklistData.addAll(uniqueList.toList());
      }

        if(query2 != null && query2.isNotEmpty){
          _allBlacklistData= _allBlacklistData.where((element) => element.visitorName!.toLowerCase()
              .contains(query2.toLowerCase())).toList();
        }
      _count= _allBlacklistData.length;

      notifyListeners();
    }
  }

  //View BlackList
  Future<void> viewBlackList(String id) async{
    String url= "http://111.223.92.154:8091/acp_api/visitorBlacklist.php?id=$id";
    String completeUrl= url;
    debugPrint(completeUrl);

    HttpOverrides.global = MyHttpOverrides();

    var response = await http.get(
      Uri.parse(completeUrl),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    try{
      if(response.statusCode==200){
        _addVisitorData.clear();
        var jsonResponse= jsonDecode(response.body);
        for(var item in jsonResponse){
          final allStaffList= VisitorBlacklist.fromJson(item);
          _addVisitorData.add(allStaffList);
        }
      }
    }catch(e){
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  //Delete Blacklist
  Future<bool> deleteVisitor(String id) async{
    String url= "http://111.223.92.154:8091/acp_api/visitorBlacklist.php?id=$id";
    String completeUrl= url;

    HttpOverrides.global = MyHttpOverrides();

    Map<String, String> jsonData = {
      "id": id,
    };

    var response = await http.delete(
        Uri.parse(completeUrl),
        body: jsonEncode(jsonData)
    );

    try{
      if(response.statusCode==200){
        var responseBody= jsonDecode(response.body);
        debugPrint('Response: $responseBody');
        notifyListeners();
      }
      return true;
    }catch(e){
      return false;
    }
  }

}