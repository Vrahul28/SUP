import 'dart:convert';
import 'dart:io';
import 'package:acp/company/companymodel.dart';
import 'package:acp/urls/urls.dart';
import 'package:acp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../Provider/Company/Company_Provider.dart';
import '../Provider/Staff/Insert_Staff_Provider.dart';
import '../Provider/Staff/Staff_Provider.dart';
import '../appDashboard/vistoracessmanagement/invitation.dart';
import '../staff/addstaff/addstaffmethods.dart';
import '../staff/staffscreen.dart';


List<Company> allCompanyData= [];
Future<void> getCompany(String? query,String? query2, String? query3, BuildContext context) async{
  final companyPro= context.read<CompanyProvider>();

  // String url= "https://access.apm.sg/restApplicationUser/restCompany/company/list";
  String url= "http://111.223.92.154:85/restApplicationUser/restCompany/company/list";
  HttpOverrides.global = MyHttpOverrides();

  var response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded'
    },
  );

  if(response.statusCode==200){
    allCompanyData.clear();
    var jsonResponse= jsonDecode(response.body);
    debugPrint("Company list: ${response.body}");
    for(var item in jsonResponse){
      final company= Company.fromJson(item);
      allCompanyData.add(company);
    }

    if (companyPro.towerCodeClass.text.isNotEmpty && query != null) {
      Set<Company> uniqueCompanies = Set<Company>();
      for (var item in jsonResponse) {
        final company = Company.fromJson(item);

        if (company.towerString!.toLowerCase().contains(query.toLowerCase())) {
          uniqueCompanies.add(company);
        }
      }

      allCompanyData.clear();
      allCompanyData.addAll(uniqueCompanies.toList());

      debugPrint(allCompanyData.length.toString());
    }

    if(companyPro.companyCodeClass.text.isNotEmpty){
      if(query2!=null){
        allCompanyData= allCompanyData.where((element) => element.company!.toLowerCase()
            .contains(query2.toLowerCase())).toList();
      }
    }

    if(companyPro.unitNoClass.text.isNotEmpty){
      if(query3!=null){
        allCompanyData= allCompanyData.where((element) => element.unitsNo!.toLowerCase()
            .contains(query3.toLowerCase())).toList();
      }
    }

    var count= allCompanyData.where((element) => element.towerString != null && element.towerString!.length > 0).length;

    companyPro.allResult.text= count.toString();
    debugPrint(count.toString());
  }
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}



List<Company> allTowerData= [];

Future<void> getTower(String? query) async{
  allTowerData.clear();
  // String tower= towercodeclass.text;
  String? tower= query;

  String urlparameter= 'tower='+ Uri.encodeComponent('$tower');
  String url= "https://access.apm.sg/restApplicationUser/restCompany/company/getCompanyDetailsByTowers";
  String completeUrl= '$url?$urlparameter';
  debugPrint(completeUrl);

  HttpOverrides.global = MyHttpOverrides();

  var response = await http.post(
    Uri.parse(completeUrl),
    body: urlparameter,
    encoding: Encoding.getByName('utf-8'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded'
    },
  );

  if(response.statusCode==200){
    var jsonResponse= jsonDecode(response.body);
    debugPrint(jsonResponse);
    for(var item in jsonResponse){
      final tower= Company.fromJson(item);
      allTowerData.add(tower);
    }

    // if (query != null) {
    //   Set<Company> uniqueCompanies = Set<Company>();
    //   for (var item in jsonresponse) {
    //     final company = Company.fromJson(item);
    //
    //     if (company.company!.toLowerCase().contains(query.toLowerCase())) {
    //       uniqueCompanies.add(company);
    //     }
    //   }
    //
    //   alltowerdata.clear();
    //   alltowerdata.addAll(uniqueCompanies.toList());
    //
    //   print(alltowerdata.length);
    // }
    // if(query!= null){
    //   alltowerdata= alltowerdata.where((company) => company.company!.toLowerCase()
    //       .contains(query.toLowerCase())).toList();
    // }
  }

}


List<Company> allcompanydata1= [];

Future<void> getCompany1(String? query,String? query2, BuildContext context) async{
  final companyPro= context.read<CompanyProvider>();
  allcompanydata1.clear();
  String url= "https://access.apm.sg/restApplicationUser/restCompany/company/list";
  String completeUrl= url;

  HttpOverrides.global = MyHttpOverrides();

  var response = await http.get(
    Uri.parse(completeUrl),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded'
    },
  );

  if(response.statusCode==200){
    var jsonResponse= jsonDecode(response.body);
    for(var item in jsonResponse){
      final company= Company.fromJson(item);
      allcompanydata1.add(company);
    }

    if (company.text.isNotEmpty && query != null) {
      allcompanydata1.clear();
      Set<Company> uniqueCompanies = Set<Company>();

      for (var item in jsonResponse) {
        final company = Company.fromJson(item);

        if (company.company!.toLowerCase().contains(query.toLowerCase())) {
          uniqueCompanies.add(company);
        }
      }
      allcompanydata1.addAll(uniqueCompanies.toList());

      // print(allcompanydata.length);
    }

    var count= allcompanydata1
        .where((element) => element.company != null && element.company!.length > 0)
        .length;

    companyPro.totalCompany.text=count.toString();
  }

}


