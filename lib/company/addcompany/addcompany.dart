import 'package:acp/Provider/Company/Insert_Company_Provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../Provider/Company/DataTable_Provider.dart';
import '../../Provider/Company/Edit_Company_Provider.dart';
import '../../staff/addstaff/addstaffmethods.dart';
import '../../utils/Textform_field.dart';
import '../../utils/colors.dart';
import '../DataTable_Insert.dart';
import '../companyscreen.dart';
import 'datatablecompany.dart';

class Addcompany extends StatefulWidget {
  const Addcompany({super.key});

  @override
  State<Addcompany> createState() => _AddcompanyState();
}
late int id1;
late int id2;
List<String> towers= [];

TextEditingController companyname= TextEditingController();
TextEditingController displayname= TextEditingController();
TextEditingController uag= TextEditingController();
TextEditingController contactname= TextEditingController();
TextEditingController contactno= TextEditingController();
TextEditingController towercompany= TextEditingController();
TextEditingController floor= TextEditingController();
TextEditingController unitno= TextEditingController();
TextEditingController area= TextEditingController();
TextEditingController occupancy= TextEditingController();
TextEditingController staffno= TextEditingController();
late int count;
bool isupdatecompany= false;
bool isaddcompany= false;
bool isSwitchOn = false;
bool isSwitchOn2 = false;
bool isSwitchOn3 = false;
bool isSwitchOn4 = false;
bool viewcompany= false;
bool isedited= false;

String tower11= "";
String unitno11= "";


