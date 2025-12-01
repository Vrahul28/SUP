import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../company/companymethods.dart';
import '../../staff/staffmodel.dart';

class StaffSearchProvider extends ChangeNotifier{

  List<Staff> _searchlist= [];
  List<Staff> get searchList => _searchlist;

  late int _staffcount;
  int get staffcount => _staffcount;

  Future<bool> searchStaff(List<int> companyId, String staff) async{
    String url= "http://111.223.92.154:8091/acp_api/staffManagementSearch.php";
    String completeurl= url;

    HttpOverrides.global = MyHttpOverrides();

    // Create a JSON map for the request body
    Map<String, dynamic> jsonData = {
      "company_name": companyId,
      "staff_name": staff,
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

        for(var item in jsonresponse){
          final staff= Staff.fromJson(item);
          _searchlist.add(staff);
        }

        _staffcount = _searchlist.where((element) => element.staffId != null && element.staffId!.isNotEmpty).length;
      }
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

}