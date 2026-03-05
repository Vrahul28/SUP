import 'dart:convert';
import 'dart:io';
import 'package:acp/Provider/visitor_details_report_provider/visitor_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../company/companymethods.dart';

class VisitorDetailsReportProvider extends ChangeNotifier{
  List<VisitorDetailModel> visitorList= [];

  TextEditingController companyName= TextEditingController();
  TextEditingController selectSource= TextEditingController();
  TextEditingController systemName= TextEditingController();
  TextEditingController visitorName= TextEditingController();
  TextEditingController dateTimeRange= TextEditingController();
  TextEditingController selectType= TextEditingController();

  void clearController(){
    companyName.clear();
    selectSource.clear();
    systemName.clear();
    visitorName.clear();
    dateTimeRange.clear();
    selectType.clear();
    selectSource.clear();
  }

  Future<bool> getVisitorDetailList(
      String dbSource,
      String companyName,
      String visitorName,
      String systemName,
      String dateTimeRange,
      String reportType,
      ) async {

    String url = "http://111.223.92.154:8091/report_api/vmsVisitorDetailsReport.php";

    HttpOverrides.global = MyHttpOverrides();

    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Convert comma separated text into list
    List<String> sources = dbSource.split(',').map((e) => e.trim()).toList();

    // ========= SEND MULTIPLE ARRAY FIELDS =========
    for (var s in sources) {
      request.fields['db_source[]'] = s;
    }

    // **** ADD FIELDS AS FORM-DATA ****
    request.fields['company'] = companyName;
    request.fields['visitor_name'] = visitorName;
    request.fields['device_name'] = systemName;
    request.fields['dateTimeRange'] = dateTimeRange;
    request.fields['report_type[]'] = reportType;

    debugPrint("Sending sources: $sources");


    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        visitorList.clear();
        var jsonResponse = jsonDecode(response.body);
        debugPrint(response.body);
        for (var item in jsonResponse) {
          visitorList.add(VisitorDetailModel.fromJson(item));
        }
        notifyListeners();
        return true;
      } else {
        debugPrint("Error: ${response.body}");
        return false;
      }

    } catch (e) {
      debugPrint("Exception: $e");
      return false;
    }
  }
}