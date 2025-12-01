import 'package:acp/Provider/Company/Company_Provider.dart';
import 'package:acp/Provider/Company/Delete_Company_Provider.dart';
import 'package:acp/Provider/Company/Edit_Company_Provider.dart';
import 'package:acp/Provider/Company/View_Company_Provider.dart';
import 'package:acp/staff/database/dbhelper.dart';
import 'package:acp/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../Provider/Company/DataTable_Provider.dart';
import '../Provider/Company/Search_Company_Provider.dart';
import '../appDashboard/dashboard/dashboard.dart';
import 'addcompany/addcompany.dart';
import 'companymethods.dart';


class Companyscreen extends StatefulWidget {
  const Companyscreen({super.key});

  @override
  State<Companyscreen> createState() => _CompanyscreenState();
}

TextEditingController companycodeclass = TextEditingController();
TextEditingController towercodeclass = TextEditingController();
TextEditingController unitnoclass = TextEditingController();
TextEditingController totalcompany= TextEditingController();
TextEditingController allresult= TextEditingController();

bool isadd= false;
bool addingcompany= false;
late String companylistid;
late int viewid;

String companyId1= "";
bool isSearch= false;
class _CompanyscreenState extends State<Companyscreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final companyProvider= Provider.of<CompanyProvider>(context,listen: false);
    final viewCompanyProvider= Provider.of<ViewCompanyProvider>(context, listen: false);
    final deleteCompanyProvider= Provider.of<DeleteCompanyProvider>(context);
    final searchCompany= Provider.of<SearchCompanyProvider>(context);
    print("Company");
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
                  title: Text("Company",
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
                      companycodeclass.clear();
                      towercodeclass.clear();
                      unitnoclass.clear();
                      allcompanydata.clear();
                      isSearch= false;
                      companyID.clear();
                      towerId.clear();
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
                            builder: (BuildContext context) => const Addcompany(),
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
                              const SizedBox(height: 20),
                              Tower(controller1: towercodeclass),
                              Allcompany1(controller1: companycodeclass, hint: "Company",),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                                child: TextFormField(
                                  controller: unitnoclass,
                                  cursorColor: kDarkblueColor,
                                  style: GoogleFonts.poppins(
                                    color: kDarkblueColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                  ),
                                  onChanged: (value) {
                                    isSearch= true;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(18.0),
                                    filled: true,
                                    fillColor:  kGinColor,
                                    prefixIcon: Icon(
                                      LineAwesomeIcons.hashtag_solid,
                                      size: 24.0,
                                      color: kDarkblueColor,
                                    ),
                                    hintText: 'Unit No',
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
                              // SizedBox(height: 10.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0, top: 0.0),
                                child: SizedBox(
                                    width: (MediaQuery.of(context).size.width),
                                    height: (MediaQuery.of(context).size.height),
                                    child: FutureBuilder(
                                            future: isSearch? searchCompany.searchCompany(companyID, towerId, unitnoclass.text):companyProvider.getCompany(towercodeclass.text,companycodeclass.text, unitnoclass.text),
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
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                                          child: Consumer<CompanyProvider>(
                                                            builder: (BuildContext context, CompanyProvider value, Widget? child) {
                                                              return Text(
                                                                "Total Company : ${isSearch?searchCompany.companycount: value.count}",
                                                                style: GoogleFonts.poppins(
                                                                  color: kDarkblueColor,
                                                                  fontSize: 18.0,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Expanded(
                                                      child: Consumer<CompanyProvider>(
                                                        builder: (context, value, child) {
                                                          return ListView.builder(
                                                            padding: EdgeInsets.zero,
                                                            controller: _scrollController,
                                                            itemCount: isSearch? searchCompany.searchList.length:value.allCompanydate.length,
                                                            itemBuilder:(context, index) {
                                                              final company= isSearch?searchCompany.searchList[index]: value.allCompanydate[index];
                                                              return Card(
                                                                color: kGinColor2,
                                                                child:  Padding(
                                                                  padding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0, top: 0.0),
                                                                  child: Stack(
                                                                    children: [
                                                                      ExpansionTile(
                                                                        trailing: const SizedBox.shrink(),
                                                                        title: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Flex(
                                                                              direction: Axis.horizontal,
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: (MediaQuery.of(context).size.width*0.73),
                                                                                  child: Row(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Icon(LineAwesomeIcons.building),
                                                                                      SizedBox(width: 10,),
                                                                                      Expanded(
                                                                                        child: Text(
                                                                                          company.companyName ?? '',
                                                                                          softWrap: true,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          style: GoogleFonts.poppins(
                                                                                            color: Colors.black,
                                                                                            fontSize: 15.0,
                                                                                          ),
                                                                                        ),
                                                                                      ),

                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(height: 10),
                                                                            Row(
                                                                              children: [
                                                                                Icon(Icons.cell_tower),
                                                                                SizedBox(width: 10),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    company.towerIds?? '',
                                                                                    style: const TextStyle(
                                                                                      color: Colors.black,
                                                                                      fontSize: 15.0,
                                                                                    ),
                                                                                    maxLines: null,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(height: 5,),
                                                                            Row(
                                                                              children: [
                                                                                Icon(LineAwesomeIcons.hashtag_solid),
                                                                                SizedBox(width: 5),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    company.unitNos?? '',
                                                                                    style: const TextStyle(
                                                                                      color: Colors.black,
                                                                                      fontSize: 15.0,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),

                                                                            SizedBox(height: 5,),
                                                                            Row(
                                                                              children: [
                                                                                Flex(
                                                                                  direction: Axis.horizontal,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: 150,
                                                                                      // height: 50,
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Icon(LineAwesomeIcons.user),
                                                                                          SizedBox(width: 5,),
                                                                                          Expanded(
                                                                                            child: Text(company.contactPerson ?? '',
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                              softWrap: true,
                                                                                              style: GoogleFonts.poppins(
                                                                                                color: Colors.black,
                                                                                                fontSize:15.0,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),

                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(width: 20,),
                                                                                Row(
                                                                                  children: [
                                                                                    Icon(Icons.phone),
                                                                                    SizedBox(width: 5,),
                                                                                    Text(company.contactNo?? '',
                                                                                      style: GoogleFonts.poppins(
                                                                                        color: Colors.black,
                                                                                        fontSize: 15.0,
                                                                                      ),
                                                                                      softWrap: true,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            // SizedBox(height: 20.0),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                          top: 1.0,
                                                                          right: 4.0,
                                                                          child: SizedBox(
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
                                                                                        companyId1= company.companyId!;
                                                                                         companylistid= companyId1;
                                                                                        await viewCompanyProvider.viewCompanyList(companyId1);
                                                                                        if(viewCompanyProvider.viewCompanyData.isNotEmpty){
                                                                                          final viewCompany= viewCompanyProvider.viewCompanyData[0];
                                                                                        companyname.text= viewCompany.companyName?? '';
                                                                                        displayname.text= viewCompany.kioskDisplayName?? '';
                                                                                        // uag.text= viewCompany.uag?? '';
                                                                                        contactname.text= viewCompany.contactPerson?? '';
                                                                                        contactno.text= viewCompany.contactNo?? '';


                                                                                          viewCompany.companySp =="1"? isSwitchOn= true : false;
                                                                                          viewCompany.companySr =="1"? isSwitchOn2 = true : false;
                                                                                          viewCompany.companyVendor == "1"? isSwitchOn3 =true : false;
                                                                                          viewCompany.showVms =="1" ? isSwitchOn4= true : false;

                                                                                        viewcompany= true;

                                                                                        Navigator.of(context).pushReplacement(
                                                                                          MaterialPageRoute(
                                                                                            builder: (BuildContext context) =>  const Addcompany(),
                                                                                          ),
                                                                                        );
                                                                                        }

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
                                                                                        companyId1= company.companyId!;
                                                                                        companylistid= companyId1;
                                                                                        await viewCompanyProvider.viewCompanyList(companyId1);
                                                                                        if(viewCompanyProvider.viewCompanyData.isNotEmpty){
                                                                                          final viewCompany= viewCompanyProvider.viewCompanyData[0];
                                                                                          companyname.text= viewCompany.companyName?? '';
                                                                                          displayname.text= viewCompany.kioskDisplayName?? '';
                                                                                          // uag.text= viewCompany.uag?? '';
                                                                                          contactname.text= viewCompany.contactPerson?? '';
                                                                                          contactno.text= viewCompany.contactNo?? '';

                                                                                          viewCompany.companySp =="1"? isSwitchOn= true : false;
                                                                                          viewCompany.companySr =="1"? isSwitchOn2 = true : false;
                                                                                          viewCompany.companyVendor == "1"? isSwitchOn3 =true : false;
                                                                                          viewCompany.showVms =="1" ? isSwitchOn4= true : false;

                                                                                          // Split the values by comma
                                                                                          List<String>? towers = viewCompany.towerId?.split(',');
                                                                                          List<String>? floors = viewCompany.floorId?.split(',');
                                                                                          List<String>? unitNos = viewCompany.unitNo?.split(',');
                                                                                          List<String>? areas = viewCompany.area?.split(',');
                                                                                          List<String>? occupancies = viewCompany.occupancy?.split(',');
                                                                                          List<String>? staffNos = viewCompany.noOfStaff?.split(',');

                                                                                          // Clear previous data in the DatatableProvider before adding new data
                                                                                          Provider.of<DatatableProvider>(context, listen: false).clearData();

                                                                                          // Insert each row in the DataTable by iterating through the list of towers
                                                                                          for (int i = 0; i < towers!.length; i++) {
                                                                                            Provider.of<DatatableProvider>(context, listen: false).addCompanyData(
                                                                                              tower: towers[i].trim(),        // Add tower
                                                                                              floor: floors![i].trim(),        // Add corresponding floor
                                                                                              unitno: unitNos![i].trim(),      // Add corresponding unit no
                                                                                              area: areas![i].trim(),          // Add corresponding area
                                                                                              occupancy: occupancies![i].trim(), // Add corresponding occupancy
                                                                                              staffno: staffNos![i].trim(),    // Add corresponding staff number
                                                                                            );
                                                                                          }

                                                                                          isupdatecompany= true;
                                                                                          Navigator.of(context).pushReplacement(
                                                                                            MaterialPageRoute(
                                                                                              builder: (BuildContext context) =>  const Addcompany(),
                                                                                            ),
                                                                                          );
                                                                                        }

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
                                                                                      onTap: () async{
                                                                                        companyId1= company.companyId!;
                                                                                        await deleteCompanyProvider.deleteCompany(companyId1);
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                    ),
                                                                                  ),


                                                                                ];
                                                                              },

                                                                            ),
                                                                          )
                                                                      ),
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
                                          ),
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
