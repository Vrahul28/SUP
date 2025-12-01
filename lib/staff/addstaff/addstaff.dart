import 'dart:convert';
import 'dart:math';

import 'package:acp/Provider/Staff/Edit_Staff_Provider.dart';
import 'package:acp/Provider/Staff/Insert_Staff_Provider.dart';
import 'package:acp/staff/addstaff/addstaffmethods.dart';
import 'package:acp/staff/database/dbhelper.dart';
import 'package:acp/staff/terms&conditiondialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';

import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../company/companymethods.dart';
import '../../utils/Textform_field.dart';
import '../../utils/colors.dart';
import '../staffscreen.dart';
import 'imageguidlines.dart';

class Addstaff extends StatefulWidget {
  const Addstaff({super.key});

  @override
  State<Addstaff> createState() => _AddstaffState();
}

late String id;
TextEditingController firstname= TextEditingController();
TextEditingController lastname= TextEditingController();
TextEditingController nric= TextEditingController();
TextEditingController corporateemail= TextEditingController();
TextEditingController contactnumer= TextEditingController();
TextEditingController jobposition= TextEditingController();
TextEditingController location= TextEditingController();
TextEditingController addcompany= TextEditingController();
TextEditingController unitno= TextEditingController();
TextEditingController cardno= TextEditingController();
TextEditingController activationdate= TextEditingController();
TextEditingController expirydate= TextEditingController();

bool isupdate = false;
bool isQR= false;
bool isFR= false;
bool isConsent= false;
late String qr,fr,consent;
bool view = false;
bool image = false;
String imgString= '';

