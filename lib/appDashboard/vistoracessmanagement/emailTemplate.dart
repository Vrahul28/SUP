import 'package:acp/appDashboard/vistoracessmanagement/vistoracess.dart';
import 'package:acp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextEditingController subject= TextEditingController();
class Emialtemplate extends StatelessWidget {
  const Emialtemplate({super.key});

  @override
  Widget build(BuildContext context) {
    subject.text= "Visitor Invitation";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        iconTheme: const IconThemeData(color: Colors.grey, size: 28),
        title: Text("Email Template", style: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: kDarkblueColor,
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),
        ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Vistoracess()),
                );
              },
              icon: Icon(Icons.arrow_back, color: kDarkblueColor),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              "Subject*",
                              style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: kDarkblueColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            cursorColor: kDarkblueColor,
                            style: GoogleFonts.poppins(
                              color: kDarkblueColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                            ),
                            keyboardType: TextInputType.number,
                            controller: subject,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(18.0),
                              filled: true,
                              fillColor:  kGinColor,
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
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              "Salutation*",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: kDarkblueColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.3,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                                width: 2
                              )
                            ),
                            child: Center(
                                child:Image.asset(
                                  "assets/images/logo (1).png",
                                )
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              "Body*",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: kDarkblueColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.55,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black12,
                                    width: 2
                                )
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 5),
                                Text("Dear Visitor", style: GoogleFonts.poppins(textStyle: TextStyle(fontWeight: FontWeight.bold))),
                                SizedBox(height: 15),
                                Text("You have been invited to",style: GoogleFonts.poppins()),
                                SizedBox(height: 15),
                                Text("#Company", style: GoogleFonts.poppins(textStyle: TextStyle(fontWeight: FontWeight.bold)),),
                                Text("#Unit Tower #Tower", style: GoogleFonts.poppins(textStyle: TextStyle(fontWeight: FontWeight.bold)),),
                                SizedBox(height: 15),
                                Text("on",style: GoogleFonts.poppins()),
                                SizedBox(height: 15),
                                Text("#FromDate to #ToDate", style: GoogleFonts.poppins(textStyle: TextStyle(fontWeight: FontWeight.bold)),),
                                SizedBox(height: 15),
                                Text("#QRCodeImage",style: GoogleFonts.poppins()),
                                SizedBox(height: 15),
                                Text("Flash the above QR code at the turnstiles gate",style: GoogleFonts.poppins()),
                                Text("to enter office tower",style: GoogleFonts.poppins()),
                                SizedBox(height: 15),
                                Text("SECURITY-AND-ACCESS-CONTROL",style: GoogleFonts.poppins()),
                                Text("-PRIVACY-NOTICE"),
                                SizedBox(height: 15),
                                Text("For assistance, please contact 626615011", style: GoogleFonts.poppins(textStyle: TextStyle(fontWeight: FontWeight.bold)),),
                                Text("Thank you!", style: GoogleFonts.poppins(textStyle: TextStyle(fontWeight: FontWeight.bold)),),
                              ],
                            ),

                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              "Footer*",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: kDarkblueColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.3,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black12,
                                    width: 2
                                )
                            ),
                          ),
                          SizedBox(height: 10),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             MaterialButton(
                               minWidth: 50,
                               height: 50,
                               color: kDarkblueColor,
                               onPressed: () {
                                 _showBottomSheet(context);
                               },
                               child: Text("SMTP settings", style: TextStyle(color: Colors.white),),
                             ),
                             SizedBox(width:10),
                             MaterialButton(
                                    minWidth: 50,
                                    height: 50,
                                    color: kDarkblueColor,
                                      onPressed: () {

                                      },
                                    child: Text("Save Changes", style: TextStyle(color: Colors.white),),
                                  ),
                           ],
                         ),
                          SizedBox(height: 10),


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

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 15,
              ),
              TextFormField(
                cursorColor: kDarkblueColor,
                style: GoogleFonts.poppins(
                  color: kDarkblueColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(18.0),
                  filled: true,
                  fillColor:  kGinColor,
                  prefixIcon: Icon(
                    Icons.mail,
                    size: 24.0,
                    color: kDarkblueColor,
                  ),
                  hintText: 'Email id',
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(18.0),
                  filled: true,
                  fillColor:  kGinColor,
                  prefixIcon: Icon(
                    Icons.password,
                    size: 24.0,
                    color: kDarkblueColor,
                  ),
                  hintText: 'Password',
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(18.0),
                  filled: true,
                  fillColor:  kGinColor,
                  prefixIcon: Icon(
                    Icons.mark_as_unread,
                    size: 24.0,
                    color: kDarkblueColor,
                  ),
                  hintText: 'SMTP',
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(18.0),
                  filled: true,
                  fillColor:  kGinColor,
                  prefixIcon: Icon(
                    Icons.podcasts_rounded,
                    size: 24.0,
                    color: kDarkblueColor,
                  ),
                  hintText: 'Port',
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
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkblueColor,

                ),
                child: Text("Save Changes", style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      );
    },
  );
}
