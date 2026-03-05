import 'package:acp/utils/colors.dart';
import 'package:acp/widget/custom_card_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../company/addcompany/addcompany.dart';
import '../../facilitybookingpage/facilitybooking.dart';
import '../../staff/addstaff/addstaff.dart';
import '../../visitor_details_report/visitor_details_report.dart';
import '../dashboard/dashboard.dart';
import '../vistoracessmanagement/vistoracess.dart';

class MainDashboard extends StatelessWidget {
  const MainDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              pinned: true,
              elevation: 1.0,
              automaticallyImplyLeading: false,
              toolbarHeight: size.height * 0.08,
              flexibleSpace: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0,top: 10.0,bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hello Admin!', style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: kDarkblueColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600
                          ))
                          ),
                          Text('Welcome Back', style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400
                              ))
                          ),
                        ]
                      ),
                      Row(
                        children: [
                          Icon(Icons.notifications_none, color: kDarkblueColor, size: 30),
                          SizedBox(width: 10),
                          Icon(Icons.menu, color: kDarkblueColor, size: 30),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0,right: 15.0),
                child: Text("Applications", style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: kDarkblueColor
                ),),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 15.0,right: 15.0),
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1,
                children: [
                  CustomCardDashboard(
                      text: 'Setup & Configure',
                      icon: Icon(Icons.settings,color: kDarkblueColor,size: 30),
                    color: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Dashboard()),
                      );
                    },
                  ),
                  CustomCardDashboard(
                      text: "Visitor Access Service",
                      icon: Icon(Icons.person,color: kDarkblueColor,size: 30),
                    color: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Vistoracess()),
                      );
                    },
                  ),
                  CustomCardDashboard(
                      text: "Facility Booking",
                      icon: Icon(Icons.calendar_today,color: kDarkblueColor,size: 30),
                    color: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FacilityBooking()),
                      );
                    },
                  ),
                  CustomCardDashboard(
                      text: "Visitor Details Report",
                      icon: Icon(Icons.credit_card,color: kDarkblueColor,size: 30),
                    color: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const VisitorDetailsReport()),
                      );
                    },
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0,right: 15.0),
                child: Text("Quick Actions", style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kDarkblueColor
                ),),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 15.0,right: 15.0),
              sliver: SliverGrid.count(
                crossAxisCount: 1,
                crossAxisSpacing: 15,
                mainAxisSpacing:15,
                childAspectRatio: (1/.2),
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => const AddCompany(),
                        ),
                      );
                    },
                      child: customCard2("Add New Company")
                  ),
                  GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => const AddStaff(),
                          ),
                        );
                      },
                      child: customCard2("Add New Staff")
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
  Widget customCard2(String text){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.black12,
            width: 1
        ),
        color: kDarkblueColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0,left: 15.0,top: 15.0,bottom: 15.0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,

                  ),
                  child: Icon(Icons.settings,color: kDarkblueColor,size: 30)
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5,right: 10),
                child: Text(
                  text,
                  softWrap: true,
                  maxLines: 4,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,size: 20)
          ],
        ),
      ),
    );
  }
}
