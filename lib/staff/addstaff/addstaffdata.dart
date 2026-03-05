import 'package:acp/staff/addstaff/addstaff.dart';
import 'package:acp/staff/database/addstaffmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Provider/Staff/Insert_Staff_Provider.dart';
import '../../Provider/Staff/Staff_Provider.dart';
import '../../appDashboard/dashboard/dashboard.dart';
import '../../utils/colors.dart';
import '../database/dbhelper.dart';
import '../staffscreen.dart';

class AddStaffData extends StatefulWidget {
  const AddStaffData({super.key});

  @override
  State<AddStaffData> createState() => _AddStaffDataState();
}

class _AddStaffDataState extends State<AddStaffData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  DBHelper db= DBHelper.db;

  @override
  Widget build(BuildContext context) {
    final staffProvider= context.read<StaffProvider>();
    return Material(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: CustomScrollView(
              slivers: <Widget>[
                Consumer<InsertStaffProvider>(
                    builder: (context, value, child) {
                      return  SliverAppBar(
                        // pinned: true,
                        // expandedHeight: 65.0,
                        backgroundColor: kDarkblueColor,
                        title: Text("Staff Listing",
                          style: GoogleFonts.poppins(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        centerTitle: true,
                        leading: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,

                          ),
                          onPressed: () {
                              value.image1 = false;
                              value.isQR= false;
                              value.isFR= false;
                              value.isConsent= false;

                              value.clearController();
                              value.imgString= "";
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Dashboard(),
                                ),
                              );

                          },
                        ),
                      );
                    },
                ),
                SliverList(
                    delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0, top: 0.0),
                            child: SizedBox(
                                width: (MediaQuery.of(context).size.width),
                                height: (MediaQuery.of(context).size.height),
                                child:  FutureBuilder(
                                  future: db.getAllStaff(staffProvider.companyId.text,staffProvider.staffCodeClass.text,context),
                                  builder: (context, snapshot) {
                                    if(snapshot.connectionState == ConnectionState.waiting){
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }else if(snapshot.hasError){
                                      return Center(
                                        child: Text('Error: ${snapshot.error}'),
                                      );
                                    }else{
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              // Padding(
                                              //   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                              //   child: Text(
                                              //     "Total Company : " + allresult.text,
                                              //     style: GoogleFonts.poppins(
                                              //       color: kDarkblueColor,
                                              //       fontSize: 18.0,
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          // if(allresult.text == "0")
                                          //   Text(
                                          //     "No records found ",
                                          //     style: GoogleFonts.poppins(
                                          //       color: kDarkblueColor,
                                          //       fontSize: 18.0,
                                          //     ),
                                          //   ),
                                          Expanded(
                                            child: ListView.builder(
                                              controller: _scrollController,
                                              itemCount: allStaff.length,
                                              itemBuilder:(context, index) {
                                                final staff= allStaff[index];
                                                return Card(
                                                  child:  Padding(
                                                    padding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0, top: 0.0),
                                                    child: ExpansionTile(
                                                      trailing: Consumer<InsertStaffProvider>(
                                                          builder: (context, value, child) {
                                                            return PopupMenuButton(
                                                              itemBuilder: (context) {
                                                                return [
                                                                  PopupMenuItem(
                                                                    value: 'view',
                                                                    child: InkWell(
                                                                      child: Row(
                                                                        children: [
                                                                          Icon(Icons.remove_red_eye, size: 20,color: kDarkblueColor,),
                                                                          SizedBox(
                                                                            width: 10,
                                                                          ),
                                                                          Text('View', style: GoogleFonts.poppins(
                                                                            color: Colors.black,
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 17.0,
                                                                          )),
                                                                        ],
                                                                      ),
                                                                      onTap: () {
                                                                        Navigator.of(context).pushReplacement(
                                                                          MaterialPageRoute(
                                                                            builder: (BuildContext context) => AddStaff(),
                                                                          ),
                                                                        );
                                                                        // id= staff.staffId!;
                                                                        value.firstName.text= staff.firstName!;
                                                                        value.lastName.text= staff.lastName!;
                                                                        value.nric.text= staff.nricNumber!;
                                                                        value.corporateEmail.text= staff.corporateEmail!;
                                                                        value.contactNo.text= staff.staffPhone!;
                                                                        value.jobPosition.text= staff.staffJobPosition!;
                                                                        value.location.text= staff.tower!;
                                                                        value.addCompany.text= staff.company!;
                                                                        value.unitNo.text= staff.unitNO!;
                                                                        value.activationDate.text= staff.activationDate!;
                                                                        value.imgString= staff.profileImage!;

                                                                        value.isQR= true;
                                                                        value.isFR= true;
                                                                        value.isConsent= true;

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
                                                                          SizedBox(
                                                                            width: 10,
                                                                          ),
                                                                          Text('Edit', style: GoogleFonts.poppins(
                                                                            color: Colors.black,
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 17.0,
                                                                          )),
                                                                        ],
                                                                      ),
                                                                      onTap: () {
                                                                        Navigator.of(context).pushReplacement(
                                                                          MaterialPageRoute(
                                                                            builder: (BuildContext context) => AddStaff(),
                                                                          ),
                                                                        );
                                                                        // id= staff.staffId!;
                                                                        value.firstName.text= staff.firstName!;
                                                                        value.lastName.text= staff.lastName!;
                                                                        value.nric.text= staff.nricNumber!;
                                                                        value.corporateEmail.text= staff.corporateEmail!;
                                                                        value.contactNo.text= staff.staffPhone!;
                                                                        value.jobPosition.text= staff.staffJobPosition!;
                                                                        value.location.text= staff.tower!;
                                                                        value.addCompany.text= staff.company!;
                                                                        value.unitNo.text= staff.unitNO!;
                                                                        value.activationDate.text= staff.activationDate!;
                                                                        value.imgString= staff.profileImage!;


                                                                        value.isQR= true;
                                                                        value.isFR= true;
                                                                        value.isConsent= true;

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
                                                                          SizedBox(
                                                                            width: 10,
                                                                          ),
                                                                          Text('Delete', style: GoogleFonts.poppins(
                                                                            color: Colors.black,
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 17.0,
                                                                          )),
                                                                        ],
                                                                      ),
                                                                      onTap: () {
                                                                        var stafff11= Addstaffmodel(staffId: staff.staffId);
                                                                        db.deleteStaff(stafff11);
                                                                        Navigator.pop(context);
                                                                        setState(() {});

                                                                      },
                                                                    ),
                                                                  )
                                                                ];
                                                              },

                                                            );
                                                          },
                                                      ),
                                                      title: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text("Name :", style: GoogleFonts.poppins(
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 17.0,
                                                              )
                                                              ),
                                                              SizedBox(width: 5,),
                                                              Expanded(
                                                                child: Text(
                                                                  "${staff.firstName} ${staff.lastName}",
                                                                  style: GoogleFonts.poppins(
                                                                      color: Colors.black,
                                                                      fontSize: 15.0
                                                                  ),
                                                                  maxLines: 4,
                                                                  overflow: TextOverflow.visible,
                                                                ),

                                                              ),

                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text("Company :", style: GoogleFonts.poppins(
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 17.0,
                                                              )),
                                                              SizedBox(width: 5,),
                                                              Expanded(
                                                                    child: Text("${staff.company}",
                                                                      style: GoogleFonts.poppins(
                                                                        color: Colors.black,
                                                                        fontSize:15.0,
                                                                      ),
                                                                      maxLines: 4,
                                                                    )
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text("Corporate email :", style: GoogleFonts.poppins(
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 17.0,
                                                              )),
                                                              SizedBox(width: 5,),
                                                              Expanded(
                                                                child: Text("${staff.corporateEmail}",
                                                                  style: GoogleFonts.poppins(
                                                                    color: Colors.black,
                                                                    fontSize: 15.0,
                                                                  ),

                                                                  maxLines: 4,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text("NRIC :", style: GoogleFonts.poppins(
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 17.0,
                                                              )),
                                                              SizedBox(width: 5,),
                                                              Expanded(
                                                                  child: SingleChildScrollView(
                                                                    scrollDirection: Axis.horizontal,
                                                                    child: Text("${staff.nricNumber}",
                                                                      style: GoogleFonts.poppins(
                                                                        color: Colors.black,
                                                                        fontSize: 15.0,
                                                                      ),
                                                                    ),
                                                                  )
                                                              ),
                                                            ],
                                                          ),


                                                          // SizedBox(height: 20.0),
                                                        ],
                                                      ),

                                                      children: [

                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 0.0, top: 0.0),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text("Tower :", style: GoogleFonts.poppins(
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 17.0,
                                                                  )),
                                                                  SizedBox(width: 5,),
                                                                  Flexible(
                                                                    child: Text("${staff.tower}",
                                                                      style: GoogleFonts.poppins(
                                                                        color: Colors.black,
                                                                        fontSize: 15.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              // Row(
                                                              //   children: [
                                                              //     Text("Created By :", style: GoogleFonts.poppins(
                                                              //       color: Colors.black,
                                                              //       fontWeight: FontWeight.w500,
                                                              //       fontSize: 17.0,
                                                              //     )),
                                                              //     SizedBox(width: 5,),
                                                              //     Text("${company.createdBy}",
                                                              //       style: GoogleFonts.poppins(
                                                              //         color: Colors.black,
                                                              //         fontSize:15.0,
                                                              //       ),
                                                              //     ),
                                                              //   ],
                                                              // ),
                                                              Row(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text("Activation Date :", style: GoogleFonts.poppins(
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 17.0,
                                                                  )),
                                                                  SizedBox(width: 5,),
                                                                  Expanded(
                                                                    child: Text("${staff.activationDate}",
                                                                      style: GoogleFonts.poppins(
                                                                        color: Colors.black,
                                                                        fontSize: 15.0,
                                                                      ),
                                                                      // Clip the text if it overflows.
                                                                      maxLines: 3,
                                                                    ),

                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text("Unit number :", style: GoogleFonts.poppins(
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 17.0,
                                                                  )),
                                                                  SizedBox(width: 5,),
                                                                  Flexible(
                                                                    child: Text("${staff.unitNO}",
                                                                      style: GoogleFonts.poppins(
                                                                        color: Colors.black,
                                                                        fontSize: 15.0,
                                                                      ),
                                                                      softWrap: true,

                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(height: 20.0),
                                                            ],
                                                          ),
                                                        ),


                                                      ],
                                                    ),
                                                  ),

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
                        ]
                    )
                )
              ]
          ),
        ),
      ),
    );
  }
}
