import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../company/companymethods.dart';
import '../../staff/database/dbhelper.dart';
import '../../utils/colors.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class InsertStaffProvider extends ChangeNotifier{

  TextEditingController firstName= TextEditingController();
  TextEditingController lastName= TextEditingController();
  TextEditingController nric= TextEditingController();
  TextEditingController corporateEmail= TextEditingController();
  TextEditingController contactNo= TextEditingController();
  TextEditingController jobPosition= TextEditingController();
  TextEditingController location= TextEditingController();
  TextEditingController addCompany= TextEditingController();
  TextEditingController unitNo= TextEditingController();
  TextEditingController cardNo= TextEditingController();
  TextEditingController activationDate= TextEditingController();
  TextEditingController expiryDate= TextEditingController();

  bool? emailExit;
  DBHelper db= DBHelper.db;
  bool isUpdate = false;
  bool isQR= false;
  bool isFR= false;
  bool isConsent= false;
  late String qr,fr,consent;
  bool view = false;
  bool image1 = false;
  String imgString= '';
  late String id;
  late String companyId;

  String cardNumber= '';

  //For Image Picker
  File? image;
  XFile? imageFile;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstName.dispose();
    lastName.dispose();
    nric.dispose();
    corporateEmail.dispose();
    contactNo.dispose();
    jobPosition.dispose();
    location.dispose();
    addCompany.dispose();
    unitNo.dispose();
    cardNo.dispose();
    activationDate.dispose();
    expiryDate.dispose();
  }

  void clearController(){
    firstName.clear();
    lastName.clear();
    nric.clear();
    corporateEmail.clear();
    contactNo.clear();
    jobPosition.clear();
    location.clear();
    addCompany.clear();
    unitNo.clear();
    cardNo.clear();
    activationDate.clear();
  }

  void checkEmail() async{
    emailExit = await db.isEmailExists(corporateEmail.text);
  }

  //Insert Staff
  Future<bool> addStaff(
      String firstname,
      lastname,
      nric,
      corporateemail,
      staff_phone,
      jobPosition,
      tower,
      unit_no,
      activation_date,
      enrollQR,
      enrollFR,
      consent,
      image
      ) async{
    String url= "http://111.223.92.154:8091/acp_api/staffManagement.php";
    String completeUrl= url;

    SharedPreferences pref= await SharedPreferences.getInstance();
    HttpOverrides.global = MyHttpOverrides();

    var response = await http.post(
        Uri.parse(completeUrl),
        headers: <String, String>{
          'Accept': 'application/json'
        },
        body: {
          "first_name": firstname,
          "last_name": lastname,
          "nric_number": nric,
          "corporate_email": corporateemail,
          "staff_phone": staff_phone,
          "staff_job_position": jobPosition,
          "tower_id": tower,
          "unit_number": unit_no,
          "activation_and_expiration_date": activation_date,
          "enroll_FR": enrollFR,
          "enroll_QR": enrollQR,
          "consent_to_terms_and_conditions": consent,
          "staff_email": corporateemail,
          "image_data": image,
          "company_id": pref.getString('company_id'),
          "full_name": pref.getString('full_name'),
          "user_id": pref.getString('userId'),
          "userRole":pref.getString('userRole'),
        }
    );

    try{
      if(response.statusCode==200){
        var responseBody= jsonDecode(response.body);
        debugPrint(responseBody['New card number generated']);
      }
      return true;
    }catch(e){
      debugPrint(e.toString());
      return false;
    }

  }

  //Pick Image
  void pickImage(ImageSource source,BuildContext context) async {
    try {
      final pickedImage = await ImagePicker().pickImage(
          source: source,
          imageQuality: 90,
          maxWidth: 1920,
          maxHeight: 1440
      );

      if (pickedImage == null) {
        debugPrint('image is null');
        return;
      }

      final pickedFile = File(pickedImage.path);
      var decodedImage = await decodeImageFromList(pickedFile.readAsBytesSync());
      debugPrint(decodedImage.width.toString());
      debugPrint(decodedImage.height.toString());
      debugPrint(getFileSizeString(file: pickedFile));

      if (pickedFile.lengthSync() > 200 * 1024) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.white,
            content: Text('Image size is too large. Choose a smaller image.' ,
              style: GoogleFonts.poppins(
              color: kDarkblueColor,
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
            )
            ),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }


      imageFile = pickedImage;

      imgString = base64Encode(await pickedFile.readAsBytesSync());
      debugPrint('imgstring: $imgString');
      await saveImage(await pickedFile.readAsBytes());

    } catch (e) {
      // Handle any exception that might occur during image picking
      debugPrint('Failed to pick image: $e');
    }
  }

  Future<String> saveImage(Uint8List bytes) async{
    await [Permission.storage].request();
    final result= await ImageGallerySaverPlus.saveImage(bytes);
    return result['filepath'];
  }


  String getFileSizeString({required File file, int decimals = 0}) {
    int bytes = file.lengthSync();
    if (bytes <= 0) return "0 Bytes";
    const suffixes = [" Bytes", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  //Edit Staff
  Future<bool> updateStaff(String id, String companyid, firstname, lastname, nric, corporateemail, staff_phone, jobPosition, tower, unit_no, activation_date, enrollQR, enrollFR, consent,image) async{
    String url= "http://111.223.92.154:8091/acp_api/staffManagement.php?id=$id";
    String completeUrl= url;

    SharedPreferences pref= await SharedPreferences.getInstance();
    HttpOverrides.global = MyHttpOverrides();

    Map<String, String> body = {
      "id": id,
      "first_name": firstname,
      "last_name": lastname,
      "nric_number": nric,
      "corporate_email": corporateemail,
      "staff_phone": staff_phone,
      "staff_job_position": jobPosition,
      "tower_id[0]": tower,
      "unit_number": unit_no,
      "activation_and_expiration_date": activation_date,
      "consent_to_terms_and_conditions": consent,
      "staff_email": corporateemail,
      "image_data": image,
      "company_id[0]": companyid,
      "full_name": pref.getString('full_name') ?? "",
      "user_id": pref.getString('userId') ?? "",
      "userRole": pref.getString('userRole') ?? "",
    };

    // Conditionally add enrollFR based on qr value
    if (enrollQR == "1") {
      body["enroll_qr"] = enrollQR;
    }

    if (enrollFR == "1") {
      body["enroll_fr"] = enrollFR;
    }

    var response = await http.post(
        Uri.parse(completeUrl),
        headers: <String, String>{
          'Accept': 'application/json'
        },
        body: body
    );

    try{
      if(response.statusCode==200){
        var responseBody= jsonDecode(response.body);
        debugPrint(responseBody['message']);
        notifyListeners();
      }
      return true;
    }catch(e){
      debugPrint(e.toString());
      return false;
    }
  }

  //Upload Data to FR Tablet
  Future<bool> uploadFiles(String imageString) async{
    String url= "http://111.223.92.154:5000/api/FRTablet/UploadFiles";
    String completeUrl= url;

    HttpOverrides.global = MyHttpOverrides();

    Map<String, String> body = {
      "files": imageString,
    };

    // Conditionally add enrollFR based on qr value
    var response = await http.post(
        Uri.parse(completeUrl),
        headers: <String, String>{
          'Accept': 'application/json'
        },
        body: body
    );

    try{
      if(response.statusCode==200){
        var responseBody= jsonDecode(response.body);
        debugPrint(responseBody['message']);
        notifyListeners();
      }
      return true;
    }catch(e){
      debugPrint(e.toString());
      return false;
    }
  }


  //Get Card Number
  Future<void> getAllStaffList(String? query, String? query2) async{

    String url= "http://111.223.92.154:85/restApplicationUser/restCard/cardConfig/getUniqueStaffCardNumber";
    String completeUrl= url;

    HttpOverrides.global = MyHttpOverrides();

    var response = await http.get(
      Uri.parse(completeUrl),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    try{
      var jsonResponse= jsonDecode(response.body);
      cardNumber= jsonResponse;
      debugPrint(cardNumber);
    }catch(e){
      debugPrint(e.toString());
    }
    notifyListeners();
  }


  //Upload Data to FR Tablet
  Future<bool> uploadDataToFRTablet(String imageString) async{
    String url= "http://111.223.92.154:5000/api/FRTablet/UploadDataToFRTablet";
    String completeUrl= url;

    HttpOverrides.global = MyHttpOverrides();

    Map<String, String> body = {
      "deviceIp": "10.121.76.12",
      "devicePort": "2604",
      "deviceUserName": "string",
      "devciePassword": "string",
      "imagePath": "string",
      "documnetNumber": "string",
      "name": "string",
      "cardNumber": "string"
    };

    // Conditionally add enrollFR based on qr value
    var response = await http.post(
        Uri.parse(completeUrl),
        headers: <String, String>{
          'Accept': 'application/json'
        },
        body: body
    );

    try{
      if(response.statusCode==200){
        var responseBody= jsonDecode(response.body);
        debugPrint(responseBody['message']);
        notifyListeners();
      }
      return true;
    }catch(e){
      debugPrint(e.toString());
      return false;
    }
  }

  //Upload Data to FR Tablet
  Future<bool> uploadDataToFRTabletByTower(String imageString) async{
    String url= "http://111.223.92.154:5000/api/FRTablet/uploadDataToFRTableByTower";
    String completeUrl= url;

    HttpOverrides.global = MyHttpOverrides();

    Map<String, String> body = {
      "tower": "string",
      "imagePath": "string",
      "documnetNumber": "string",
      "name": "string",
      "cardNumber": "string"
    };

    // Conditionally add enrollFR based on qr value
    var response = await http.post(
        Uri.parse(completeUrl),
        headers: <String, String>{
          'Accept': 'application/json'
        },
        body: body
    );

    try{
      if(response.statusCode==200){
        var responseBody= jsonDecode(response.body);
        debugPrint(responseBody['message']);
        notifyListeners();
      }
      return true;
    }catch(e){
      debugPrint(e.toString());
      return false;
    }
  }
}