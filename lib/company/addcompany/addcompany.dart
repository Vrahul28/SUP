import 'package:acp/Provider/Company/Company_Provider.dart';
import 'package:acp/Provider/Company/Insert_Company_Provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../Provider/Company/DataTable_Provider.dart';
import '../../staff/addstaff/addstaffmethods.dart';
import '../../utils/Textform_field.dart';
import '../../utils/colors.dart';
import '../DataTable_Insert.dart';
import '../companyscreen.dart';
import 'datatablecompany.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({super.key});

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final companyPro= context.read<CompanyProvider>();
    final company= Provider.of<InsertCompanyProvider>(context, listen: false);
    return Material(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: kDarkblueColor,
                  title: company.viewCompany?Text("Company",
                    style: GoogleFonts.poppins(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ): Text("Add Company",
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
                      Navigator.pop(context);
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) => const CompanyScreen(),
                      //   ),
                      // );
                      companyPro.isAdd= false;

                      company.viewCompany=false;
                      company.isUpdateCompany= false;
                      company.isEdited= false;

                      company.clearController();

                      setState(() {
                        company.isSwitchOn = false;
                        company.isSwitchOn2 = false;
                        company.isSwitchOn3 = false;
                        company.isSwitchOn4 = false;
                      });
                      companyPro.isAdd=false;
                      company.viewCompany = false;
                      company.isUpdateCompany= false;
                      company.isEdited= false;
                    },
                  ),
                ),

              SliverList(
                  delegate: SliverChildListDelegate(
                      [
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                              child: CustomTextfield(
                                Icons: LineAwesomeIcons.building,
                                obsuretext: false,
                                lines: 1,
                                errorMsg: 'Company Name Required',
                                hinttext: 'Company Name',
                                controller: company.companyName,
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                              child: CustomTextfield(
                                Icons: Icons.line_axis_sharp,
                                obsuretext: false,
                                lines: 1,
                                errorMsg: 'Kiosk Display Name Required',
                                hinttext: 'Kiosk Display Name',
                                controller: company.displayName,
                              )
                            ),
                            Uag1(controller1: company.uag, hint: "UAG",),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                              child: CustomTextfield(
                                Icons: LineAwesomeIcons.passport_solid,
                                obsuretext: false,
                                lines: 1,
                                errorMsg: 'Contact Name Required',
                                hinttext: 'Contact Name',
                                controller: company.contactName,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                              child: CustomTextfield(
                                Icons: Icons.contact_page_outlined,
                                obsuretext: false,
                                lines: 1,
                                errorMsg: 'Contact No. Required',
                                hinttext: 'Contact No.',
                                controller: company.contactNo,
                              ),
                            ),
                            if(company.viewCompany == false)
                              Stack(
                                children: [
                                  Location(controller1: company.towerCompany, hint: "Tower",),
                                  Positioned(
                                    top: 2.0,
                                      right: 8.0,
                                      child: IconButton(
                                        onPressed: () async {
                                          if(companyPro.isAdd== false && company.isEdited==false && company.isUpdateCompany == false){
                                            Provider.of<DatatableProvider>(context, listen: false).addCompanyData(
                                              tower: company.towerCompany.text,
                                              floor: company.floor.text,
                                              unitno: company.unitNo.text,
                                              area: company.area.text,
                                              occupancy: company.occupancy.text,
                                              staffno: company.staffNo.text,
                                            );

                                            company.towerCompany.clear();
                                            company.floor.clear();
                                            company.unitNo.clear();
                                            company.area.clear();
                                            company.occupancy.clear();
                                            company.staffNo.clear();

                                          }else if(company.isEdited == true && companyPro.isAdd== false && company.isUpdateCompany == false){
                                            Provider.of<DatatableProvider>(context, listen: false).updateCompanyData(
                                              index: company.id1,
                                              tower: company.towerCompany.text,
                                              floor: company.floor.text,
                                              unitno: company.unitNo.text,
                                              area: company.area.text,
                                              occupancy: company.occupancy.text,
                                              staffno: company.staffNo.text,
                                            );


                                            debugPrint("isedit: ${company.isEdited}");

                                            company.towerCompany.clear();
                                            company.floor.clear();
                                            company.unitNo.clear();
                                            company.area.clear();
                                            company.occupancy.clear();
                                            company.staffNo.clear();

                                          }else if(company.isUpdateCompany== true && company.isEdited== true && company.viewCompany == false && companyPro.isAdd == false){
                                            Provider.of<DatatableProvider>(context, listen: false).updateCompanyData(
                                              index: company.id1,
                                              tower: company.towerCompany.text,
                                              floor: company.floor.text,
                                              unitno: company.unitNo.text,
                                              area: company.area.text,
                                              occupancy: company.occupancy.text,
                                              staffno: company.staffNo.text,
                                            );

                                            debugPrint("isUpdateCompany: ${company.isUpdateCompany}");

                                            company.towerCompany.clear();
                                            company.floor.clear();
                                            company.unitNo.clear();
                                            company.area.clear();
                                            company.occupancy.clear();
                                            company.staffNo.clear();

                                          }else if(company.isUpdateCompany== true && company.isEdited== false && company.viewCompany == false && companyPro.isAdd == false){
                                            Provider.of<DatatableProvider>(context, listen: false).updateCompanyData(
                                              index: company.id1,
                                              tower: company.towerCompany.text,
                                              floor: company.floor.text,
                                              unitno: company.unitNo.text,
                                              area: company.area.text,
                                              occupancy: company.occupancy.text,
                                              staffno: company.staffNo.text,
                                            );
                                          }
                                        },
                                        icon: Icon(
                                          Icons.add_circle_outline,
                                          color: kDarkblueColor,
                                          size:40,
                                        ),
                                      )
                                  )
                                ],
                              ),

                            if(company.viewCompany==true)
                              Location(controller1: company.towerCompany, hint: "Tower",),
                           FloorTextField(controller1: company.floor, hint: 'Floor'),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                              child: TextFormField(
                                cursorColor: kDarkblueColor,
                                style: GoogleFonts.poppins(
                                  color: kDarkblueColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                ),
                                keyboardType: TextInputType.number,
                                controller: company.unitNo,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(18.0),
                                  filled: true,
                                  fillColor:  kGinColor,
                                  prefixIcon: Icon(
                                    Icons.format_line_spacing,
                                    size: 24.0,
                                    color: kDarkblueColor,
                                  ),
                                  hintText: 'Unit No.',
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
                                cursorColor: kDarkblueColor,
                                style: GoogleFonts.poppins(
                                  color: kDarkblueColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                ),
                                keyboardType: TextInputType.number,
                                controller: company.area,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(18.0),
                                  filled: true,
                                  fillColor:  kGinColor,
                                  prefixIcon: Icon(
                                    Icons.aspect_ratio,
                                    size: 24.0,
                                    color: kDarkblueColor,
                                  ),
                                  hintText: 'Area',
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
                                cursorColor: kDarkblueColor,
                                style: GoogleFonts.poppins(
                                  color: kDarkblueColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                ),
                                keyboardType: TextInputType.number,
                                controller: company.occupancy,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(18.0),
                                  filled: true,
                                  fillColor:  kGinColor,
                                  prefixIcon: Icon(
                                    Icons.person_pin_rounded,
                                    size: 24.0,
                                    color: kDarkblueColor,
                                  ),
                                  hintText: 'Occupancy',
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
                                cursorColor: kDarkblueColor,
                                style: GoogleFonts.poppins(
                                  color: kDarkblueColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                ),
                                keyboardType: TextInputType.number,
                                controller: company.staffNo,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(18.0),
                                  filled: true,
                                  fillColor:  kGinColor,
                                  prefixIcon: Icon(
                                    Icons.perm_contact_cal_sharp,
                                    size: 24.0,
                                    color: kDarkblueColor,
                                  ),
                                  hintText: 'Staff No.',
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
                                    value: company.isSwitchOn,
                                    onChanged: (bool value) {
                                      setState(() {
                                        company.isSwitchOn = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Suntec Reit(SR)",
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
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                              child: Row(
                                children: [
                                  CupertinoSwitch(
                                    trackColor: Colors.white,
                                    activeColor: kDarkblueColor,
                                    value: company.isSwitchOn2,
                                    onChanged: (bool value) {
                                      setState(() {
                                        company.isSwitchOn2 = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Suntec Property(SP)",
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
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                              child: Row(
                                children: [
                                  CupertinoSwitch(
                                    trackColor: Colors.white,
                                    activeColor: kDarkblueColor,
                                    value: company.isSwitchOn3,
                                    onChanged: (bool value) {
                                      setState(() {
                                        company.isSwitchOn3 = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Vendor ",
                                        style: GoogleFonts.poppins(
                                          color: kDarkblueColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.0,
                                        ),

                                      ),

                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                              child: Row(
                                children: [
                                  CupertinoSwitch(
                                    trackColor: Colors.white,
                                    activeColor: kDarkblueColor,
                                    value: company.isSwitchOn4,
                                    onChanged: (bool value) {
                                      setState(() {
                                        company.isSwitchOn4 = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        text: "VMS",
                                        style: GoogleFonts.poppins(
                                          color: kDarkblueColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if(company.viewCompany == false && company.isUpdateCompany == false)
                              Consumer<DatatableProvider>(builder: (context, value, child) {
                                 return  DatatableInsert(
                                   length: value.towers.length,
                                   towers: value.towers,
                                   floors: value.floors,
                                   areas: value.areas,
                                   occupancies: value.occupancys,
                                   unitNos: value.unitnos,
                                   staffNos: value.staffnos,
                                 ) ;
                               }),
                            if(company.viewCompany== true && company.isUpdateCompany == false && companyPro.isAdd== false)
                              const DatatableCompany(),
                            if(company.isUpdateCompany == true && company.viewCompany == false)
                              Visibility(
                                visible: company.isUpdateCompany,
                                  child: Consumer<DatatableProvider>(builder: (context, value, child) {
                                    return  DatatableInsert(
                                      length: value.towers.length,
                                      towers: value.towers,
                                      floors: value.floors,
                                      areas: value.areas,
                                      occupancies: value.occupancys,
                                      unitNos: value.unitnos,
                                      staffNos: value.staffnos,
                                    ) ;
                                  }),
                              ),

                            const SizedBox(
                              height: 20,
                            ),
                            if(company.viewCompany == false)
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: (MediaQuery.of(context).size.height*0.07),
                                  child: ElevatedButton(
                                    onPressed: () async{
                                      if(_formKey.currentState!.validate()){
                                        if(companyPro.isAdd==false && company.viewCompany == false && company.isEdited == false && company.isUpdateCompany == false){
                                          debugPrint("insert");
                                          final value= Provider.of<DatatableProvider>(context,listen: false);
                                           bool isInsert= await company.addCompany(
                                               company.companyName.text,
                                               company.displayName.text,
                                               company.uag.text,
                                               company.contactName.text,
                                               company.contactNo.text,
                                               value.towers,
                                               value.floors,
                                               value.unitnos,
                                               value.occupancys,
                                               value.areas,
                                               value.staffnos,
                                               company.isSwitchOn4,
                                               company.isSwitchOn2,
                                               company.isSwitchOn3,
                                               company.isSwitchOn
                                           );

                                           if(isInsert){
                                             Navigator.of(context).pushReplacement(
                                               MaterialPageRoute(
                                                 builder: (BuildContext context) => const CompanyScreen(),
                                               ),
                                             );

                                             company.companyName.clear();
                                             company.displayName.clear();
                                             company.uag.clear();
                                             company.contactName.clear();
                                             company.contactNo.clear();

                                             company.isSwitchOn = false;
                                             company.isSwitchOn2 = false;
                                             company.isSwitchOn3 = false;
                                             company.isSwitchOn4 = false;
                                           }

                                        }else if(company.isUpdateCompany == true && company.viewCompany == false && company.isEdited== false){
                                          debugPrint("updated");
                                          company.isUpdateCompany = false;
                                          company.viewCompany= false;

                                          final value= Provider.of<DatatableProvider>(context,listen: false);
                                          await company.updateCompany(
                                              companyPro.companyId1,
                                              company.companyName.text,
                                              company.displayName.text,
                                              company.uag.text,
                                              company.contactName.text,
                                              company.contactNo.text,
                                              value.towers,
                                              value.floors,
                                              value.unitnos,
                                              value.occupancys,
                                              value.areas,
                                              value.staffnos,
                                              company.isSwitchOn4,
                                              company.isSwitchOn2,
                                              company.isSwitchOn3,
                                              company.isSwitchOn
                                          );

                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) => const CompanyScreen(),
                                            ),
                                          );
                                          company.companyName.clear();
                                          company.displayName.clear();
                                          company.uag.clear();
                                          company.contactName.clear();
                                          company.contactNo.clear();

                                          company.isSwitchOn = false;
                                          company.isSwitchOn2 = false;
                                          company.isSwitchOn3 = false;
                                          company.isSwitchOn4 = false;
                                        }
                                        else if(company.isUpdateCompany== true && company.isEdited== true && company.viewCompany == false && companyPro.isAdd == false){
                                          debugPrint("Done");

                                          company.isUpdateCompany = false;
                                          company.viewCompany= false;

                                          final value= Provider.of<DatatableProvider>(context,listen: false);
                                          debugPrint("towers: ${value.towers}");

                                          bool succeed= await company.updateCompany(
                                              companyPro.companyId1,
                                              company.companyName.text,
                                              company.displayName.text,
                                              company.uag.text,
                                              company.contactName.text,
                                              company.contactNo.text,
                                              value.towers,
                                              value.floors,
                                              value.unitnos,
                                              value.occupancys,
                                              value.areas,
                                              value.staffnos,
                                              company.isSwitchOn4,
                                              company.isSwitchOn2,
                                              company.isSwitchOn3,
                                              company.isSwitchOn
                                          );

                                          if(succeed){
                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                builder: (BuildContext context) => const CompanyScreen(),
                                              ),
                                            );
                                            company.companyName.clear();
                                            company.displayName.clear();
                                            company.uag.clear();
                                            company.contactName.clear();
                                            company.contactNo.clear();

                                            company.isSwitchOn = false;
                                            company.isSwitchOn2 = false;
                                            company.isSwitchOn3 = false;
                                            company.isSwitchOn4 = false;
                                          }

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
}

