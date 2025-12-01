import 'dart:convert';
import 'dart:io';
import 'package:acp/company/companymodel.dart';
import 'package:acp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../staff/addstaff/addstaff.dart';
import '../staff/addstaff/addstaffmethods.dart';
import '../staff/staffscreen.dart';

import 'companyscreen.dart';

List<Company> allcompanydata= [];
Future<void> getCompany(String? query,String? query2, String? query3) async{

  // String url= "https://access.apm.sg/restApplicationUser/restCompany/company/list";
  String url= "http://111.223.92.154:8091/acp_api/companyManagement.php";
  String completeurl= url;

  HttpOverrides.global = MyHttpOverrides();

  var response = await http.get(
    Uri.parse(completeurl),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded'
    },
  );

  if(response.statusCode==200){
    allcompanydata.clear();
    var jsonresponse= jsonDecode(response.body);
    for(var item in jsonresponse){
      final company= Company.fromJson(item);
      allcompanydata.add(company);
    }

    // if(towercodeclass.text.isNotEmpty){
    //   if(query!= null){
    //     allcompanydata= allcompanydata.where((element) => element.towerString!.toLowerCase()
    //         .contains(query.toLowerCase())).toSet().toList();
    //     print(allcompanydata.length);
    //   }
    // }

    if (towercodeclass.text.isNotEmpty && query != null) {
      Set<Company> uniqueCompanies = Set<Company>();
      for (var item in jsonresponse) {
        final company = Company.fromJson(item);

        if (company.towerId!.toLowerCase().contains(query.toLowerCase())) {
          uniqueCompanies.add(company);
        }
      }

      allcompanydata.clear();
      allcompanydata.addAll(uniqueCompanies.toList());

      print(allcompanydata.length);
    }

    // if (companycodeclass.text.isNotEmpty && query2!=null) {
    //   Set<Company> uniquestaffcomp = Set<Company>();
    //
    //   for (var item in jsonresponse) {
    //     final company = Company.fromJson(item);
    //
    //     if (company.company!.toLowerCase().contains(query2.toLowerCase())) {
    //       uniquestaffcomp.add(company);
    //     }
    //   }
    //
    //   allcompanydata.clear();
    //   allcompanydata.addAll(uniquestaffcomp.toList());
    //
    //   print(allcompanydata.length);
    // }

    if(companycodeclass.text.isNotEmpty){
      if(query2!=null){
        allcompanydata= allcompanydata.where((element) => element.companyName!.toLowerCase()
            .contains(query2.toLowerCase())).toList();

      }
    }

    if(unitnoclass.text.isNotEmpty){
      if(query3!=null){
        allcompanydata= allcompanydata.where((element) => element.unitNo!.toLowerCase()
            .contains(query3.toLowerCase())).toList();

      }
    }

    var count= allcompanydata
        .where((element) => element.towerId != null && element.towerId!.length > 0)
        .length;
    allresult.text= count.toString();
    print(count);
  }
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}



List<Company> alltowerdata= [];

Future<void> getTower(String? query) async{
  alltowerdata.clear();
  // String tower= towercodeclass.text;
  String? tower= query;

  String urlparameter= 'tower='+ Uri.encodeComponent('$tower');
  String url= "https://access.apm.sg/restApplicationUser/restCompany/company/getCompanyDetailsByTowers";
  String completeurl= '$url?$urlparameter';
  print(completeurl);

  HttpOverrides.global = MyHttpOverrides();

  var response = await http.post(
    Uri.parse(completeurl),
    body: urlparameter,
    encoding: Encoding.getByName('utf-8'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded'
    },
  );

  if(response.statusCode==200){
    var jsonresponse= jsonDecode(response.body);
    print(jsonresponse);
    for(var item in jsonresponse){
      final tower= Company.fromJson(item);
      alltowerdata.add(tower);
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

Future<void> getCompany1(String? query,String? query2) async{
  allcompanydata1.clear();
  String url= "https://access.apm.sg/restApplicationUser/restCompany/company/list";
  String completeurl= url;

  HttpOverrides.global = MyHttpOverrides();

  var response = await http.get(
    Uri.parse(completeurl),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded'
    },
  );

  if(response.statusCode==200){
    var jsonresponse= jsonDecode(response.body);
    for(var item in jsonresponse){
      final company= Company.fromJson(item);
      allcompanydata1.add(company);
    }

    if (company.text.isNotEmpty && query != null) {
      allcompanydata1.clear();
      Set<Company> uniqueCompanies = Set<Company>();

      for (var item in jsonresponse) {
        final company = Company.fromJson(item);

        if (company.companyName!.toLowerCase().contains(query.toLowerCase())) {
          uniqueCompanies.add(company);
        }
      }
      allcompanydata1.addAll(uniqueCompanies.toList());

      // print(allcompanydata.length);
    }

    var count= allcompanydata1
        .where((element) => element.companyName != null && element.companyName!.length > 0)
        .length;

    totalcompany.text=count.toString();
  }

}


// Tower
List<int> towerId= [];
class Tower extends StatefulWidget {
  final TextEditingController controller1;
 Tower({
   Key? key,
   required this.controller1,
 }) : super(key: key);

  @override
  State<Tower> createState() => _TowerState();
}

class _TowerState extends State<Tower> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: TypeAheadField<Company?>(
          hideWithKeyboard: true,
          controller: widget.controller1,
          builder: (context, controller, focusNode) {
            return TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a contract';
                }
                return null;
              },
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
                .map((tower) => Company(towerId: tower)) // Convert the list to Company objects
                .toList();
          },
          itemBuilder: (context, Company? suggestion) {
            final towers = suggestion!;
            return ListTile(
              title: Text(towers.towerId ?? '', style: GoogleFonts.poppins(
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
          onSelected: (Company? suggestion){
            if (suggestion != null) {
              towercodeclass.text = suggestion.towerId?? '';
              location.text= suggestion.towerId?? '';
              towerId.add(int.parse(suggestion.towerId!));
              getCompanyList(suggestion.towerId!);
            }
          },
        ),

    );
  }
}


// Company
List<Company> CompanyData= [];

Future<void> getCompanyList(String towerNo) async{
  CompanyData.clear();
  String url= "http://111.223.92.154:8091/acp_api/companyManagement.php?tower_id=$towerNo";
  String completeurl= url;

  HttpOverrides.global = MyHttpOverrides();

  var response = await http.get(
    Uri.parse(completeurl),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded'
    },
  );

  if(response.statusCode==200){
    var jsonresponse= jsonDecode(response.body);
    for(var item in jsonresponse){
      final company= Company.fromJson(item);
      CompanyData.add(company);
    }
  }

}