// Tower
List<int> towerId= [];
class Tower extends StatefulWidget {
  final TextEditingController controller1;
  final FocusNode focusNode;
 const Tower({
   super.key,
   required this.controller1,
   required this.focusNode,
 });

  @override
  State<Tower> createState() => _TowerState();
}

class _TowerState extends State<Tower> {
  @override
  Widget build(BuildContext context) {
    final companyPro= context.read<CompanyProvider>();
    final staffProvider= context.read<InsertStaffProvider>();
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: TypeAheadField<Company?>(
          hideWithKeyboard: false,
          controller: widget.controller1,
          focusNode: widget.focusNode,
          builder: (context, controller, focusNode) {
            return TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a Tower';
                }
                return null;
              },
              focusNode: focusNode,
              style: GoogleFonts.poppins(
                color: kDarkblueColor,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
              controller: widget.controller1,
              decoration: InputDecoration(
                filled: true,
                fillColor:  kGinColor,
                prefixIcon: Icon(
                  Icons.cell_tower,
                  size: 24.0,
                  color: kDarkblueColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: kGinColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: kDarkblueColor),
                ),
                hintText: "Tower",
                hintStyle: GoogleFonts.poppins(
                  color: kDarkblueColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),

              ),
            );
          },
          suggestionsCallback: (pattern) async {
            List<String> predefinedTowers = ['1', '2', '3', '4', '5','6'];
            return predefinedTowers
                .where((tower) => tower.toLowerCase().contains(pattern.toLowerCase()))
                .map((tower) => Company(towerString: tower)) // Convert the list to Company objects
                .toList();
          },
          itemBuilder: (context, Company? suggestion) {
            final towers = suggestion!;
            return ListTile(
              title: Text(towers.towerString ?? '', style: GoogleFonts.poppins(
                color: kbluelightColor,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              )),
            );
          },
          emptyBuilder: (context) =>  SizedBox(
            height: 50,
            child: Center(
              child: Text(
                'No Tower Found.',
                  style: GoogleFonts.poppins(
                    color: kbluelightColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  )
              ),
            ),
          ),
          onSelected: (Company? suggestion) async{
            if (suggestion != null) {
              companyPro.towerCodeClass.text = suggestion.towerString?? '';
              staffProvider.location.text= suggestion.towerString?? '';
              towerId.clear();
              towerId.add(int.parse(suggestion.towerString!));
              getCompanyList(suggestion.towerString!);
              // await companyPro.searchCompany(towerId,companyID,companyPro.unitNoClass.text);
            }
          },
        ),

    );
  }
}


// Company
List<Company> companyData= [];

Future<void> getCompanyList(String towerNo) async{
  companyData.clear();
  String url= "http://111.223.92.154:85/restApplicationUser/restCompany/company/getCompanyDetailsByTowers";

  HttpOverrides.global = MyHttpOverrides();

  var response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: {
      "tower": towerNo,
    },
  );

  if(response.statusCode==200){
    var jsonResponse= jsonDecode(response.body);
    debugPrint("Company by tower: ${response.body}");
    for(var item in jsonResponse){
      final company= Company.fromJson(item);
      companyData.add(company);
    }
  }

}

class AllCompany extends StatefulWidget {
  final TextEditingController controller1;
  final String hint;
  const AllCompany(
      {super.key,
        required this.controller1,
        required this.hint,
      });

  @override
  State<AllCompany> createState() => _AllCompanyState();
}

class _AllCompanyState extends State<AllCompany> {

