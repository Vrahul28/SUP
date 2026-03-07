import 'dart:convert';
import 'dart:io';
import 'package:acp/login/userPreference.dart';
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

  TextEditingController activeDate= TextEditingController();
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
  String staffNumber= '';
  String imagePathForFR= '';

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
    view =false;
    imgString = '';
    imageFile = null;
    image = null;
    image1 = false;

    isQR = false;
    isFR = false;
    isConsent = false;
    notifyListeners();
  }

  void checkEmail() async{
    emailExit = await db.isEmailExists(corporateEmail.text);
  }

  void setFR(bool value) {
    isFR = value;
    notifyListeners();
  }

  void setQR(bool value) {
    isQR = value;
    notifyListeners();
  }

  void setConsent(bool value) {
    isConsent = value;
    notifyListeners();
  }

  //Insert Staff
  Future<bool> addStaff(
      String firstname,
      String lastname,
      String nric,
      String corporateEmail,
      String staff_phone,
      String jobPosition,
      String tower,
      String unit_no,
      String activation_date,
      String expiryDate,
      String enrollQR,
      String enrollFR,
      String consent,
      String company,
      String companyIDForADD,
      ) async {

    String url = "http://111.223.92.154:85/restApplicationUser/restStaff/staff/addoreditstaff";
    UserPreference pref = UserPreference();
    HttpOverrides.global = MyHttpOverrides();

    try {

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        "Accept": "application/json",
      });

      request.fields.addAll({
        "firstName": firstname,
        "lastName": lastname,
        "staffEmail": corporateEmail,
        "nricNumber": nric,
        "corporateEmail": corporateEmail,
        "staffPhone": staff_phone,
        "staffJobPosition": jobPosition,
        "tower": tower,
        "unitNO": unit_no,
        "activationDate": activation_date,
        "expirationDate": expiryDate,
        "enrollFR": enrollFR,
        "enrollQR": enrollQR,
        "consentToTC": consent,
        "companyId": companyIDForADD,
        "company": company,
        "createdBy": await pref.getUserId(),
        "isP1Upload": "false",
        "isFrUpload": "false",
        "isSuntecApiUpload": "false",
        "uploadReason": "",
        "remarks": "",
        "imageName": "",
        "frImageName": "",
        "cardNumber": await getCardNumber(),
        "staffNumber": await getStaffNumber(),
      });

      // 👇 Send Base64 string as field
      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',                // field name expected by API
            image!.path,
          ),
        );

        debugPrint("Uploading Image: ${image!.path}");
      }
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      debugPrint(response.statusCode.toString());
      debugPrint(response.body);

      if (response.statusCode == 201) {
        var responseBody = jsonDecode(response.body);
        debugPrint(responseBody['responseMessage']);

        await uploadFiles();
        await uploadDataToFRTabletByTower(tower, '$firstname $lastname');
        return true;
      }

      return false;

    } catch (e) {
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

      imageFile = pickedImage;              // XFile
      image = File(pickedImage.path);

      // final pickedFile = File(pickedImage.path);
      var decodedImage = await decodeImageFromList(image!.readAsBytesSync());
      debugPrint(decodedImage.width.toString());
      debugPrint(decodedImage.height.toString());
      debugPrint(getFileSizeString(file: image!));

      if (image!.lengthSync() > 200 * 1024) {
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
      // imageFile = pickedImage;
      // imgString = base64Encode(pickedFile.readAsBytesSync());

      debugPrint("Image Path: ${image!.path}");

      // printFullBase64(imgString);
      notifyListeners();
      // await saveImage(await pickedFile.readAsBytes());

    } catch (e) {
      // Handle any exception that might occur during image picking
      debugPrint('Failed to pick image: $e');
    }
  }

  Future<String?> saveImage(Uint8List bytes) async {
    await Permission.storage.request();
    final result = await ImageGallerySaverPlus.saveImage(bytes);
    if (result != null && result['filepath'] != null) {
      return result['filepath'].toString();
    }
    return null;
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
  Future<bool> uploadFiles() async {
    String url = "http://111.223.92.154:5000/api/FRTablet/UploadFiles";
    HttpOverrides.global = MyHttpOverrides();

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );

      request.headers.addAll({
        "Accept": "application/json",
      });

      // Add image file
      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            "files",           // field name expected by API
            image!.path,
          ),
        );

        debugPrint("Uploading Image: ${image!.path}");
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        debugPrint(responseBody['message']);
        debugPrint(responseBody['resultData']);
        imagePathForFR= responseBody['resultData'];
        notifyListeners();
        return true;
      }

      return false;

    } catch (e) {
      debugPrint("Upload Error: $e");
      return false;
    }
  }


  //Get Card Number
  Future<String> getCardNumber() async{
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
      return cardNumber;
    }catch(e){
      debugPrint(e.toString());
    }
    notifyListeners();
    return "";
  }

  //Get Staff Number
  Future<String> getStaffNumber() async{
    String url= "http://111.223.92.154:85/restApplicationUser/restStaff/staff/uniquestaffnumber";
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
      staffNumber= jsonResponse;
      debugPrint(staffNumber);
      return staffNumber;
    }catch(e){
      debugPrint(e.toString());
    }
    notifyListeners();
    return "";
  }


  //Get Unit Number
  Future<String> getUnitNo(String company, String tower) async{
    String url= "http://111.223.92.154:85/restApplicationUser/restCompany/company/getUnitFromCompanyAndTower?company=$company&tower=$tower";
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
      return jsonResponse;
    }catch(e){
      debugPrint(e.toString());
    }
    notifyListeners();
    return "";
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
      "cardNumber": cardNumber
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

  String generateAlphaNumeric() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();

    return List.generate(
      10,
          (index) => chars[random.nextInt(chars.length)],
    ).join();
  }

  //Upload Data to FR Tablet
  Future<bool> uploadDataToFRTabletByTower(String tower, String name) async{
    String url= "http://111.223.92.154:5000/api/FRTablet/uploadDataToFRTableByTower";
    String completeUrl= url;

    HttpOverrides.global = MyHttpOverrides();

    Map<String, String> body = {
      "tower": tower,
      "imagePath": imagePathForFR,
      "documnetNumber": generateAlphaNumeric(),
      "name": name,
      "cardNumber": cardNumber
    };

    debugPrint(body.toString());

    // Conditionally add enrollFR based on qr value
    var response = await http.post(
        Uri.parse(completeUrl),
        headers: <String, String>{
          'Accept': 'application/json'
        },
        body: jsonEncode(body)
    );

    try{
      debugPrint("upload data to fr tablet tower Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

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