import 'package:acp/visitor_details_report/select_source_field.dart';
import 'package:acp/visitor_details_report/visitor_details_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Provider/visitor_details_report_provider/visitor_details_report_provider.dart';
import '../staff/addstaff/addstaffmethods.dart';
import '../utils/Textform_field.dart';
import '../utils/colors.dart';

class VisitorDetailsReport extends StatefulWidget {
  const VisitorDetailsReport({super.key});

  @override
  State<VisitorDetailsReport> createState() => _VisitorDetailsReportState();
}

class _VisitorDetailsReportState extends State<VisitorDetailsReport> {
  late final searchVisitor= Provider.of<VisitorDetailsReportProvider>(context, listen: false);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formKey,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: kDarkblueColor,
                title: Text("Visitor Details Report",
                  style: GoogleFonts.poppins(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
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
                    searchVisitor.clearController();
                  },
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(
                        height: 20,
                      ),
                      SelectSourceField(controller1: searchVisitor.selectSource, hint: "Select Source",),
                      Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                          child: CustomTextfield(
                            Icons: LineAwesomeIcons.building,
                            obsuretext: false,
                            lines: 1,
                            errorMsg: 'Company Name Required',
                            hinttext: 'Company Name',
                            controller: searchVisitor.companyName,
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                          child: CustomTextfield(
                            Icons: LineAwesomeIcons.building,
                            obsuretext: false,
                            lines: 1,
                            errorMsg: 'System Name Required',
                            hinttext: 'System Name',
                            controller: searchVisitor.systemName,
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                          child: CustomTextfield(
                            Icons: LineAwesomeIcons.building,
                            obsuretext: false,
                            lines: 1,
                            errorMsg: 'Visitor Name Required',
                            hinttext: 'Visitor Name',
                            controller: searchVisitor.visitorName,
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
                          controller: searchVisitor.dateTimeRange,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(18.0),
                            filled: true,
                            fillColor:  kGinColor,
                            prefixIcon: IconButton(
                              icon: Icon(Icons.calendar_month,size: 24.0,color: kDarkblueColor),
                              onPressed: () {
                                dateRange(context, searchVisitor.dateTimeRange);
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
                      SelectReportType(controller1: searchVisitor.selectType,hint: 'Select Report Type',),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: (MediaQuery.of(context).size.height*0.07),
                            child: ElevatedButton(
                              onPressed: () async{
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return VisitorDetailsList();
                                    },)
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: kDarkblueColor,
                                  side: BorderSide.none,
                                  shape: const StadiumBorder()),
                              child: Text("Search",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                ),
                              ),
                            )
                          ),
                        ),
                    ]
                  )
              )
            ],
          )
      ),
    );
  }
}
