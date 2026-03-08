import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../company/companymethods.dart';
import '../../company/companymodel.dart';

class CompanyProvider extends ChangeNotifier{
  int totalCompanyList= 0;
  bool isLoadingList = false;
  bool isSearching = false;
  bool isDeleting = false;


  TextEditingController companyCodeClass = TextEditingController();
  TextEditingController towerCodeClass = TextEditingController();
  TextEditingController unitNoClass = TextEditingController();
  TextEditingController totalCompany= TextEditingController();
  TextEditingController allResult= TextEditingController();

  bool isAdd= false;
  bool addingCompany= false;
  bool isSearchResult = false;



  String companyListId='';
  int? viewId;
  String companyId1= "";

  //All company List
  List<Company> _allCompanyData= [];
  List<Company> get allCompanyDate => _allCompanyData;

  //All viewCompany Data
  List<CompanyTowerList> _viewCompanyData= [];
  List<CompanyTowerList> get viewCompanyData => _viewCompanyData;

 int _count=0;
  int get count => _count;

  //Search
  List<Company> _searchList= [];
  List<Company> get searchList => _searchList;

  int _companyCount=0;
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
  Future<void> getCompany() async{
    isLoadingList = true;
    notifyListeners();

    String url= "http://111.223.92.154:85/restApplicationUser/restCompany/company/list";
    HttpOverrides.global = MyHttpOverrides();

    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    try{
      if(response.statusCode==200){
        _allCompanyData.clear();
        var jsonResponse= jsonDecode(response.body);
        for(var item in jsonResponse){
          final company= Company.fromJson(item);
          _allCompanyData.add(company);
        }

        // Reverse the list of companies
        // _allCompanyData =  _allCompanyData.reversed.toList();
        _count =  _allCompanyData.where((element) => element.company != null && element.company!.isNotEmpty).length;
        totalCompanyList= _allCompanyData.length;
        notifyListeners();
      }
    }catch(e){
      debugPrint(e.toString());
    }
    isLoadingList = false;
    notifyListeners();
  }

  //View Company List
  Future<void> viewCompanyList(String id) async{
    // String url= "http://111.223.92.154:8091/acp_api/companyManagement.php?comp_id=$id";
    String url= "http://111.223.92.154:85/restApplicationUser/restCompany/company/getCompanyTowerList/$id";
    debugPrint(url);

    HttpOverrides.global = MyHttpOverrides();

    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    try{
      if(response.statusCode==200){
        _viewCompanyData.clear();
        var jsonResponse= jsonDecode(response.body);
        debugPrint(jsonResponse.toString());
        for(var item in jsonResponse){
          final allStaffList= CompanyTowerList.fromJson(item);
          _viewCompanyData.add(allStaffList);
        }
      }
    }catch(e){
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  Future<List<CompanyTowerList>> viewCompanyListForTable(String id) async {

    String url= "http://111.223.92.154:85/restApplicationUser/restCompany/company/getCompanyTowerList/$id";
    debugPrint(url);

    HttpOverrides.global = MyHttpOverrides();

    var response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    try{
      if(response.statusCode==200){

        _viewCompanyData.clear();
        var jsonResponse = jsonDecode(response.body);
        for(var item in jsonResponse){
          final data = CompanyTowerList.fromJson(item);
          _viewCompanyData.add(data);
        }

        notifyListeners();
        return _viewCompanyData;
      }

    }catch(e){
      debugPrint(e.toString());
    }

    return [];
  }

  //Delete Company
  Future<bool> deleteCompanyById(String id, String userID) async {
    try {
      isDeleting = true;
      notifyListeners();

      String url = "http://111.223.92.154:85/restApplicationUser/restCompany/company/deletecompany/$id/$userID";
      HttpOverrides.global = MyHttpOverrides();

      var response = await http.get(
        Uri.parse(url),
      );

      debugPrint("Delete company: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        debugPrint('Response: ${responseBody.toString()}');
        await getCompany();
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }finally {
      isDeleting = false;
      notifyListeners();
    }

    return false;
  }

  //Search Company
  Future<bool> searchCompany(List<int> towerId, List<int> companyId,String unitNo) async{
    String url= "http://111.223.92.154:85/restApplicationUser/restCompany/company/filterCompany";
    HttpOverrides.global = MyHttpOverrides();

    Map<String,  dynamic> jsonData= {
      "tower":  towerId,
      "company": companyId,
      "unit": unitNo
    };

    // Convert the map to a JSON string
    String jsonBody = jsonEncode(jsonData);
    print(jsonBody);

    isSearching = true;
    notifyListeners();

    var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonBody
    );

    try{
      if(response.statusCode==200){
        _searchList.clear();
        var jsonResponse = jsonDecode(response.body);
        debugPrint(response.body.toString());
        _searchList = jsonResponse.map<Company>((e) => Company.fromJson(e)).toList();
        _companyCount = _searchList
            .where((element) => element.company != null && element.company!.isNotEmpty)
            .length;

        isSearchResult = true;   // 🔴 IMPORTANT
        notifyListeners();
        return true;
      }else{
        debugPrint("Error: ${response.statusCode}");
        debugPrint(response.body); // To see the exact error
        return false;
      }

    }catch(e){
      debugPrint(e.toString());
      return false;
    }finally {
      isSearching = false;
      notifyListeners();
    }
  }


}