class _AddcompanyState extends State<Addcompany> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> floors= [];
  List<String> unitnos= [];
  List<String> areas= [];
  List<String> occupancys= [];
  List<String> staffnos= [];
  // DBhelper dBhelper1= DBhelper.db;
  @override
  Widget build(BuildContext context) {
    final insertCompany= Provider.of<InsertCompanyProvider>(context, listen: false);
    final editeCompanyProvider= Provider.of<EditCompanyProvider>(context, listen: false);
    return Material(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: kDarkblueColor,
                  title: viewcompany?Text("Company",
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
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => const Companyscreen(),
                        ),
                      );
                     isadd= false;
                      viewcompany=false;
                      isupdatecompany= false;
                      isedited= false;
                      companyname.clear();
                      displayname.clear();
                      uag.clear();
                      contactname.clear();
                      contactno.clear();
                      towercompany.clear();
                      floor.clear();
                      unitno.clear();
                      area.clear();
                      occupancy.clear();
                      staffno.clear();

                      setState(() {
                        isSwitchOn = false;
                        isSwitchOn2 = false;
                        isSwitchOn3 = false;
                        isSwitchOn4 = false;
                      });
                      isadd=false;
                      viewcompany = false;
                      isupdatecompany= false;
                      isedited= false;
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
                                controller: companyname,
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
                                controller: displayname,
                              )
                            ),
                            Uag1(controller1: uag, hint: "UAG",),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                              child: CustomTextfield(
                                Icons: LineAwesomeIcons.passport_solid,
                                obsuretext: false,
                                lines: 1,
                                errorMsg: 'Contact Name Required',
                                hinttext: 'Contact Name',
                                controller: contactname,
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
                                controller: contactno,
                              ),
                            ),
                            if(viewcompany == false)
                              Stack(
                                children: [
                                  Location(controller1: towercompany, hint: "Tower",),
                                  Positioned(
                                    top: 2.0,
                                      right: 8.0,
                                      child: IconButton(
                                        onPressed: () async {
                                          if(isadd== false && isedited==false && isupdatecompany == false){
                                            Provider.of<DatatableProvider>(context, listen: false).addCompanyData(
                                              tower: towercompany.text,
                                              floor: floor.text,
                                              unitno: unitno.text,
                                              area: area.text,
                                              occupancy: occupancy.text,
                                              staffno: staffno.text,
                                            );

                                              towercompany.clear();
                                              floor.clear();
                                              unitno.clear();
                                              area.clear();
                                              occupancy.clear();
                                              staffno.clear();

                                          }else if(isedited == true && isadd== false && isupdatecompany == false){
                                            Provider.of<DatatableProvider>(context, listen: false).updateCompanyData(
                                              index: id1,
                                              tower: towercompany.text,
                                              floor: floor.text,
                                              unitno: unitno.text,
                                              area: area.text,
                                              occupancy: occupancy.text,
                                              staffno: staffno.text,
                                            );


                                            print("isedit: $isedited");

                                            towercompany.clear();
                                            floor.clear();
                                            unitno.clear();
                                            area.clear();
                                            occupancy.clear();
                                            staffno.clear();

                                          }else if(isupdatecompany== true && isedited== true && viewcompany == false && isadd == false){
                                            Provider.of<DatatableProvider>(context, listen: false).updateCompanyData(
                                              index: id1,
                                              tower: towercompany.text,
                                              floor: floor.text,
                                              unitno: unitno.text,
                                              area: area.text,
                                              occupancy: occupancy.text,
                                              staffno: staffno.text,
                                            );

                                            print("isUpdateCompany: $isupdatecompany");

                                            towercompany.clear();
                                            floor.clear();
                                            unitno.clear();
                                            area.clear();
                                            occupancy.clear();
                                            staffno.clear();

                                          }else if(isupdatecompany== true && isedited== false && viewcompany == false && isadd == false){
                                            Provider.of<DatatableProvider>(context, listen: false).updateCompanyData(
                                              index: id1,
                                              tower: towercompany.text,
                                              floor: floor.text,
                                              unitno: unitno.text,
                                              area: area.text,
                                              occupancy: occupancy.text,
                                              staffno: staffno.text,
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

                            if(viewcompany==true)
                              Location(controller1: towercompany, hint: "Tower",),
                           FloorTextField(controller1: floor, hint: 'Floor'),
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
                                controller: unitno,
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
                                controller: area,
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
                                controller: occupancy,
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
                                controller: staffno,
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
                                    value: isSwitchOn,
                                    onChanged: (bool value) {
                                      setState(() {
                                        isSwitchOn = value;
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
                                    value: isSwitchOn2,
                                    onChanged: (bool value) {
                                      setState(() {
                                        isSwitchOn2 = value;
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
                                    value: isSwitchOn3,
                                    onChanged: (bool value) {
                                      setState(() {
                                        isSwitchOn3 = value;
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
                                    value: isSwitchOn4,
                                    onChanged: (bool value) {
                                      setState(() {
                                        isSwitchOn4 = value;
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
                            if(viewcompany == false && isupdatecompany == false)
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
                            if(viewcompany== true && isupdatecompany == false && isadd== false)
                              const Datatablecompany(),
                            if(isupdatecompany == true && viewcompany == false)
                              Visibility(
                                visible: isupdatecompany,
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
                            if(viewcompany == false)
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: (MediaQuery.of(context).size.height*0.07),
                                  child: ElevatedButton(
                                    onPressed: () async{
                                      if(_formKey.currentState!.validate()){
                                        if(isadd==false && viewcompany == false && isedited == false && isupdatecompany == false){
                                          print("insert");
                                          final value= Provider.of<DatatableProvider>(context,listen: false);
                                           bool isInsert= await insertCompany.addCompany(companyname.text, displayname.text, uag.text,contactname.text,contactno.text, value.towers, value.floors, value.unitnos, value.occupancys, value.areas,value.staffnos, isSwitchOn4, isSwitchOn2, isSwitchOn3, isSwitchOn);
                                           if(isInsert){
                                             Navigator.of(context).pushReplacement(
                                               MaterialPageRoute(
                                                 builder: (BuildContext context) => const Companyscreen(),
                                               ),
                                             );

                                             companyname.clear();
                                             displayname.clear();
                                             uag.clear();
                                             contactname.clear();
                                             contactno.clear();
                                             isSwitchOn = false;
                                             isSwitchOn2 = false;
                                             isSwitchOn3 = false;
                                             isSwitchOn4 = false;
                                           }

                                        }else if(isupdatecompany == true && viewcompany == false && isedited== false){
                                          print("updated");
                                          isupdatecompany = false;
                                          viewcompany= false;

                                          final value= Provider.of<DatatableProvider>(context,listen: false);
                                          await editeCompanyProvider.updateCompany(companyId1,companyname.text, displayname.text, uag.text,contactname.text, contactno.text, value.towers, value.floors, value.unitnos, value.occupancys, value.areas,value.staffnos, isSwitchOn4, isSwitchOn2, isSwitchOn3, isSwitchOn);

                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) => const Companyscreen(),
                                            ),
                                          );
                                          companyname.clear();
                                          displayname.clear();
                                          uag.clear();
                                          contactname.clear();
                                          contactno.clear();

                                          isSwitchOn = false;
                                          isSwitchOn2 = false;
                                          isSwitchOn3 = false;
                                          isSwitchOn4 = false;
                                        }
                                        else if(isupdatecompany== true && isedited== true && viewcompany == false && isadd == false){
                                          print("Done");

                                          isupdatecompany = false;
                                          viewcompany= false;

                                          final value= Provider.of<DatatableProvider>(context,listen: false);
                                          print("towers: ${value.towers}");
                                          bool succeed= await editeCompanyProvider.updateCompany(companyId1,companyname.text, displayname.text, uag.text,contactname.text, contactno.text, value.towers, value.floors, value.unitnos, value.occupancys, value.areas,value.staffnos, isSwitchOn4, isSwitchOn2, isSwitchOn3, isSwitchOn);
                                          if(succeed){
                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                builder: (BuildContext context) => const Companyscreen(),
                                              ),
                                            );
                                            companyname.clear();
                                            displayname.clear();
                                            uag.clear();
                                            contactname.clear();
                                            contactno.clear();

                                            isSwitchOn = false;
                                            isSwitchOn2 = false;
                                            isSwitchOn3 = false;
                                            isSwitchOn4 = false;
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