class Allcompany extends StatefulWidget {
  final TextEditingController controller1;
  final String hint;
  const Allcompany(
      {Key? key,
        required this.controller1,
        required this.hint,
      })
      : super(key: key);

  @override
  State<Allcompany> createState() => _AllcompanyState();
}

class _AllcompanyState extends State<Allcompany> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: TypeAheadField<Company?>(
          hideWithKeyboard: true,
          controller:widget.controller1,
          builder: (context, controller, focusNode) {
            return TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a company';
                }
                return null;
              },
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
              if (location.text.isNotEmpty) {
                print("Tower: $tower");
                List<Company> filteredCompanies = CompanyData
                    .where((company) =>
                    company.companyName!.toLowerCase().contains(pattern.toLowerCase()))
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
              title: Text(companyLists.companyName ?? '', style: GoogleFonts.poppins(
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
          onSelected: (Company? suggestion){
            if (suggestion != null) {
              widget.controller1.text = suggestion.companyName?? '';
              unitno.text= suggestion.unitNos?? '';
              company_id= suggestion.companyId!;
            }
            // contractidController.text= suggestion?.contract_type_id ?? '';
            // contract_id= contractidController.text;
            // print("contract_id= $contract_id");
          },
        ),

    );
  }
}




// Company for company screen

// Company
List<Company> allCompanyData= [];

Future<void> getAllCompany() async{
  allCompanyData.clear();
  String url= "http://111.223.92.154:8091/acp_api/companyManagement.php";
  String completeurl= url;

  HttpOverrides.global = MyHttpOverrides();

  var response = await http.get(
    Uri.parse(completeurl),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded'
    },
  );

  if(response.statusCode==200){
    var jsonresponse= jsonDecode(response.body);
    for(var item in jsonresponse){
      final company= Company.fromJson(item);
      allCompanyData.add(company);
    }
  }

}

late String TextCompanyId;
List<int> companyID= [];

class Allcompany1 extends StatefulWidget {
  final TextEditingController controller1;
  final String hint;
  const Allcompany1(
      {Key? key,
        required this.controller1,
        required this.hint,
      })
      : super(key: key);

  @override
  State<Allcompany1> createState() => _Allcompany1State();
}

class _Allcompany1State extends State<Allcompany1> {
  @override
  Widget build(BuildContext context) {
    getAllCompany();
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: TypeAheadField<Company?>(
        hideWithKeyboard: true,
        controller:widget.controller1,
        builder: (context, controller, focusNode) {
          return TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a company';
                }
                return null;
              },
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
              .where((company) => company.companyName!.toLowerCase().contains(pattern.toLowerCase()))
              .toList();
        },
        itemBuilder: (context, Company? suggestion) {
          final companyLists = suggestion!;
          return ListTile(
            title: Text(companyLists.companyName ?? '', style: GoogleFonts.poppins(
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
        onSelected: (Company? suggestion) {
          if (suggestion != null) {
            widget.controller1.text = suggestion.companyName?? '';
            TextCompanyId= suggestion.companyId!;
            companyID.add(int.parse(suggestion.companyId!));
            isSearch= true;
            isSearchStaff= true;
            unitno.text= suggestion.unitNos?? '';
            company_id= suggestion.companyId!.toString();
          }
        },
      ),
    );
  }
}

