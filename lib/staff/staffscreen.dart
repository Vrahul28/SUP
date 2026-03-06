import 'dart:convert';
import 'package:acp/Provider/Staff/Insert_Staff_Provider.dart';
import 'package:acp/Provider/Staff/Staff_Provider.dart';
import 'package:acp/staff/database/dbhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../appDashboard/dashboard/dashboard.dart';
import '../company/companymethods.dart';
import '../login/userPreference.dart';
import '../utils/Date_Formater.dart';
import '../utils/colors.dart';
import 'addstaff/addstaff.dart';


class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  final FocusNode companyFocus = FocusNode();
  final FocusNode staffFocus = FocusNode();
  final FocusNode cardFocus = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  DBHelper db= DBHelper.db;

  late SharedPreferences pref;
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    _initializePreferences();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchStaffListing();
    });
  }

  // Initialize SharedPreferences asynchronously
  Future<void> _initializePreferences() async {
    // pref = await SharedPreferences.getInstance();
    // String? userRole= pref.getString('userRole');
    setState(() {
      isAdmin = true;
    });
    // if(userRole == "1"){
    //   setState(() {
    //     isAdmin = true;
    //   });
    // }else {
    //   setState(() {
    //     isAdmin = false;
    //   });
    // }
  }

  Future<void> fetchStaffListing() async {
    final staffProvider = context.read<StaffProvider>();
    await staffProvider.getAllStaffList(staffProvider.companyId.text,staffProvider.staffCodeClass.text);
  }

  @override
  Widget build(BuildContext context) {
    final staffProvider= Provider.of<StaffProvider>(context,listen: false);
    return Material(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: CustomScrollView(
              slivers:<Widget>[
                SliverAppBar(
                    // pinned: true,
                    // expandedHeight: 65.0,
                    backgroundColor: kDarkblueColor,
                    title: Text("Staff",
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
                        staffProvider.company.clear();
                        staffProvider.staffCodeClass.clear();
                        companyID.clear();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) => const Dashboard(),
                          ),
                        );

                      },
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(
                          CupertinoIcons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (BuildContext context) => const AddStaff(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                SliverList(
                  delegate: SliverChildListDelegate(
                      [
                         Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              isAdmin ? AllCompany1(controller1: staffProvider.company, hint: "Company",focusNode: companyFocus,) : const SizedBox(),
                                // Staff Textfield
                                Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                                child: TextFormField(
                                  focusNode: staffFocus,
                                  controller: staffProvider.staffCodeClass,
                                  cursorColor: kDarkblueColor,
                                  style: GoogleFonts.poppins(
                                    color: kDarkblueColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(18.0),
                                    filled: true,
                                    fillColor:  kGinColor,
                                    prefixIcon: Icon(
                                      Icons.perm_contact_cal_sharp,
                                      size: 24.0,
                                      color: kDarkblueColor,
                                    ),
                                    hintText: 'Staff',
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
                                child: TextFormField(
                                  focusNode: cardFocus,
                                  controller: staffProvider.cardNo,
                                  cursorColor: kDarkblueColor,
                                  style: GoogleFonts.poppins(
                                    color: kDarkblueColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(18.0),
                                    filled: true,
                                    fillColor:  kGinColor,
                                    prefixIcon: Icon(
                                      Icons.perm_contact_cal_sharp,
                                      size: 24.0,
                                      color: kDarkblueColor,
                                    ),
                                    hintText: 'Card Number',
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
                              SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async{
                                      FocusScope.of(context).unfocus();
                                      final staff = context.read<StaffProvider>();
                                      await staff.searchStaff(
                                        companyID,
                                        staffProvider.staffCodeClass.text,
                                        staffProvider.cardNo.text,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: kDarkblueColor,
                                        side: BorderSide.none,
                                        shape: const RoundedRectangleBorder()),
                                    child: Text("Search",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  ElevatedButton(
                                    onPressed: () async{
                                      companyFocus.unfocus();
                                      staffFocus.unfocus();
                                      cardFocus.unfocus();

                                      staffProvider.staffCodeClass.clear();
                                      staffProvider.company.clear();
                                      staffProvider.cardNo.clear();

                                      staffProvider.isSearchResult = false;
                                      staffProvider.getAllStaffList('', '');

                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: kDarkblueColor,
                                        side: BorderSide.none,
                                        shape: const RoundedRectangleBorder()),
                                    child: Text("Clear",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Padding(
                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 15.0, top: 0.0),
                                    child: SizedBox(
                                        width: (MediaQuery.of(context).size.width),
                                        height: (MediaQuery.of(context).size.height * 0.75),
                                        child: Consumer<StaffProvider>(
                                            builder: (context, value, child) {
                                              if (value.isLoading) {
                                                return const Center(
                                                  child: CircularProgressIndicator(),
                                                );
                                              }
                                              return Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                                        child: Consumer<StaffProvider>(
                                                          builder: (context, value, child) {
                                                            return Text(
                                                              "Total Staff : ${value.isSearchResult ? value.staffcount : value.count}",
                                                              style: GoogleFonts.poppins(
                                                                color: kDarkblueColor,
                                                                fontSize: 18.0,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Expanded(
                                                    child: Consumer<StaffProvider>(
                                                      builder: (context, value, child) {
                                                        return ListView.builder(
                                                          padding: EdgeInsets.zero,
                                                          controller: _scrollController,
                                                          shrinkWrap: true,
                                                          itemCount: value.isSearchResult? value.searchList.length: value.staffList.length,
                                                          itemBuilder:(context, index) {
                                                            final staff= value.isSearchResult? value.searchList[index]:value.staffList[index];
                                                            return Card(
                                                              color: kGinColor2,
                                                              child:  Padding(
                                                                padding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 5.0, top: 5.0),
                                                                child: Stack(
                                                                  children: [
                                                                    ExpansionTile(
                                                                      trailing: const SizedBox.shrink(),
                                                                      title: Column(
                                                                        children: [
                                                                          Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              if(staff.imageData!= null)
                                                                                SizedBox(
                                                                                  // width: 80,
                                                                                  // height: 80,
                                                                                  child: CircleAvatar(
                                                                                    radius: 25.0,
                                                                                    backgroundImage:  MemoryImage(base64Decode(staff.imageData!)),
                                                                                  ),
                                                                                )
                                                                              else
                                                                                const SizedBox(
                                                                                  // width: 80,
                                                                                  // height: 80,
                                                                                  child: CircleAvatar(
                                                                                    radius: 25.0,
                                                                                    backgroundImage: AssetImage("assets/images/profile.png"),
                                                                                  ),
                                                                                ),
                                                                              const SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Expanded(
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Row(
                                                                                      children: [
                                                                                        Expanded(
                                                                                          flex: 0,
                                                                                          child: SingleChildScrollView(
                                                                                            scrollDirection: Axis.horizontal,
                                                                                            child: Text(
                                                                                              "${staff.firstName} ${staff.lastName}",
                                                                                              style: GoogleFonts.poppins(
                                                                                                  color: Colors.black,
                                                                                                  fontSize: 15.0,
                                                                                                  fontWeight: FontWeight.w500
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 3,
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 0,
                                                                                      child: Text("${staff.company}",
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        softWrap: true,
                                                                                        style: GoogleFonts.poppins(
                                                                                            color: Colors.black,
                                                                                            fontSize:14.0,
                                                                                            fontWeight: FontWeight.w500
                                                                                        ),
                                                                                        // maxLines: 4,
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 20,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                              // SizedBox(height: 20.0),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(height: 7,),
                                                                          Row(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Flexible(
                                                                                    flex: 0,
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Icon(Icons.credit_card),
                                                                                        const SizedBox(
                                                                                          width: 5,
                                                                                        ),
                                                                                        Text("${staff.cardNumber}",
                                                                                          style: GoogleFonts.poppins(
                                                                                            color: Colors.black,
                                                                                            fontSize: 15.0,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 40,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Flexible(
                                                                                    flex: 0,
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Icon(Icons.cell_tower),
                                                                                        SizedBox(width: 5,),
                                                                                        Text("${staff.tower}",
                                                                                          style: GoogleFonts.poppins(
                                                                                            color: Colors.black,
                                                                                            fontSize: 15.0,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),

                                                                        ],
                                                                      ),
                                                                      children: [],
                                                                    ),
                                                                    Positioned(
                                                                        top: 1.0,
                                                                        right: 4.0,
                                                                        child: SizedBox(
                                                                          child: Consumer<InsertStaffProvider>(
                                                                            builder: (context, value, child) {
                                                                              return PopupMenuButton(
                                                                                icon: Icon(Icons.more_horiz),
                                                                                itemBuilder: (context) {
                                                                                  return [
                                                                                    PopupMenuItem(
                                                                                      value: 'view',
                                                                                      child: InkWell(
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Icon(Icons.remove_red_eye, size: 20,color: kDarkblueColor,),
                                                                                            const SizedBox(
                                                                                              width: 10,
                                                                                            ),
                                                                                            Text('View', style: GoogleFonts.poppins(
                                                                                              color: Colors.black,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 17.0,
                                                                                            )),
                                                                                          ],
                                                                                        ),
                                                                                        onTap: () async{
                                                                                          staffProvider.staffId= staff.staffId!.toString();
                                                                                          // staffProvider.companyId1= staff.companyId!.toString();
                                                                                          debugPrint("Staff screen: ${staffProvider.companyId1}");
                                                                                          await staffProvider.getAddStaffList(staffProvider.staffId);
                                                                                          if(staffProvider.addStaffList.isNotEmpty){
                                                                                            final addStaff= staffProvider.addStaffList[0];
                                                                                            value.firstName.text= addStaff.firstName?? '';
                                                                                            value.lastName.text= addStaff.lastName?? '';
                                                                                            value.nric.text= addStaff.nricNumber?? '';
                                                                                            value.corporateEmail.text= addStaff.corporateEmail?? '';
                                                                                            value.contactNo.text= addStaff.staffPhone?? '';
                                                                                            value.jobPosition.text= addStaff.staffJobPosition?? '';
                                                                                            value.location.text= addStaff.tower?? '';
                                                                                            value.addCompany.text= addStaff.company?? '';
                                                                                            value.unitNo.text= addStaff.unitNO?? '';
                                                                                            value.cardNo.text= addStaff.cardNumber?? '';
                                                                                            value.activationDate.text= addStaff.activationDate?? '';

                                                                                            value.isQR =  addStaff.enrollQR!;
                                                                                            value.isFR =  addStaff.enrollFR!;
                                                                                            value.isConsent= addStaff.consentToTC!;
                                                                                            value.imgString= addStaff.imageData ?? '';

                                                                                            Navigator.of(context).pushReplacement(
                                                                                              MaterialPageRoute(
                                                                                                builder: (BuildContext context) => const AddStaff(),
                                                                                              ),
                                                                                            );

                                                                                          }

                                                                                          value.view= true;
                                                                                          value.isUpdate= false;
                                                                                          value.image1 = true;

                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                    PopupMenuItem(
                                                                                      value: 'edit',
                                                                                      child: InkWell(
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Icon(Icons.edit, size: 20,color: kDarkblueColor,),
                                                                                            const SizedBox(
                                                                                              width: 10,
                                                                                            ),
                                                                                            Text('Edit', style: GoogleFonts.poppins(
                                                                                              color: Colors.black,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 17.0,
                                                                                            )),
                                                                                          ],
                                                                                        ),
                                                                                        onTap: () async{
                                                                                          staffProvider.staffId= staff.staffId!.toString();
                                                                                          value.id= staff.staffId!.toString();
                                                                                          staffProvider.companyId1= staff.companyId!.toString();
                                                                                          debugPrint("Staff screen: ${staffProvider.companyId1}");
                                                                                          await staffProvider.getAddStaffList(staffProvider.staffId);
                                                                                          if(staffProvider.addStaffList.isNotEmpty){
                                                                                            final addStaff= staffProvider.addStaffList[0];
                                                                                            value.firstName.text= addStaff.firstName?? '';
                                                                                            value.lastName.text= addStaff.lastName?? '';
                                                                                            value.nric.text= addStaff.nricNumber?? '';
                                                                                            value.corporateEmail.text= addStaff.corporateEmail?? '';
                                                                                            value.contactNo.text= addStaff.staffPhone?? '';
                                                                                            value.jobPosition.text= addStaff.staffJobPosition?? '';
                                                                                            value.location.text= addStaff.tower?? '';
                                                                                            value.addCompany.text= addStaff.company?? '';
                                                                                            value.unitNo.text= addStaff.unitNO?? '';
                                                                                            value.cardNo.text= addStaff.cardNumber?? '';

                                                                                            String formattedActivationDate = formatDate(addStaff.activationDate?? '');
                                                                                            String formattedExpirationDate = formatDate(addStaff.expirationDate?? '');

                                                                                            value.activationDate.text= "$formattedActivationDate - $formattedExpirationDate";

                                                                                            value.isQR =  addStaff.enrollQR!;
                                                                                            value.isFR =  addStaff.enrollFR!;
                                                                                            value.isConsent= addStaff.consentToTC!;
                                                                                            value.imgString= addStaff.imageData ?? '';

                                                                                            Navigator.of(context).pushReplacement(
                                                                                              MaterialPageRoute(
                                                                                                builder: (BuildContext context) => const AddStaff(),
                                                                                              ),
                                                                                            );
                                                                                          }
                                                                                          value.isUpdate= true;
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                    PopupMenuItem(
                                                                                      value: 'delete',
                                                                                      child: InkWell(
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Icon(Icons.delete, size: 20,color: kDarkblueColor,),
                                                                                            const SizedBox(
                                                                                              width: 10,
                                                                                            ),
                                                                                            Text('Delete', style: GoogleFonts.poppins(
                                                                                              color: Colors.black,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontSize: 17.0,
                                                                                            )),
                                                                                          ],
                                                                                        ),
                                                                                        onTap: () async {
                                                                                          UserPreference user= UserPreference();
                                                                                          String userID= await user.getUserId();
                                                                                          staffProvider.staffId= staff.staffId!.toString();
                                                                                          await staffProvider.deleteStaff(staffProvider.staffId,userID);
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                      ),
                                                                                    )
                                                                                  ];
                                                                                },

                                                                              );
                                                                            },
                                                                          ),
                                                                        )
                                                                    ),
                                                                    Positioned(
                                                                        bottom: 2.0,
                                                                        right: 8.0,
                                                                        child: Row(
                                                                          children: [
                                                                            if(staff.imageData!=null)
                                                                              Image.asset("assets/images/FR.ico",width: 39,height: 40, )
                                                                            else
                                                                              Image.asset("assets/images/FR1.ico",width: 35,height: 40,),
                                                                            //
                                                                            // if(staff.qrcode== "true")
                                                                            //   Image.asset("assets/images/qr2.ico",width: 33,height: 40,)
                                                                            // else
                                                                            Image.asset("assets/images/qr.ico",width: 35,height: 40,)
                                                                          ],
                                                                        )
                                                                    )
                                                                  ],

                                                                ),
                                                              ),

                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                        )

                                    ),
                                  )
                            ],
                          ),

                      ]
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }
}
