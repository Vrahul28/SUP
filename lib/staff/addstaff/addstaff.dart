import 'dart:convert';
import 'package:acp/Provider/Staff/Insert_Staff_Provider.dart';
import 'package:acp/staff/addstaff/addstaffmethods.dart';
import 'package:acp/staff/terms&conditiondialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../company/companymethods.dart';
import '../../utils/Textform_field.dart';
import '../../utils/colors.dart';
import '../staffscreen.dart';
import 'imageguidlines.dart';

class AddStaff extends StatefulWidget {
  const AddStaff({super.key});

  @override
  State<AddStaff> createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final insertStaffProvider= Provider.of<InsertStaffProvider>(context, listen: false);
    return Material(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: <Widget>[
              Consumer<InsertStaffProvider>(
                  builder: (context, value, child) {
                    return SliverAppBar(
                      backgroundColor: kDarkblueColor,
                      title: value.view?Text("Staff",
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
                          value.view =false;
                          value.imgString= "";
                          value.isQR= false;
                          value.isFR= false;
                          value.isConsent= false;

                          insertStaffProvider.clearController();
                          Navigator.pop(context);
                          // Navigator.of(context).pushReplacement(
                          //   MaterialPageRoute(
                          //     builder: (BuildContext context) => const StaffScreen(),
                          //   ),
                          // );

                        },
                      ),
                    );
                  },
              ),
              SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(
                        height: 10,
                      ),
                     Consumer<InsertStaffProvider>(
                         builder: (context, value, child) {
                           return Visibility(
                             visible: value.isFR,
                             child: Column(
                               children: [
                                 Stack(
                                   children: [
                                     CircleAvatar(
                                       radius: 70.0,
                                       backgroundImage: (value.imageFile == null && value.image1 == false)
                                           ? AssetImage("assets/images/profile.png")
                                           : (value.imageFile != null)
                                           ? FileImage(File(value.imageFile!.path))
                                           : (value.imgString.isNotEmpty)
                                           ? MemoryImage(base64Decode(value.imgString))
                                           : AssetImage("assets/images/profile.png") as ImageProvider<Object>?,
                                     ),
                                     Positioned(
                                       bottom: 0,
                                       right: 0,
                                       child: InkWell(
                                         onTap: () {
                                           showModalBottomSheet(
                                             context: context,
                                             builder: ((builder) => bottomSheet(context)),
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
                           );
                         },
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
                              controller: insertStaffProvider.firstName,
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
                              controller: insertStaffProvider.lastName,
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
                              controller: insertStaffProvider.nric,
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
                                }else if(insertStaffProvider.emailExit == true){
                                  return 'Email already exist';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  insertStaffProvider.checkEmail();
                                });
                              },
                              controller: insertStaffProvider.corporateEmail,
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
                                hintText: 'Corporate Email',
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
                              errorMsg: 'Staff Contact Number required.',
                              hinttext: 'Contact Number',
                              controller: insertStaffProvider.contactNo,
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
                              controller: insertStaffProvider.jobPosition,
                            )
                          ),
                          Tower(controller1: insertStaffProvider.location),
                          AllCompany(controller1: insertStaffProvider.addCompany, hint: "Company",),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                            child: CustomTextfield(
                              Icons: LineAwesomeIcons.hashtag_solid,
                              obsuretext: false,
                              lines: 1,
                              errorMsg: 'Unit No. required.',
                              hinttext: 'Unit No',
                              controller: insertStaffProvider.unitNo,
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                            child: CustomTextfield(
                              Icons: Icons.credit_card,
                              obsuretext: false,
                              lines: 1,
                              errorMsg: 'Card No. required.',
                              hinttext: 'Card No',
                              controller: insertStaffProvider.cardNo,
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
                              controller: insertStaffProvider.activationDate,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(18.0),
                                filled: true,
                                fillColor:  kGinColor,
                                prefixIcon: IconButton(
                                  icon: Icon(Icons.calendar_month,size: 24.0,color: kDarkblueColor),
                                  onPressed: () {
                                    dateRange(context, insertStaffProvider.activationDate);
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
                          Consumer<InsertStaffProvider>(
                              builder: (context, value, child) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                                  child: Row(
                                    children: [
                                      CupertinoSwitch(
                                        trackColor: Colors.white,
                                        activeColor: kDarkblueColor,
                                        value: value.isQR ,
                                        onChanged: (bool value1) {
                                          value.isQR = value1;
                                            debugPrint("QR Code: ${value.isQR}");
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
                                );
                              },
                          ),
                          Consumer<InsertStaffProvider>(
                            builder: (context, value, child) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 0.0),
                                child: Row(
                                  children: [
                                    CupertinoSwitch(
                                      trackColor: Colors.white,
                                      activeColor: kDarkblueColor,
                                      value: value.isFR ,
                                      onChanged: (bool value1) {
                                          value.isFR = value1;
                                          debugPrint("Enable FR: ${value.isFR}");
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
                              );
                            },
                          ),
                             Consumer<InsertStaffProvider>(
                               builder: (context, value, child) {
                                 return value.isFR ? SizedBox() :Row(
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
                                 );
                               },
                             ),
                          const SizedBox(
                            height: 10,
                          ),
                          Consumer<InsertStaffProvider>(
                            builder: (context, value, child) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                                child: Row(
                                  children: [
                                    CupertinoSwitch(
                                      trackColor: Colors.white,
                                      activeColor: kDarkblueColor,
                                      value: value.isConsent,
                                      onChanged: (bool value1) {
                                          value.isConsent = value1;
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
                              );
                            },
                          ),
                            Consumer<InsertStaffProvider>(
                                builder: (context, value, child) {
                                  return value.view ?
                                  SizedBox():
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: (MediaQuery.of(context).size.height*0.07),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if(_formKey.currentState!.validate()){
                                            if(value.isQR== false && value.isFR== true && value.isConsent== true || value.isQR== true && value.isFR== true && value.isConsent== true || value.isQR== true && value.isFR== false && value.isConsent== true){
                                              debugPrint('done');
                                              // Create
                                              if(value.isUpdate== false && value.view== false){
                                                debugPrint('done1');
                                                if(value.isFR==true && value.isQR==true && value.imgString.isNotEmpty){
                                                  value.qr = (value.isQR ? "1":null)!;
                                                  value.fr = (value.isFR ? "1": null)!;
                                                  value.consent = (value.isConsent ? "1":null)!;

                                                  bool success= await insertStaffProvider.addStaff(
                                                      insertStaffProvider.firstName.text,
                                                      insertStaffProvider.lastName.text,
                                                      insertStaffProvider.nric.text,
                                                      insertStaffProvider.corporateEmail.text,
                                                      insertStaffProvider.contactNo.text,
                                                      insertStaffProvider.jobPosition.text,
                                                      insertStaffProvider.location.text,
                                                      insertStaffProvider.unitNo.text,
                                                      insertStaffProvider.activationDate.text,
                                                      value.qr,
                                                      value.fr,
                                                      value.consent,
                                                      value.imgString
                                                  );
                                                  if(success){
                                                    Fluttertoast.showToast(msg: "Data Inserted successfully", textColor: kDarkblueColor,fontSize: 12.0);
                                                    Navigator.of(context).pushReplacement(
                                                      MaterialPageRoute(
                                                        builder: (BuildContext context) => const StaffScreen(),
                                                      ),
                                                    );
                                                    value.imgString= "";
                                                    value.isQR= false;
                                                    value.isFR= false;
                                                    value.isConsent= false;

                                                    value.clearController();
                                                  }

                                                }else if(value.isFR==false && value.isQR==true && value.imgString.isEmpty){
                                                  value.qr = (value.isQR ? "1":null)!;
                                                  value.fr = (value.isFR ? "1": null)!;
                                                  value.consent = (value.isConsent ? "1":null)!;
                                                  debugPrint("isQR in insert: ${value.qr}");

                                                  bool success= await insertStaffProvider.addStaff(
                                                      insertStaffProvider.firstName.text,
                                                      insertStaffProvider.lastName.text,
                                                      insertStaffProvider.nric.text,
                                                      insertStaffProvider.corporateEmail.text,
                                                      insertStaffProvider.contactNo.text,
                                                      insertStaffProvider.jobPosition.text,
                                                      insertStaffProvider.location.text,
                                                      insertStaffProvider.unitNo.text,
                                                      insertStaffProvider.activationDate.text,
                                                      value.qr,
                                                      value.fr,
                                                      value.consent,
                                                      value.imgString
                                                  );

                                                  if(success){
                                                    Fluttertoast.showToast(msg: "Data Inserted successfully", textColor: kDarkblueColor,fontSize: 12.0);
                                                    Navigator.of(context).pushReplacement(
                                                      MaterialPageRoute(
                                                        builder: (BuildContext context) => const StaffScreen(),
                                                      ),
                                                    );

                                                    value.imgString= "";
                                                    value.isQR= false;
                                                    value.isFR= false;
                                                    value.isConsent= false;

                                                    value.clearController();
                                                  }
                                                } else if(value.isQR && value.isFR){
                                                  Fluttertoast.showToast(msg: "Please enable one either QR code or Enable FR");
                                                }else{
                                                  Fluttertoast.showToast(msg: "Please Set Profile image");
                                                }

                                              }
                                              // Update
                                              else if(value.isUpdate== true && value.view== false){
                                                if(value.isFR==false){
                                                  debugPrint("Update");
                                                  value.imgString= "";
                                                  value.qr = value.isQR ? "1":"0";
                                                  value.fr = value.isFR ? "1":"0";
                                                  value.consent = value.isConsent ? "1":"0";

                                                  bool update= await insertStaffProvider.updateStaff(
                                                      value.id,
                                                      value.companyId,
                                                      insertStaffProvider.firstName.text,
                                                      insertStaffProvider.lastName.text,
                                                      insertStaffProvider.nric.text,
                                                      insertStaffProvider.corporateEmail.text,
                                                      insertStaffProvider.contactNo.text,
                                                      insertStaffProvider.jobPosition.text,
                                                      insertStaffProvider.location.text,
                                                      insertStaffProvider.unitNo.text,
                                                      insertStaffProvider.activationDate.text,
                                                      value.qr,
                                                      value.fr,
                                                      value.consent,
                                                      value.imgString
                                                  );

                                                  if(update){
                                                    Fluttertoast.showToast(msg: "Data updated successfully", textColor: kDarkblueColor, fontSize: 12.0,backgroundColor: Colors.white);
                                                    Navigator.of(context).pushReplacement(
                                                      MaterialPageRoute(
                                                        builder: (BuildContext context) => const StaffScreen(),
                                                      ),
                                                    );
                                                    value.imgString= "";
                                                    value.isQR= false;
                                                    value.isFR= false;
                                                    value.isConsent= false;

                                                    value.clearController();
                                                  }

                                                }else  if(value.isFR==true && value.imgString.isNotEmpty){
                                                  value.qr = value.isQR ? "1":"0";
                                                  value.fr = value.isFR ? "1":"0";
                                                  value.consent = value.isConsent ? "1":"0";

                                                  bool update= await insertStaffProvider.updateStaff(
                                                      value.id,
                                                      value.companyId,
                                                      insertStaffProvider.firstName.text,
                                                      insertStaffProvider.lastName.text,
                                                      insertStaffProvider.nric.text,
                                                      insertStaffProvider.corporateEmail.text,
                                                      insertStaffProvider.contactNo.text,
                                                      insertStaffProvider.jobPosition.text,
                                                      insertStaffProvider.location.text,
                                                      insertStaffProvider.unitNo.text,
                                                      insertStaffProvider.activationDate.text,
                                                      value.qr,
                                                      value.fr,
                                                      value.consent,
                                                      value.imgString
                                                  );

                                                  if(update){
                                                    Fluttertoast.showToast(msg: "Data updated successfully", textColor: kDarkblueColor, fontSize: 12.0,backgroundColor: Colors.white);
                                                    Navigator.of(context).pushReplacement(
                                                      MaterialPageRoute(
                                                        builder: (BuildContext context) => const StaffScreen(),
                                                      ),
                                                    );

                                                    value.imgString= "";
                                                    value.isQR= false;
                                                    value.isFR= false;
                                                    value.isConsent= false;

                                                    value.clearController();
                                                  }

                                                }else{
                                                  Fluttertoast.showToast(msg: "Please set profile image");
                                                }
                                              }
                                            }else if(value.isConsent== false){
                                              Fluttertoast.showToast(msg: "Accept terms and condtions", textColor: kDarkblueColor, fontSize: 12.0,backgroundColor: Colors.white);
                                            }else if(value.isQR== false && value.isFR== false){
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
                                  );
                                },
                            )
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

  Widget bottomSheet(BuildContext context) {
    final staffProvider= context.read<InsertStaffProvider>();
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
                staffProvider.pickImage(ImageSource.camera,context);
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
                staffProvider.pickImage(ImageSource.gallery,context);
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
