import 'package:acp/Provider/Company/Company_Provider.dart';
import 'package:acp/Provider/Company/Insert_Company_Provider.dart';
import 'package:acp/login/userPreference.dart';
import 'package:acp/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../Provider/Company/DataTable_Provider.dart';
import '../appDashboard/dashboard/dashboard.dart';
import 'addcompany/addcompany.dart';
import 'companymethods.dart';


class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  final FocusNode companyFocus = FocusNode();
  final FocusNode towerFocus = FocusNode();
  final FocusNode unitNoFocus = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchCompanyListing();
    });
  }

  Future<void> _fetchCompanyListing() async {
    final companyProvider = context.read<CompanyProvider>();
    await companyProvider.getCompany();
  }


  @override
  Widget build(BuildContext context) {
    final companyProvider= Provider.of<CompanyProvider>(context,listen: false);
    return Material(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: CustomScrollView(
              slivers:<Widget>[
                SliverAppBar(
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
                      companyProvider.companyCodeClass.clear();
                      companyProvider.towerCodeClass.clear();
                      companyProvider.unitNoClass.clear();
                      allCompanyData.clear();

                      // companyProvider.isSearch= false;
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
                        Provider.of<DatatableProvider>(context, listen: false).clearData();

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) => const AddCompany(),
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
                              Tower(controller1: companyProvider.towerCodeClass, focusNode: towerFocus,),
                              AllCompany1(controller1: companyProvider.companyCodeClass, hint: "Company",focusNode: companyFocus),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                                child: TextFormField(
                                  controller: companyProvider.unitNoClass,
                                  focusNode: unitNoFocus,
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
                              SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async{
                                      final companyProvider = context.read<CompanyProvider>();
                                      await companyProvider.searchCompany(
                                        towerId,
                                        companyID,
                                        companyProvider.unitNoClass.text,
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
                                      towerFocus.unfocus();
                                      companyFocus.unfocus();
                                      unitNoFocus.unfocus();

                                      towerId.clear();
                                      companyID.clear();
                                      companyProvider.unitNoClass.clear();

                                      companyProvider.clearController();
                                      companyProvider.isSearchResult = false;
                                      companyProvider.getCompany();
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
                                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0, top: 0.0),
                                child: SizedBox(
                                    width: (MediaQuery.of(context).size.width),
                                    height: (MediaQuery.of(context).size.height),
                                  child: Consumer<CompanyProvider>(
                                      builder: (context, value, child) {
                                        if (value.isDeleting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        if (value.isLoadingList || value.isSearching) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                                  child: Text(
                                                    "Total Company : ${value.isSearchResult ?value.companyCount: value.totalCompanyList}",
                                                    style: GoogleFonts.poppins(
                                                      color: kDarkblueColor,
                                                      fontSize: 18.0,
                                                    ),
                                                  )
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Expanded(
                                                child: ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  controller: _scrollController,
                                                  itemCount: value.isSearchResult ? value.searchList.length:value.allCompanyDate.length,
                                                  itemBuilder:(context, index) {
                                                    final company= value.isSearchResult ?value.searchList[index]: value.allCompanyDate[index];
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
                                                                                company.company ?? '',
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
                                                                          company.towerString?? '',
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
                                                                          company.unitNoString?? '',
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
                                                      Consumer<InsertCompanyProvider>(
                                                        builder: (context, value, child) {
                                                          return Positioned(
                                                            top: 1.0,
                                                            right: 4.0,
                                                            child: PopupMenuButton<String>(
                                                              icon: const Icon(Icons.more_horiz),
                                                              onSelected: (selected) async {

                                                                if (selected == 'view') {
                                                                  companyProvider.companyId1 = company.companyID!.toString();
                                                                  companyProvider.companyListId = companyProvider.companyId1;
                                                                  await companyProvider.viewCompanyList(companyProvider.companyId1);
                                                                  value.companyName.text = company.company ?? '';
                                                                  value.displayName.text = company.kioskDisplayName ?? '';
                                                                  value.uag.text = company.uAGS ?? '';
                                                                  value.contactName.text = company.contactPerson ?? '';
                                                                  value.contactNo.text = company.contactNo ?? '';

                                                                  value.isSwitchOn = company.companySP == "1";
                                                                  value.isSwitchOn2 = company.companySR == "1";
                                                                  value.isSwitchOn3 = company.companyVendor == "1";
                                                                  value.isSwitchOn4 = company.showVMS == "1";

                                                                  value.viewCompany = true;
                                                                  value.isUpdateCompany = false;

                                                                  Navigator.of(context).pushReplacement(
                                                                    MaterialPageRoute(
                                                                      builder: (context) => const AddCompany(),
                                                                    ),
                                                                  );
                                                                }

                                                                if (selected == 'edit') {
                                                                  companyProvider.companyId1 = company.companyID!.toString();
                                                                  companyProvider.companyListId = companyProvider.companyId1;
                                                                  await companyProvider.viewCompanyList(companyProvider.companyId1);

                                                                  value.companyName.text = company.company ?? '';
                                                                  value.displayName.text = company.kioskDisplayName ?? '';
                                                                  value.uag.text = company.uAGS ?? '';
                                                                  value.contactName.text = company.contactPerson ?? '';
                                                                  value.contactNo.text = company.contactNo ?? '';

                                                                  value.isSwitchOn = company.companySP == "1";
                                                                  value.isSwitchOn2 = company.companySR == "1";
                                                                  value.isSwitchOn3 = company.companyVendor == "1";
                                                                  value.isSwitchOn4 = company.showVMS == "1";

                                                                  final tableProvider =
                                                                  Provider.of<DatatableProvider>(context, listen: false);

                                                                  tableProvider.clearData();

                                                                  for (var item in companyProvider.viewCompanyData) {
                                                                    tableProvider.addCompanyData(
                                                                      id: item.id!,
                                                                      tower: item.towerID.toString(),
                                                                      floor: item.floorID.toString(),
                                                                      unitno: item.unitNo ?? '',
                                                                      area: item.area ?? '',
                                                                      occupancy: item.occupancy ?? '',
                                                                      staffno: item.noOfStaff ?? '',
                                                                    );
                                                                  }

                                                                  value.isUpdateCompany = true;
                                                                  value.viewCompany = false;

                                                                  Navigator.of(context).pushReplacement(
                                                                    MaterialPageRoute(
                                                                      builder: (context) => const AddCompany(),
                                                                    ),
                                                                  );
                                                                }

                                                                if (selected == 'delete') {
                                                                  UserPreference user = UserPreference();
                                                                  companyProvider.companyId1 = company.companyID.toString();
                                                                  String userID = await user.getUserId();
                                                                  await companyProvider.deleteCompanyById(companyProvider.companyId1, userID);
                                                                }
                                                              },

                                                              itemBuilder: (context) => [

                                                                PopupMenuItem(
                                                                  value: 'view',
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(Icons.remove_red_eye, size: 20, color: kDarkblueColor),
                                                                      const SizedBox(width: 10),
                                                                      Text(
                                                                        'View',
                                                                        style: GoogleFonts.poppins(
                                                                          color: Colors.black,
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 17.0,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),

                                                                PopupMenuItem(
                                                                  value: 'edit',
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(Icons.edit, size: 20, color: kDarkblueColor),
                                                                      const SizedBox(width: 10),
                                                                      Text(
                                                                        'Edit',
                                                                        style: GoogleFonts.poppins(
                                                                          color: Colors.black,
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 17.0,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),

                                                                PopupMenuItem(
                                                                  value: 'delete',
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(Icons.delete, size: 20, color: kDarkblueColor),
                                                                      const SizedBox(width: 10),
                                                                      Text(
                                                                        'Delete',
                                                                        style: GoogleFonts.poppins(
                                                                          color: Colors.black,
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 17.0,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      )
                                                            // Consumer<InsertCompanyProvider>(
                                                            //   builder: (context, value, child) {
                                                            //     return Positioned(
                                                            //         top: 1.0,
                                                            //         right: 4.0,
                                                            //         child: SizedBox(
                                                            //           child: PopupMenuButton(
                                                            //             icon: Icon(Icons.more_horiz),
                                                            //             itemBuilder: (context) {
                                                            //               return [
                                                            //                 PopupMenuItem(
                                                            //                   value: 'view',
                                                            //                   child: InkWell(
                                                            //                     child: Row(
                                                            //                       children: [
                                                            //                         Icon(Icons.remove_red_eye, size: 20,color: kDarkblueColor,),
                                                            //                         const SizedBox(
                                                            //                           width: 10,
                                                            //                         ),
                                                            //                         Text('View', style: GoogleFonts.poppins(
                                                            //                           color: Colors.black,
                                                            //                           fontWeight: FontWeight.w500,
                                                            //                           fontSize: 17.0,
                                                            //                         )),
                                                            //                       ],
                                                            //                     ),
                                                            //                     onTap: () async{
                                                            //                       //For update
                                                            //                       companyProvider.companyId1= company.companyID!.toString();
                                                            //                       //For View
                                                            //                       companyProvider.companyListId= companyProvider.companyId1;
                                                            //                       await companyProvider.viewCompanyList(companyProvider.companyId1);
                                                            //
                                                            //                       value.companyName.text= company.company?? '';
                                                            //                       value.displayName.text= company.kioskDisplayName?? '';
                                                            //                       value.uag.text= company.uAGS?? '';
                                                            //                       value.contactName.text= company.contactPerson?? '';
                                                            //                       value.contactNo.text= company.contactNo?? '';
                                                            //
                                                            //                       company.companySP =="1"? value.isSwitchOn= true : false;
                                                            //                       company.companySR =="1"? value.isSwitchOn2 = true : false;
                                                            //                       company.companyVendor == "1"? value.isSwitchOn3 =true : false;
                                                            //                       company.showVMS =="1" ? value.isSwitchOn4= true : false;
                                                            //
                                                            //                       value.viewCompany= true;
                                                            //                       value.isUpdateCompany= false;
                                                            //
                                                            //                       Navigator.of(context).pushReplacement(
                                                            //                         MaterialPageRoute(
                                                            //                           builder: (BuildContext context) =>  const AddCompany(),
                                                            //                         ),
                                                            //                       );
                                                            //
                                                            //                     },
                                                            //                   ),
                                                            //                 ),
                                                            //                 PopupMenuItem(
                                                            //                   value: 'edit',
                                                            //                   child: InkWell(
                                                            //                     child: Row(
                                                            //                       children: [
                                                            //                         Icon(Icons.edit, size: 20,color: kDarkblueColor,),
                                                            //                         const SizedBox(
                                                            //                           width: 10,
                                                            //                         ),
                                                            //                         Text('Edit', style: GoogleFonts.poppins(
                                                            //                           color: Colors.black,
                                                            //                           fontWeight: FontWeight.w500,
                                                            //                           fontSize: 17.0,
                                                            //                         )),
                                                            //                       ],
                                                            //                     ),
                                                            //                     onTap: () async{
                                                            //                       companyProvider.companyId1= company.companyID!.toString();
                                                            //                       companyProvider.companyListId= companyProvider.companyId1;
                                                            //                       await companyProvider.viewCompanyList(companyProvider.companyId1);
                                                            //
                                                            //                         value.companyName.text= company.company?? '';
                                                            //                         value.displayName.text= company.kioskDisplayName?? '';
                                                            //                         value.uag.text= company.uAGS?? '';
                                                            //                         value.contactName.text= company.contactPerson?? '';
                                                            //                         value.contactNo.text= company.contactNo?? '';
                                                            //
                                                            //                         company.companySP =="1"? value.isSwitchOn= true : false;
                                                            //                         company.companySR =="1"? value.isSwitchOn2 = true : false;
                                                            //                         company.companyVendor == "1"? value.isSwitchOn3 =true : false;
                                                            //                         company.showVMS =="1" ? value.isSwitchOn4= true : false;
                                                            //
                                                            //                       final tableProvider = Provider.of<DatatableProvider>(context, listen: false);
                                                            //                       tableProvider.clearData();
                                                            //
                                                            //                       for (var item in companyProvider.viewCompanyData) {
                                                            //                         tableProvider.addCompanyData(
                                                            //                           id: item.id!,
                                                            //                           tower: item.towerID.toString(),
                                                            //                           floor: item.floorID.toString(),
                                                            //                           unitno: item.unitNo ?? '',
                                                            //                           area: item.area ?? '',
                                                            //                           occupancy: item.occupancy ?? '',
                                                            //                           staffno: item.noOfStaff ?? '',
                                                            //                         );
                                                            //                       }
                                                            //                         value.isUpdateCompany= true;
                                                            //                         value.viewCompany= false;
                                                            //
                                                            //                         Navigator.of(context).pushReplacement(
                                                            //                           MaterialPageRoute(
                                                            //                             builder: (BuildContext context) =>  const AddCompany(),
                                                            //                           ),
                                                            //                         );
                                                            //
                                                            //
                                                            //                     },
                                                            //                   ),
                                                            //                 ),
                                                            //                 PopupMenuItem(
                                                            //                   value: 'delete',
                                                            //                   child: InkWell(
                                                            //                     child: Row(
                                                            //                       children: [
                                                            //                         Icon(Icons.delete, size: 20,color: kDarkblueColor,),
                                                            //                         const SizedBox(
                                                            //                           width: 10,
                                                            //                         ),
                                                            //                         Text('Delete', style: GoogleFonts.poppins(
                                                            //                           color: Colors.black,
                                                            //                           fontWeight: FontWeight.w500,
                                                            //                           fontSize: 17.0,
                                                            //                         )),
                                                            //                       ],
                                                            //                     ),
                                                            //                     onTap: () async{
                                                            //                       UserPreference user= UserPreference();
                                                            //                       companyProvider.companyId1= company.companyID.toString();
                                                            //                       String userID= await user.getUserId();
                                                            //                       await companyProvider.deleteCompanyById(companyProvider.companyId1, userID);
                                                            //                       Navigator.pop(context);
                                                            //                       // if (isDeleted) {
                                                            //                       //   if (companyProvider.isSearch) {
                                                            //                       //     // await _searchCompanyListing();
                                                            //                       //   } else {
                                                            //                       //     await _fetchCompanyListing();
                                                            //                       //   }
                                                            //                       // }
                                                            //                     },
                                                            //                   ),
                                                            //                 ),
                                                            //
                                                            //
                                                            //               ];
                                                            //             },
                                                            //
                                                            //           ),
                                                            //         )
                                                            //     );
                                                            //   },
                                                            // ),

                                                          ],
                                                        ),
                                                      ),

                                                    );
                                                  },
                                                )
                                            ),
                                          ],
                                        );
                                      },
                                  ),
                                ),
                              ),
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
