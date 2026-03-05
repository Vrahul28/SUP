import 'package:acp/Provider/Company/Insert_Company_Provider.dart';
import 'package:acp/company/addcompany/addcompany.dart';
import 'package:acp/staff/database/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Provider/Company/Company_Provider.dart';
import '../../appDashboard/dashboard/dashboard.dart';
import '../../utils/colors.dart';
import 'addcompanymodel.dart';

class AddCompanyData extends StatefulWidget {
  const AddCompanyData({super.key});

  @override
  State<AddCompanyData> createState() => _AddCompanyDataState();
}

class _AddCompanyDataState extends State<AddCompanyData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  DBHelper db= DBHelper.db;
  @override
  Widget build(BuildContext context) {
    final company= context.read<InsertCompanyProvider>();
    final companyPro= context.read<CompanyProvider>();
    return Material(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  // pinned: true,
                  // expandedHeight: 65.0,
                  backgroundColor: kDarkblueColor,
                  title: Text("Company Listing",
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
                      company.clearController();

                      setState(() {
                        company.isSwitchOn = false;
                        company.isSwitchOn2 = false;
                        company.isSwitchOn3 = false;
                      });

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => Dashboard(),
                        ),
                      );

                    },
                  ),
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
                                future: db.getAllCompany(
                                    companyPro.towerCodeClass.text,
                                    companyPro.companyCodeClass.text,
                                    companyPro.unitNoClass.text,
                                  context
                                ),
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
                                            itemCount: allCompany.length,
                                            itemBuilder:(context, index) {
                                              final company1= allCompany[index];
                                                return Card(
                                                  child:  Column(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0, top: 0.0),
                                                        child: ExpansionTile(
                                                          trailing: PopupMenuButton(
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
                                                                          builder: (BuildContext context) => AddCompany(),
                                                                        ),
                                                                      );
                                                                      company.id1= company1.companyId!;
                                                                      company.companyName.text= company1.companyName!;
                                                                      company.displayName.text= company1.displayName ?? '';
                                                                      company.uag.text= company1.UAG!;
                                                                      company.contactName.text= company1.contactName ?? '';
                                                                      company.contactNo.text= company1.contactNO!;
                                                                      // tower.text= company.tower!;
                                                                      // floor.text= company.floor!;
                                                                      // unitno.text= company.unitNO!;
                                                                      // area.text= company.area!;
                                                                      // occupancy.text= company.occupancy!;
                                                                      // staffno.text= company.staffNO!;

                                                                      company.viewCompany= true;

                                                                      setState(() {
                                                                        company.isSwitchOn = true;
                                                                        company.isSwitchOn2 = true;
                                                                        company.isSwitchOn3 = true;
                                                                      });


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
                                                                          builder: (BuildContext context) => AddCompany(),
                                                                        ),
                                                                      );
                                                                      company.id1= company1.companyId!;
                                                                      company.companyName.text= company1.companyName!;
                                                                      company.displayName.text= company1.displayName!;
                                                                      company.uag.text= company1.UAG!;
                                                                      company.contactName.text= company1.contactName!;
                                                                      company.contactNo.text= company1.contactNO!;
                                                                      // tower.text= company.tower!;
                                                                      // floor.text= company.floor!;
                                                                      // unitno.text= company.unitNO!;
                                                                      // area.text= company.area!;
                                                                      // occupancy.text= company.occupancy!;
                                                                      // staffno.text= company.staffNO!;


                                                                      company.isUpdateCompany= true;


                                                                      setState(() {
                                                                        company.isSwitchOn = true;
                                                                        company.isSwitchOn2 = true;
                                                                        company.isSwitchOn3 = true;
                                                                      });


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
                                                                      var company11= Addcompanymodel(companyId: company1.companyId);
                                                                      db.deleteCompany(company11);
                                                                      Navigator.pop(context);
                                                                      setState(() {

                                                                      });

                                                                    },
                                                                  ),
                                                                ),

                                                              ];
                                                            },

                                                          ),

                                                          title: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [

                                                              Row(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text("Company :", style: GoogleFonts.poppins(
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 17.0,
                                                                  )
                                                                  ),
                                                                  SizedBox(width: 5,),
                                                                  Expanded(
                                                                    child: Text(
                                                                      "${company.companyName}",
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
                                                                  Text("Unit No :", style: GoogleFonts.poppins(
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 17.0,
                                                                  )),
                                                                  SizedBox(width: 5,),
                                                                  // Expanded(
                                                                  //     child: SingleChildScrollView(
                                                                  //       scrollDirection: Axis.horizontal,
                                                                  //       child: Text("${company.unitNO}",
                                                                  //         style: GoogleFonts.poppins(
                                                                  //           color: Colors.black,
                                                                  //           fontSize:15.0,
                                                                  //         ),
                                                                  //       ),
                                                                  //     )
                                                                  // ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text("Tower :", style: GoogleFonts.poppins(
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 17.0,
                                                                  )),
                                                                  SizedBox(width: 5,),
                                                                  // Expanded(
                                                                  //   child: Text("${company.tower}",
                                                                  //     style: GoogleFonts.poppins(
                                                                  //       color: Colors.black,
                                                                  //       fontSize: 15.0,
                                                                  //     ),
                                                                  //     overflow: TextOverflow.ellipsis, // Clip the text if it overflows.
                                                                  //     maxLines: null,
                                                                  //   ),
                                                                  // )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text("Contact Person :", style: GoogleFonts.poppins(
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 17.0,
                                                                  )),
                                                                  SizedBox(width: 5,),
                                                                  Expanded(
                                                                        child: Text("${company.contactName}",
                                                                          style: GoogleFonts.poppins(
                                                                            color: Colors.black,
                                                                            fontSize: 15.0,
                                                                          ),
                                                                          maxLines: 4,
                                                                        ),

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
                                                                      Text("Contact No :", style: GoogleFonts.poppins(
                                                                        color: Colors.black,
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 17.0,
                                                                      )),
                                                                      SizedBox(width: 5,),
                                                                      Flexible(
                                                                        child: Text("${company1.contactNO}",
                                                                          style: GoogleFonts.poppins(
                                                                            color: Colors.black,
                                                                            fontSize: 15.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text("UAG :", style: GoogleFonts.poppins(
                                                                        color: Colors.black,
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 17.0,
                                                                      )),
                                                                      SizedBox(width: 5,),
                                                                      Expanded(
                                                                        child: Text("${company1.UAG}",
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
                                                                      Text("Kiosk Disp Name :", style: GoogleFonts.poppins(
                                                                        color: Colors.black,
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 17.0,
                                                                      )),
                                                                      SizedBox(width: 5,),
                                                                      Flexible(
                                                                        child: Text("${company.displayName}",
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

                                                    ],
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
