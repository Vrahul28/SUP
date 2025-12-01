import 'dart:convert';
import 'package:acp/Provider/Staff/AddStaff_Provider.dart';
import 'package:acp/Provider/Staff/Staff_Provider.dart';
import 'package:acp/Provider/Staff/delete_Staff_Provider.dart';
import 'package:acp/staff/database/dbhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Provider/Staff/Staff_Search_Provider.dart';
import '../appDashboard/dashboard/dashboard.dart';
import '../company/companymethods.dart';
import '../utils/Date_Formater.dart';
import '../utils/colors.dart';
import 'addstaff/addstaff.dart';


class Staffscreen extends StatefulWidget {
  const Staffscreen({super.key});

  @override
  State<Staffscreen> createState() => _StaffscreenState();
}
TextEditingController companyid = TextEditingController();
TextEditingController company = TextEditingController();
TextEditingController staffcodeclass = TextEditingController();
TextEditingController totalstaff = TextEditingController();
TextEditingController totalstaff1 = TextEditingController();
String staffId= "";
String company_id= '';
bool isSearchStaff= false;
class _StaffscreenState extends State<Staffscreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  DBhelper db= DBhelper.db;

  late SharedPreferences pref;
  bool isAdmin = false;


  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  // Initialize SharedPreferences asynchronously
  Future<void> _initializePreferences() async {
    pref = await SharedPreferences.getInstance();
    String? userrole= pref.getString('userRole');
    if(userrole == "5"){
      setState(() {
        isAdmin = true;
      });
    }else {
      setState(() {
        isAdmin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final staffProvider= Provider.of<StaffProvider>(context,listen: false);
    final addStaffProvider= Provider.of<AddStaffProvider>(context,listen: false);
    final deleteStaffProvider= Provider.of<DeleteStaffProvider>(context);
    final searchStaff= Provider.of<StaffSearchProvider>(context);
    return Material(
      child: Scaffold(
        body: Form(
          key: this._formKey,
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
                        company.clear();
                        staffcodeclass.clear();
                        isSearchStaff= false;
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
                              builder: (BuildContext context) => const Addstaff(),
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
                              isAdmin ? Allcompany1(controller1: company, hint: "Company") : const SizedBox(),
                                // Staff Textfield
                                Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                                child: TextFormField(
                                  controller: staffcodeclass,
                                  cursorColor: kDarkblueColor,
                                  style: GoogleFonts.poppins(
                                    color: kDarkblueColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                  ),
                                  onChanged: (value) {
                                    isSearchStaff= true;
                                  },
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
                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 15.0, top: 0.0),
                                    child: Container(
                                        width: (MediaQuery.of(context).size.width),
                                        height: (MediaQuery.of(context).size.height * 0.75),
                                        child:  FutureBuilder(
                                          future: isSearchStaff? searchStaff.searchStaff(companyID, staffcodeclass.text): staffProvider.getAllStaffList(companyid.text,staffcodeclass.text),
                                          builder: (context, snapshot) {
                                            if(snapshot.connectionState == ConnectionState.waiting){
                                              return const Center(
                                                child: CircularProgressIndicator(),
                                              );
                                            }else if(snapshot.hasError){
                                              return Center(
                                                child: Text('Error: ${snapshot.error}'),
                                              );
                                            }else{
                                              return Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                                          child: Consumer<StaffProvider>(
                                                            builder: (context, value, child) {
                                                              return Text(
                                                                "Total Staff : ${isSearchStaff ? searchStaff.staffcount : value.count}",
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
                                                          itemCount: isSearchStaff? searchStaff.searchList.length: value.staffList.length,
                                                          itemBuilder:(context, index) {
                                                            final staff= isSearchStaff? searchStaff.searchList[index]:value.staffList[index];
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

                                                                                    //   ],
                                                                                    // ),

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
                                                                                        Text("${staff.towerIds}",
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
                                                                        child: Container(
                                                                          child: PopupMenuButton(
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
                                                                                      staffId= staff.staffId!;
                                                                                      company_id= staff.companyId!;
                                                                                      print("Staff screen: $company_id");
                                                                                      await addStaffProvider.getAddStaffList(staffId);
                                                                                      if(addStaffProvider.addStaffList.isNotEmpty){
                                                                                        final addStaff= addStaffProvider.addStaffList[0];
                                                                                        firstname.text= addStaff.firstName?? '';
                                                                                        lastname.text= addStaff.lastName?? '';
                                                                                        nric.text= addStaff.nricNumber?? '';
                                                                                        corporateemail.text= addStaff.corporateEmail?? '';
                                                                                        contactnumer.text= addStaff.staffPhone?? '';
                                                                                        jobposition.text= addStaff.staffJobPosition?? '';
                                                                                        location.text= addStaff.towerId?? '';
                                                                                        addcompany.text= addStaff.company?? '';
                                                                                        unitno.text= addStaff.unitNumber?? '';
                                                                                        cardno.text= addStaff.cardNumber?? '';
                                                                                        activationdate.text= addStaff.activationDate?? '';

                                                                                        addStaff.enrollQR == "1"? isQR = true : false;
                                                                                        addStaff.enrollFR == "1"? isFR = true : false;

                                                                                        isConsent= true;
                                                                                        Navigator.of(context).pushReplacement(
                                                                                          MaterialPageRoute(
                                                                                            builder: (BuildContext context) => const Addstaff(),
                                                                                          ),
                                                                                        );

                                                                                      }

                                                                                      view= true;
                                                                                      isupdate= false;
                                                                                      image = true;

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
                                                                                      staffId= staff.staffId!;
                                                                                      id= staff.staffId!;
                                                                                      company_id= staff.companyId!;
                                                                                      print("Staff screen: $company_id");
                                                                                      await addStaffProvider.getAddStaffList(staffId);
                                                                                      if(addStaffProvider.addStaffList.isNotEmpty){
                                                                                        final addStaff= addStaffProvider.addStaffList[0];
                                                                                        firstname.text= addStaff.firstName?? '';
                                                                                        lastname.text= addStaff.lastName?? '';
                                                                                        nric.text= addStaff.nricNumber?? '';
                                                                                        corporateemail.text= addStaff.corporateEmail?? '';
                                                                                        contactnumer.text= addStaff.staffPhone?? '';
                                                                                        jobposition.text= addStaff.staffJobPosition?? '';
                                                                                        location.text= addStaff.towerId?? '';
                                                                                        addcompany.text= addStaff.company?? '';
                                                                                        unitno.text= addStaff.unitNumber?? '';
                                                                                        cardno.text= addStaff.cardNumber?? '';

                                                                                        String formattedActivationDate = formatDate(addStaff.activationDate?? '');
                                                                                        String formattedExpirationDate = formatDate(addStaff.expirationDate?? '');

                                                                                        activationdate.text= "$formattedActivationDate - $formattedExpirationDate";

                                                                                        addStaff.enrollQR == "1"? isQR = true : false;
                                                                                        addStaff.enrollFR == "1"? isFR = true : false;

                                                                                        isConsent= true;
                                                                                        Navigator.of(context).pushReplacement(
                                                                                          MaterialPageRoute(
                                                                                            builder: (BuildContext context) => const Addstaff(),
                                                                                          ),
                                                                                        );
                                                                                      }
                                                                                      isupdate= true;
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
                                                                                      staffId= staff.staffId!;
                                                                                      await deleteStaffProvider.deleteStaff(staffId);
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                  ),
                                                                                )
                                                                              ];
                                                                            },

                                                                          ),
                                                                        )
                                                                    ),
                                                                    Positioned(
                                                                        bottom: 2.0,
                                                                        right: 8.0,
                                                                        child: Container(
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
                                                                          ),
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
                                            }

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