  @override
  Widget build(BuildContext context) {
    final staffProvider= context.read<InsertStaffProvider>();
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: TypeAheadField<Company?>(
          hideWithKeyboard: false,
          controller:widget.controller1,
          builder: (context, controller, focusNode) {
            return TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a company';
                }
                return null;
              },
              focusNode: focusNode,
              style: GoogleFonts.poppins(
                color: kDarkblueColor,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
              controller:widget.controller1,
              decoration: InputDecoration(
                filled: true,
                fillColor:  kGinColor,
                prefixIcon: Icon(
                  Icons.maps_home_work_outlined,
                  size: 24.0,
                  color: kDarkblueColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: kGinColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: kDarkblueColor),
                ),

                hintText: widget.hint,
                hintStyle: GoogleFonts.poppins(
                  color: kDarkblueColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
              ),
            );
          },
          suggestionsCallback: (pattern) async {
              if (staffProvider.location.text.isNotEmpty) {
                debugPrint("Tower: $tower");
                List<Company> filteredCompanies = companyData
                    .where((company) =>
                    company.company!.toLowerCase().contains(pattern.toLowerCase()))
                    .toList();
                return filteredCompanies;
              } else {
                // Handle the case when the tower code is empty
                return [];
              }
      },
          itemBuilder: (context, Company? suggestion) {
            final companyLists = suggestion!;
            return ListTile(
              title: Text(companyLists.company ?? '', style: GoogleFonts.poppins(
                color: kbluelightColor,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              )),
            );
          },
          emptyBuilder: (context) => SizedBox(
            height: 50,
            child: Center(
              child: Text(
                'No Company Found.',
                  style: GoogleFonts.poppins(
                    color: kbluelightColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 25.0,
                  )
              ),
            ),
          ),
          onSelected: (Company? suggestion) async{
            if (suggestion != null) {
              widget.controller1.text = suggestion.company?? '';
              // staffProvider.unitNo.text= suggestion.unitsNo?? '';
              staffProvider.companyId= suggestion.companyID!.toString();
              staffProvider.unitNo.text = await staffProvider.getUnitNo(suggestion.company!, staffProvider.location.text);
            }
          },
        ),

    );
  }
}




// Company for company screen

// Company
List<Company> allCompanyData1= [];

Future<void> getAllCompany() async{
  allCompanyData.clear();
  String url= "http://111.223.92.154:85/restApplicationUser/restCompany/company/list";

  HttpOverrides.global = MyHttpOverrides();

  var response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded'
    },
  );

  if(response.statusCode==200){
    var jsonResponse= jsonDecode(response.body);
    for(var item in jsonResponse){
      final company= Company.fromJson(item);
      allCompanyData.add(company);
    }
  }

}

late String TextCompanyId;
List<int> companyID= [];

class AllCompany1 extends StatefulWidget {
  final TextEditingController controller1;
  final String hint;
  final FocusNode focusNode;
  const AllCompany1(
      {Key? key,
        required this.controller1,
        required this.hint,
        required this.focusNode,
      })
      : super(key: key);

  @override
  State<AllCompany1> createState() => _AllCompany1State();
}

class _AllCompany1State extends State<AllCompany1> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCompany();
  }

  @override
  Widget build(BuildContext context) {
    final staffProvider= context.read<InsertStaffProvider>();
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: TypeAheadField<Company?>(
        hideWithKeyboard: true,
        controller:widget.controller1,
        focusNode: widget.focusNode,
        builder: (context, controller, focusNode) {
          return TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a company';
                }
                return null;
              },
              focusNode: focusNode,
              style: GoogleFonts.poppins(
                color: kDarkblueColor,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
              controller:widget.controller1,
              decoration: InputDecoration(
                filled: true,
                fillColor:  kGinColor,
                prefixIcon: Icon(
                  Icons.maps_home_work_outlined,
                  size: 24.0,
                  color: kDarkblueColor,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: kGinColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: kDarkblueColor),
                ),
                hintText: widget.hint,
                hintStyle: GoogleFonts.poppins(
                  color: kDarkblueColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
              )
          );
        },
        suggestionsCallback: (pattern) {
          return  allCompanyData
              .where((company) => company.company!.toLowerCase().contains(pattern.toLowerCase()))
              .toList();
        },
        itemBuilder: (context, Company? suggestion) {
          final companyLists = suggestion!;
          return ListTile(
            title: Text(companyLists.company ?? '', style: GoogleFonts.poppins(
              color: kbluelightColor,
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
            )),
          );
        },
        emptyBuilder: (context) => SizedBox(
          height: 50,
          child: Center(
            child: Text(
                'No Company Found.',
                style: GoogleFonts.poppins(
                  color: kbluelightColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 25.0,
                )
            ),
          ),
        ),
        onSelected: (Company? suggestion) async{
          if (suggestion != null) {
            widget.controller1.text = suggestion.company!;
            TextCompanyId= suggestion.companyID.toString();
            companyID.clear();
            companyID.add(suggestion.companyID!);
            staffProvider.unitNo.text= suggestion.unitsNo?? '';
            staffProvider.companyId= suggestion.companyID.toString();
            // await companyPro.searchCompany(towerId,companyID,companyPro.unitNoClass.text);
          }
        },
      ),
    );
  }
}

