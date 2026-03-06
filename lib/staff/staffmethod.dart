import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:acp/staff/staffmodel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../Provider/Staff/Staff_Provider.dart';
import '../appDashboard/dashboard/dashboard.dart';
import '../company/companymethods.dart';
import '../company/companymodel.dart';
import '../utils/colors.dart';


List<Staff> allStaffData= [];
// Future<void> getStaff(String? query, String? query2) async{
//
//   String url= "https://access.apm.sg/restApplicationUser/restStaff/staff/filterStaff";
//   String completeUrl= url;
//   Map<String, dynamic> jsonData= {};
//   if(usernameController.text== "ara@gmail.com" || usernameController.text== "lim@gmail.com"){
//     if(company.text.isEmpty){
//       jsonData = {
//         "tower": [],
//         "company": ["11"],
//         "staffName": query2,
//         "staffId": "",
//         "pageNo": "",
//         "pageSize": 10,
//         "userId": "1700"
//       };
//     }else if(company.text.isNotEmpty){
//       jsonData = {
//         "tower": [],
//         "company": ["$query"],
//         "staffName": query2,
//         "staffId": "",
//         "pageNo": "",
//         "pageSize": 10,
//         "userId": "1700"
//       };
//     }
//     company.text= "ARA Management Pte Ltd";
//     addcompany.text= "ARA Management Pte Ltd";
//   }else{
//     if(company.text.isEmpty){
//       jsonData = {
//         "tower": [],
//         "company": [],
//         "staffName": query2,
//         "staffId": "",
//         "pageNo": "",
//         "pageSize": 10,
//         "userId": "1700"
//       };
//     }else if(company.text.isNotEmpty){
//       jsonData = {
//         "tower": [],
//         "company": ["$query"],
//         "staffName": query2,
//         "staffId": "",
//         "pageNo": "",
//         "pageSize": 10,
//         "userId": "1700"
//       };
//     }
//   }
//
//
//   String jsonString = jsonEncode(jsonData);
//   debubPrint(jsonString);
//
//   var response = await http.post(
//     Uri.parse(completeUrl),
//     encoding: Encoding.getByName('utf-8'),
//     body: jsonString,
//     headers: <String, String>{
//       'Content-Type': 'application/json'
//     },
//   );
//
//   if(response.statusCode==200){
//     allstaffdata.clear();
//     var jsonresponse= jsonDecode(response.body);
//     // debubPrint(jsonresponse);
//     for(var item in jsonresponse){
//       final staff= Staff.fromJson(item);
//       allstaffdata.add(staff);
//
//     }
//
//
//     // if (company.text.isNotEmpty && query != null) {
//     //   Set<Staff> uniqueStaff = Set<Staff>();
//     //
//     //   for (var item in jsonresponse) {
//     //     final staff = Staff.fromJson(item);
//     //
//     //     if (staff.company!.toLowerCase().contains(query.toLowerCase())) {
//     //       uniqueStaff.add(staff);
//     //     }
//     //   }
//     //
//     //   allstaffdata.clear();
//     //   allstaffdata.addAll(uniqueStaff.toList());
//     //
//     //   debubPrint(allstaffdata.length);
//     // }
//
//     // if(company.text.isNotEmpty){
//     //   if(query!=null){
//     //     allstaffdata =  allstaffdata
//     //         .where((code) =>
//     //     code.company?.toLowerCase().contains(query.toLowerCase()) ??
//     //         false)
//     //         .toList();
//     //   }
//     // }
//
//     // if (staffcodeclass.text.isNotEmpty && query2!=null) {
//     //   Set<Staff> uniqueStaff1 = Set<Staff>();
//     //
//     //   for (var item in jsonresponse) {
//     //     final staff = Staff.fromJson(item);
//     //
//     //     if (staff.firstName!.toLowerCase().contains(query2.toLowerCase())) {
//     //       uniqueStaff1.add(staff);
//     //     }
//     //   }
//     //
//     //   allstaffdata.clear();
//     //   allstaffdata.addAll(uniqueStaff1.toList());
//     //
//     //   debubPrint(allstaffdata.length);
//     // }
//
//     // if(staffcodeclass.text.isNotEmpty){
//     //   if(query2!=null){
//     //     allstaffdata =  allstaffdata
//     //         .where((code) =>
//     //     code.firstName?.toLowerCase().contains(query2.toLowerCase()) ??
//     //         false)
//     //         .toList();
//     //   }
//     // }
//     var count= allstaffdata.length;
//     totalstaff1.text= count.toString();
//   }
//
// }

Future<File> saveImagepermanently(String imagepath) async{
  final directory= await getApplicationDocumentsDirectory();
  final name= basename(imagepath);
  final image= File('${directory.path}/$name');
  return File(imagepath).copy(image.path);

}



// Total count of staff
List<FlSpot> spots = [];

Future<void> getTotalStaff(BuildContext context) async{

  final staff= context.read<StaffProvider>();
  String url= "https://access.apm.sg/restApplicationUser/restStaff/staff/staffCount";
  String completeUrl= url;

  HttpOverrides.global = MyHttpOverrides();


    DateTime currentDate = DateTime.now();

    Map<String, dynamic> jsonData = {
      "userId":"1700",
      "date": currentDate.toIso8601String(),
    };

    String jsonString = jsonEncode(jsonData);

    var response = await http.post(
      Uri.parse(completeUrl),
      encoding: Encoding.getByName('utf-8'),
      body: jsonString,
      headers: <String, String>{
        'Content-Type': 'application/json'
      },
    );

    if(response.statusCode==200){
      spots.clear();
      var jsonResponse= jsonDecode(response.body);
      staff.totalStaff.text= jsonResponse.toString();
      // double data = double.parse(jsonresponse.toString());
      // String formattedDate = DateFormat('dd/MM').format(currentDate);
      // spots.add(FlSpot( currentDate.millisecondsSinceEpoch.toDouble() , data));
      //
      // debubPrint(FlSpot(currentDate.millisecondsSinceEpoch.toDouble(), data));
    }
}


// Company

class CompanyList extends StatefulWidget {
  final TextEditingController controller1;
  final String hint;

  const CompanyList({
    super.key,
    required this.controller1,
    required this.hint,
  });

  @override
  State<CompanyList> createState() => _CompanyListState();
}

class _CompanyListState extends State<CompanyList> {
  @override
  Widget build(BuildContext context) {
    final staff= context.read<StaffProvider>();
    getCompany(company11, staff11, unit11,context);
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: TypeAheadField<Company?>(
          hideWithKeyboard: true,
        controller: widget.controller1,
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
              controller: widget.controller1,
              decoration: InputDecoration(
                filled: true,
                fillColor:  kGinColor,
                prefixIcon: Icon(
                  Icons.home_work_outlined,
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
            return  allcompanydata1.
            where((companylist) =>
            (companylist.company?.toLowerCase().contains(pattern.toLowerCase()) ?? false)
            ).toList();
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
                    fontSize: 20.0,
                  )
              ),
            ),
          ),
          onSelected: (Company? suggestion){
            var Companyid;
            if (suggestion != null) {
              Companyid = suggestion.companyID?? '';
              debugPrint(Companyid.toString());
              staff.companyId.text = Companyid.toString();
              widget.controller1.text = suggestion.company?? '';
            }
            // contractidController.text= suggestion?.contract_type_id ?? '';
            // contract_id= contractidController.text;
            // debubPrint("contract_id= $contract_id");
          },
        ),

    );
  }
}


