import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../blacklist/blacklistmodel.dart';
import '../../company/companymethods.dart';

class VisitorBlacklistProvider extends ChangeNotifier{

  List<VisitorBlacklist> _allblacklistdata= [];
  List<VisitorBlacklist> get allBlacklistData => _allblacklistdata;

  late int _count;
  int get count => _count;

  Future<void> getBlacklistData(String? query,String? query2) async{

    // String url= "https://access.apm.sg/restApplicationUser/restBlackList/visitorBlackList/list";
    String url= "http://111.223.92.154:8091/acp_api/visitorBlacklist.php";
    String completeurl= url;

    HttpOverrides.global = MyHttpOverrides();

    var response = await http.get(
      Uri.parse(completeurl),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    if(response.statusCode==200){
      _allblacklistdata.clear();
      var jsonresponse= jsonDecode(response.body);
      for(var item in jsonresponse){
        final blacklist1= VisitorBlacklist.fromJson(item);
        _allblacklistdata.add(blacklist1);
      }

      if (query!.isNotEmpty) {
        Set<VisitorBlacklist> uniquelist = Set<VisitorBlacklist>();
        for (var item in jsonresponse) {
          final blist = VisitorBlacklist.fromJson(item);

          if (blist.documentNumber!.toLowerCase().contains(query.toLowerCase())) {
            uniquelist.add(blist);
          }
        }

        _allblacklistdata.clear();
        _allblacklistdata.addAll(uniquelist.toList());
      }

        if(query2 != null && query2.isNotEmpty){
          _allblacklistdata= _allblacklistdata.where((element) => element.visitorName!.toLowerCase()
              .contains(query2.toLowerCase())).toList();
        }


      _count= _allblacklistdata.length;

      notifyListeners();
    }
  }

}