class _AddstaffState extends State<Addstaff> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool? emailexit;
  File? image;
  XFile? _imageFile;
  DBhelper db= DBhelper.db;

  void checkemail() async{
    emailexit = await db.isEmailExists(corporateemail.text);
  }

  @override
  Widget build(BuildContext context) {
    final insertStaffProvider= Provider.of<InsertStaffProvider>(context, listen: false);
    final editStaffProvider= Provider.of<EditStaffProvider>(context, listen: false);
    return Material(
      child: Scaffold(
        body: Form(
          key: this._formKey,
          child: CustomScrollView(
            slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: kDarkblueColor,
                  title: view?Text("Staff",
                    style: GoogleFonts.poppins(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ):Text("Add Staff",
                    style: GoogleFonts.poppins(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      view =false;
                      imgString= "";
                      isQR= false;
                      isFR= false;
                      isConsent= false;

                      firstname.clear();
                      lastname.clear();
                      nric.clear();
                      corporateemail.clear();
                      contactnumer.clear();
                      jobposition.clear();
                      location.clear();
                      addcompany.clear();
                      unitno.clear();
                      cardno.clear();
                      activationdate.clear();
                      setState(() {

                      });
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => const Staffscreen(),
                        ),
                      );

                    },
                  ),
                ),
              SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(
                        height: 10,
                      ),
                     Visibility(
                       visible: isFR,
                       child: Column(
                            children: [
                              Stack(
                                children: [
                                    CircleAvatar(
                                      radius: 70.0,
                                      backgroundImage: (_imageFile == null && image == false)
                                          ? AssetImage("assets/images/profile.png")
                                          : (_imageFile != null)
                                          ? FileImage(File(_imageFile!.path))
                                          : (imgString.isNotEmpty)
                                          ? MemoryImage(base64Decode(imgString))
                                          : AssetImage("assets/images/profile.png") as ImageProvider<Object>?,
                                    ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: InkWell(
                                      onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: ((builder) => bottomSheet()),
                                          );
                                      },
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration:
                                        BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
                                        child: const Icon(LineAwesomeIcons.camera_solid, color: Colors.black, size: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                             const SizedBox(
                                height: 5,
                              ),
                              RichText(
                                  text: TextSpan(
                                    text: "Image Guidlines",
                                    style: GoogleFonts.poppins(
                                      color: kDarkblueColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Imageguid(
                                              mdFileName: 'Imageguidlines.md',
                                            );
                                          },
                                        );
                                      },
                                  ),
                                ),
                            ],
                          ),
                     ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                            child: CustomTextfield(
                              Icons: Icons.person,
                              obsuretext: false,
                              lines: 1,
                              errorMsg: 'Staff first name requried.',
                              hinttext: 'First Name',
                              controller: firstname,
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                            child: CustomTextfield(
                              Icons: Icons.person,
                              obsuretext: false,
                              lines: 1,
                              errorMsg: '',
                              hinttext: 'Last Name',
                              controller: lastname,
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                            child: CustomTextfield(
                              Icons: LineAwesomeIcons.passport_solid,
                              obsuretext: false,
                              lines: 1,
                              errorMsg: '',
                              hinttext: 'Last 4 digit of NRIC',
                              controller: nric,
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                            child: TextFormField(
                              cursorColor: kDarkblueColor,
                              style: GoogleFonts.poppins(
                                color: kDarkblueColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0,
                              ),
                              validator: (value) {
                                if(value == null || value.isEmpty || !value.contains('@') || !value.contains('.')){
                                  return 'Invalid Email';
                                }else if(emailexit == true){
                                  return 'Email already exist';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  checkemail();
                                });
                              },
                              controller: corporateemail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(18.0),
                                filled: true,
                                fillColor:  kGinColor,
                                prefixIcon: Icon(
                                  Icons.mail,
                                  size: 24.0,
                                  color: kDarkblueColor,
                                ),
                                hintText: 'Coorporate Email',
                                // labelText: 'Search',
                                hintStyle: GoogleFonts.poppins(
                                  color: kDarkblueColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: kGinColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: kDarkblueColor),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                            child: CustomTextfield(
                              Icons: LineAwesomeIcons.phone_alt_solid,
                              obsuretext: false,
                              lines: 1,
                              errorMsg: 'Staff Contact Number requried.',
                              hinttext: 'Contact Number',
                              controller: contactnumer,
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                            child: CustomTextfield(
                              Icons: Icons.shopping_bag,
                              obsuretext: false,
                              lines: 1,
                              errorMsg: '',
                              hinttext: 'Job Position',
                              controller: jobposition,
                            )
                          ),
                          Tower(controller1: location),
                          Allcompany(controller1: addcompany, hint: "Company",),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                            child: CustomTextfield(
                              Icons: LineAwesomeIcons.hashtag_solid,
                              obsuretext: false,
                              lines: 1,
                              errorMsg: 'Unit No. requried.',
                              hinttext: 'Unit No',
                              controller: unitno,
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                            child: CustomTextfield(
                              Icons: Icons.credit_card,
                              obsuretext: false,
                              lines: 1,
                              errorMsg: 'Card No. requried.',
                              hinttext: 'Card No',
                              controller: cardno,
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                            child: TextFormField(
                              cursorColor: kDarkblueColor,
                              style: GoogleFonts.poppins(
                                color: kDarkblueColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0,
                              ),
                              keyboardType: TextInputType.datetime,
                              controller: activationdate,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(18.0),
                                filled: true,
                                fillColor:  kGinColor,
                                prefixIcon: IconButton(
                                  icon: Icon(Icons.calendar_month,size: 24.0,color: kDarkblueColor),
                                  onPressed: () {
                                    dateRange(context, activationdate);
                                  },
                                ),
                                hintText: 'Activation & Expiration Date',
                                // labelText: 'Search',
                                hintStyle: GoogleFonts.poppins(
                                  color: kDarkblueColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: kGinColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: kDarkblueColor),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                            child: Row(
                              children: [
                                CupertinoSwitch(
                                  trackColor: Colors.white,
                                  activeColor: kDarkblueColor,
                                  value: isQR ,
                                  onChanged: (bool value) {
                                    setState(() {
                                      isQR = value;
                                      print("QR Code: $isQR");
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    "I want to use Suntec QR Code Mobile Application",
                                    style: GoogleFonts.poppins(
                                      color: kDarkblueColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.0,
                                    ),
                                    maxLines: 3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 0.0),
                            child: Row(
                              children: [
                                CupertinoSwitch(
                                  trackColor: Colors.white,
                                  activeColor: kDarkblueColor,
                                  value: isFR ,
                                  onChanged: (bool value) {
                                    setState(() {
                                      isFR = value;
                                      print("Enable FR: $isFR");
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    "Enroll FR (Facial Access)",
                                    style: GoogleFonts.poppins(
                                      color: kDarkblueColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.0,
                                    ),
                                    maxLines: 3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!isFR)
                             const Row(
                               children: [
                                 SizedBox(
                                   width: 78,
                                 ),
                                 Expanded(
                                   child: Text(
                                      '* Please enable this option to upload photo.',
                                      style: TextStyle(
                                        color: Colors.red, // Choose your desired color
                                      ),
                                     maxLines: 3,
                                    ),
                                 ),
                               ],
                             ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                            child: Row(
                              children: [
                                CupertinoSwitch(
                                  trackColor: Colors.white,
                                  activeColor: kDarkblueColor,
                                  value: isConsent,
                                  onChanged: (bool value) {
                                    setState(() {
                                      isConsent = value;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      text: "I consent to the Building's Terms and Conditions ",
                                      style: GoogleFonts.poppins(
                                        color: kDarkblueColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.0,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return termsconditiondialogbox(
                                                mdFileName: 'Terms&Condition.md',
                                              );
                                            },
                                          );
                                        },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if(view == false)
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                              child: SizedBox(
                                width: double.infinity,
                                height: (MediaQuery.of(context).size.height*0.07),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if(_formKey.currentState!.validate()){
                                      if(isQR== false && isFR== true && isConsent== true || isQR== true && isFR== true && isConsent== true || isQR== true && isFR== false && isConsent== true){
                                        print('done');
                                        // Create
                                        if(isupdate== false && view== false){
                                          print('done1');
                                            if(isFR==true && isQR==true && imgString.isNotEmpty){
                                              qr = (isQR ? "1":null)!;
                                              fr = (isFR ? "1": null)!;
                                              consent = (isConsent ? "1":null)!;

                                              bool succedd= await insertStaffProvider.addStaff(firstname.text, lastname.text, nric.text, corporateemail.text, contactnumer.text, jobposition.text, location.text, unitno.text, activationdate.text, qr, fr, consent, imgString);
                                              if(succedd){
                                                Fluttertoast.showToast(msg: "Data Inserted successfully", textColor: kDarkblueColor,fontSize: 12.0);
                                                Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => const Staffscreen(),
                                                  ),
                                                );
                                                imgString= "";
                                                isQR= false;
                                                isFR= false;
                                                isConsent= false;

                                                firstname.clear();
                                                lastname.clear();
                                                nric.clear();
                                                corporateemail.clear();
                                                contactnumer.clear();
                                                jobposition.clear();
                                                location.clear();
                                                addcompany.clear();
                                                unitno.clear();
                                                cardno.clear();
                                                activationdate.clear();
                                              }

                                            }else if(isFR==false && isQR==true && imgString.isEmpty){
                                              qr = (isQR ? "1":null)!;
                                              fr = (isFR ? "1": null)!;
                                              consent = (isConsent ? "1":null)!;
                                              print("isQR in insert: $qr");
                                              bool succedd= await insertStaffProvider.addStaff(firstname.text, lastname.text, nric.text, corporateemail.text, contactnumer.text, jobposition.text, location.text, unitno.text, activationdate.text, qr, fr, consent, imgString);
                                              if(succedd){
                                                Fluttertoast.showToast(msg: "Data Inserted successfully", textColor: kDarkblueColor,fontSize: 12.0);
                                                Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => const Staffscreen(),
                                                  ),
                                                );

                                                imgString= "";
                                                isQR= false;
                                                isFR= false;
                                                isConsent= false;

                                                firstname.clear();
                                                lastname.clear();
                                                nric.clear();
                                                corporateemail.clear();
                                                contactnumer.clear();
                                                jobposition.clear();
                                                location.clear();
                                                addcompany.clear();
                                                unitno.clear();
                                                cardno.clear();
                                                activationdate.clear();
                                              }
                                            } else if(isQR && isFR){
                                              Fluttertoast.showToast(msg: "Please enable one either QR code or Enable FR");
                                            }else{
                                              Fluttertoast.showToast(msg: "Please Set Profile image");
                                            }

                                        }
                                        // Update
                                        else if(isupdate== true && view== false){
                                            if(isFR==false){
                                              print("Update");
                                              imgString= "";
                                              qr = isQR ? "1":"0";
                                              fr = isFR ? "1":"0";
                                              consent = isConsent ? "1":"0";

                                              bool update= await editStaffProvider.updateStaff(id, company_id,firstname.text, lastname.text, nric.text, corporateemail.text, contactnumer.text, jobposition.text, location.text, unitno.text, activationdate.text, qr, fr, consent, imgString);
                                              if(update){
                                                Fluttertoast.showToast(msg: "Data updated successfully", textColor: kDarkblueColor, fontSize: 12.0,backgroundColor: Colors.white);
                                                Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => const Staffscreen(),
                                                  ),
                                                );
                                                imgString= "";
                                                isQR= false;
                                                isFR= false;
                                                isConsent= false;

                                                firstname.clear();
                                                lastname.clear();
                                                nric.clear();
                                                corporateemail.clear();
                                                contactnumer.clear();
                                                jobposition.clear();
                                                location.clear();
                                                addcompany.clear();
                                                unitno.clear();
                                                cardno.clear();
                                                activationdate.clear();
                                              }

                                            }else  if(isFR==true && imgString.isNotEmpty){
                                              qr = isQR ? "1":"0";
                                              fr = isFR ? "1":"0";
                                              consent = isConsent ? "1":"0";

                                              bool update= await editStaffProvider.updateStaff(id, company_id,firstname.text, lastname.text, nric.text, corporateemail.text, contactnumer.text, jobposition.text, location.text, unitno.text, activationdate.text, qr, fr, consent, imgString);
                                              if(update){
                                                Fluttertoast.showToast(msg: "Data updated successfully", textColor: kDarkblueColor, fontSize: 12.0,backgroundColor: Colors.white);
                                                Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => const Staffscreen(),
                                                  ),
                                                );

                                                imgString= "";
                                                isQR= false;
                                                isFR= false;
                                                isConsent= false;

                                                firstname.clear();
                                                lastname.clear();
                                                nric.clear();
                                                corporateemail.clear();
                                                contactnumer.clear();
                                                jobposition.clear();
                                                location.clear();
                                                addcompany.clear();
                                                unitno.clear();
                                                cardno.clear();
                                                activationdate.clear();
                                              }

                                            }else{
                                              Fluttertoast.showToast(msg: "Please set profile image");
                                            }
                                        }
                                      }else if(isConsent== false){
                                        Fluttertoast.showToast(msg: "Accept terms and condtions", textColor: kDarkblueColor, fontSize: 12.0,backgroundColor: Colors.white);
                                      }else if(isQR== false && isFR== false){
                                        Fluttertoast.showToast(msg: "Please enable one either QR code or Enable FR",textColor: kDarkblueColor,fontSize: 12.0,backgroundColor: Colors.white);
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: kDarkblueColor,
                                      side: BorderSide.none,
                                      shape: const StadiumBorder()),
                                  child: Text("Submit",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      )
                    ]
                  )
              )
            ],
          ),
        ),
      ),
    );
  }


  void pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(
          source: source,
        imageQuality: 90,
        maxWidth: 1920,
        maxHeight: 1440
      );

      if (pickedImage == null) {
        print('image is null');
        return;
      }

      final pickedFile = File(pickedImage.path);
      var decodedImage = await decodeImageFromList(pickedFile.readAsBytesSync());
      print(decodedImage.width);
      print(decodedImage.height);
      print(getFileSizeString(file: pickedFile));

      if (pickedFile.lengthSync() > 200 * 1024) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.white,
            content: Text('Image size is too large. Choose a smaller image.' , style: GoogleFonts.poppins(
              color: kDarkblueColor,
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
            ),),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      setState(() {
        _imageFile = pickedImage;
      });

      imgString = base64Encode(await pickedFile.readAsBytesSync());
      print('imgstring: $imgString');
      await saveImage(await pickedFile.readAsBytes());

    } catch (e) {
      // Handle any exception that might occur during image picking
      print('Failed to pick image: $e');
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

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: GoogleFonts.poppins(
              color: kDarkblueColor,
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            ElevatedButton.icon(
              icon: Icon(
                  Icons.camera,
                color: kDarkblueColor,
                size: 20,
              ),
              onPressed: () {
                pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
              label: Text(
                "Camera",
                style: GoogleFonts.poppins(
                  color: kDarkblueColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),

            ElevatedButton.icon(
              icon: Icon(
                  Icons.image,
                color: kDarkblueColor,
                size: 20,
              ),
              onPressed: () {
                pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              label: Text(
                "Gallery",
                style: GoogleFonts.poppins(
                  color: kDarkblueColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }
}
