import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../company/companymethods.dart';
import '../../company/companymodel.dart';

class CompanyProvider extends ChangeNotifier{
  TextEditingController companyCodeClass = TextEditingController();
  TextEditingController towerCodeClass = TextEditingController();
  TextEditingController unitNoClass = TextEditingController();
  TextEditingController totalCompany= TextEditingController();
  TextEditingController allResult= TextEditingController();

  bool isAdd= false;
  bool addingCompany= false;
  bool isSearch= false;

  late String companyListid;
  late int viewId;
  String companyId1= "";

  //All company List
  List<Company> _allCompanyData= [];
  List<Company> get allCompanyDate => _allCompanyData;

  //All viewCompany Data
  List<Company> _viewCompanyData= [];
  List<Company> get viewCompanyData => _viewCompanyData;

  late int _count;
  int get count => _count;

  //Search
  List<Company> _searchList= [];
  List<Company> get searchList => _searchList;

  late int _companyCount;
  int get companyCount => _companyCount;

  @override
  void dispose() {
    super.dispose();
    companyCodeClass.dispose();
    towerCodeClass.dispose();
    unitNoClass.dispose();
    totalCompany.dispose();
    allResult.dispose();
  }

  void clearController(){
    companyCodeClass.clear();
    towerCodeClass.clear();
    unitNoClass.clear();
    totalCompany.clear();
    allResult.clear();
  }


  //Get Company
  Future<void> getCompany(String? query,String? query2, String? query3) async{

    // String url= "https://access.apm.sg/restApplicationUser/restCompany/company/list";
    String url= "http://111.223.92.154:8091/acp_api/companyManagement.php";
    String completeUrl= url;


    HttpOverrides.global = MyHttpOverrides();

    var response = await http.get(
      Uri.parse(completeUrl),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    try{
      if(response.statusCode==200){
        _allCompanyData.clear();
        var jsonresponse= jsonDecode(response.body);
        for(var item in jsonresponse){
          final company= Company.fromJson(item);
          _allCompanyData.add(company);
        }

        // Reverse the list of companies
        _allCompanyData =  _allCompanyData.reversed.toList();
        _count =  _allCompanyData.where((element) => element.companyName != null && element.companyName!.isNotEmpty).length;

        if (query!.isNotEmpty) {
          Set<Company> uniqueCompanies = Set<Company>();
          for (var item in jsonresponse) {
            final company = Company.fromJson(item);

            if (company.towerId!.toLowerCase().contains(query.toLowerCase())) {
              uniqueCompanies.add(company);
            }
          }

          _allCompanyData.clear();
          _allCompanyData.addAll(uniqueCompanies.toList());

          debugPrint(_allCompanyData.length.toString());
        }

        if(query2!.isNotEmpty){
          _allCompanyData=  _allCompanyData.where((element) => element.companyName!.toLowerCase()
              .contains(query2.toLowerCase())).toList();

        }

        if(query3!=null){
          _allCompanyData=  _allCompanyData.where((element) => element.unitNo!.toLowerCase()
              .contains(query3.toLowerCase())).toList();

        }
      }
    }catch(e){
      debugPrint(e.toString());
    }
  notifyListeners();

  }

  //View Company List
  Future<void> viewCompanyList(String id) async{
    String url= "http://111.223.92.154:8091/acp_api/companyManagement.php?comp_id=$id";
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
        _viewCompanyData.clear();
        var jsonResponse= jsonDecode(response.body);
        debugPrint(jsonResponse);
        for(var item in jsonResponse){
          final allStaffList= Company.fromJson(item);
          _viewCompanyData.add(allStaffList);
        }
      }
    }catch(e){
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  //Delete Company
  Future<bool> deleteCompany(String id) async{
    String url= "http://111.223.92.154:8091/acp_api/companyManagement.php?comp_id=$id";
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
      debugPrint(e.toString());
      return false;
    }
  }

  //Search Company
  Future<bool> searchCompany(List<int> companyId, List<int> towerId,String unitNo) async{
    String url= "http://111.223.92.154:8091/acp_api/companyManagementSearch.php";
    String completeUrl= url;

    HttpOverrides.global = MyHttpOverrides();

    Map<String,  dynamic> jsonData= {
      "company_name": companyId,
      "tower":  towerId,
      "unit_no": unitNo
    };

    // Convert the map to a JSON string
    String jsonBody = jsonEncode(jsonData);
    debugPrint(jsonBody);

    var response = await http.post(
        Uri.parse(completeUrl),
        headers: <String, String>{
          'Accept': 'application/json'
        },
        body: jsonBody
    );

    try{
      if(response.statusCode==200){
        _searchList.clear();
        var jsonResponse= jsonDecode(response.body);
        debugPrint(jsonResponse);
        for(var item in jsonResponse){
          final company= Company.fromJson(item);
          _searchList.add(company);
        }
        _companyCount = _searchList.where((element) => element.companyId != null && element.companyId!.isNotEmpty).length;

        return true;
      }else{
        debugPrint("Error: ${response.statusCode}");
        debugPrint(response.body); // To see the exact error
        return false;
      }

    }catch(e){
      debugPrint(e.toString());
      return false;
    }
  }


}