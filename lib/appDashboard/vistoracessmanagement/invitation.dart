import 'package:acp/appDashboard/vistoracessmanagement/viewinvitation.dart';
import 'package:acp/appDashboard/vistoracessmanagement/vistoracess.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../utils/colors.dart';

TextEditingController todate= TextEditingController();
TextEditingController fromdate= TextEditingController();
TextEditingController email= TextEditingController();
TextEditingController company= TextEditingController();
TextEditingController invitationtower= TextEditingController();
TextEditingController remarks= TextEditingController();

class Invitation extends StatefulWidget {
  const Invitation({super.key});

  @override
  State<Invitation> createState() => _InvitationState();
}

class _InvitationState extends State<Invitation> {
  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: selectedDate.add(Duration(days: 14)));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        String date= "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
        controller.text = date;
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Invitation",
          style: GoogleFonts.poppins(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: kDarkblueColor,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: Colors.black12
            ),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)
            ),
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                todate.clear();
                fromdate.clear();
                email.clear();
                company.clear();
                invitationtower.clear();
                remarks.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Vistoracess()),
                );
              },
              icon: Icon(Icons.arrow_back, color: Colors.black,),
            );
          },
        ),
        actions: [
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          TextFormField(
                            cursorColor: kDarkblueColor,
                            style: GoogleFonts.poppins(
                              color: kDarkblueColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                            ),
                            keyboardType: TextInputType.datetime,
                            controller: fromdate,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(18.0),
                              filled: true,
                              fillColor:  kGinColor,
                              prefixIcon: IconButton(
                                icon: Icon(Icons.calendar_month,size: 24.0,color: kDarkblueColor),
                                onPressed: () {
                                  _selectDate(context,fromdate);
                                  // daterange(context, activationdate);
                                },
                              ),
                              hintText: 'From date',
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
                          SizedBox(height: 15),
                          TextFormField(
                            cursorColor: kDarkblueColor,
                            style: GoogleFonts.poppins(
                              color: kDarkblueColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                            ),
                            keyboardType: TextInputType.datetime,
                            controller: todate,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(18.0),
                              filled: true,
                              fillColor:  kGinColor,
                              prefixIcon: IconButton(
                                icon: Icon(Icons.calendar_month,size: 24.0,color: kDarkblueColor),
                                onPressed: () {
                                  _selectDate(context,todate);
                                  // daterange(context, activationdate);
                                },
                              ),
                              hintText: 'To Date',
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
                          SizedBox(height: 15),
                          TextFormField(
                            cursorColor: kDarkblueColor,
                            style: GoogleFonts.poppins(
                              color: kDarkblueColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: email,
                            onChanged: (text) {
                              // Handle the entered text and split it into multiple emails
                              List<String> emails = text.split(';');
                              debugPrint(email.text);
                              // Process the list of emails as needed
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(18.0),
                              filled: true,
                              fillColor:  kGinColor,
                              prefixIcon: Icon(
                                Icons.mail,
                                size: 24.0,
                                color: kDarkblueColor,
                              ),
                              hintText: 'Enter Visitor email',
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
                          SizedBox(height: 3),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text("For more than one visitor please enter visitor@email.com; visitor@email.com", style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600),),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            cursorColor: kDarkblueColor,
                            style: GoogleFonts.poppins(
                              color: kDarkblueColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                            ),
                           controller: company,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(18.0),
                              filled: true,
                              fillColor:  kGinColor,
                              prefixIcon: Icon(
                                LineAwesomeIcons.building,
                                size: 24.0,
                                color: kDarkblueColor,
                              ),
                              hintText: 'Company',
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
                          SizedBox(height: 15),
                          TextFormField(
                            cursorColor: kDarkblueColor,
                            style: GoogleFonts.poppins(
                              color: kDarkblueColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                            ),
                            controller: invitationtower,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(18.0),
                              filled: true,
                              fillColor:  kGinColor,
                              prefixIcon: Icon(
                                Icons.cell_tower,
                                size: 24.0,
                                color: kDarkblueColor,
                              ),
                              hintText: 'Tower',
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
                          SizedBox(height: 15),
                          TextFormField(
                            cursorColor: kDarkblueColor,
                            style: GoogleFonts.poppins(
                              color: kDarkblueColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                            ),
                            controller: remarks,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(18.0),
                              filled: true,
                              fillColor:  kGinColor,
                              prefixIcon: Icon(
                                Icons.mark_as_unread,
                                size: 24.0,
                                color: kDarkblueColor,
                              ),
                              hintText: 'Remarks',
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
                          SizedBox(height: 15),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MaterialButton(
                                  minWidth: 50,
                                  height: 50,
                                  color: kDarkblueColor,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Viewinvitation()),
                                    );
                                  },
                                  child: Text("View Invitation", style: TextStyle(color: Colors.white),),
                                ),
                                SizedBox(width:10),
                                MaterialButton(
                                  minWidth: 50,
                                  height: 50,
                                  color: kDarkblueColor,
                                  onPressed: () {

                                  },
                                  child: Text("Submit", style: TextStyle(color: Colors.white),),
                                ),
                              ],
                            ),
                        ],
                      ),
                    )
                  ]
              )
          )
        ],
      ),
    );
  }
}

