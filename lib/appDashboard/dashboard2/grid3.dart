import 'package:acp/Provider/Dashboard/Application_dashboard_Provider.dart';
import 'package:acp/appDashboard/vistoracessmanagement/vistoracess.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Permit_to_work/permittowork.dart';
import '../../Provider/Dashboard/Visitor_Acess_Provider.dart';
import '../../facilitybookingpage/facilitybooking.dart';
import '../../utils/colors.dart';
import '../../visitor_details_report/visitor_details_report.dart';
import '../dashboard/dashboard.dart';


class Grid3 extends StatelessWidget {
  const Grid3({super.key});

  @override
  Widget build(BuildContext context) {
    final visitorProvider= Provider.of<VistorAcessProvider>(context);
    final appProvider= Provider.of<ApplicationDashboardProvider>(context,listen: false);
    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      crossAxisCount: 1,
      crossAxisSpacing: 10,
      mainAxisSpacing:10,
      childAspectRatio: (1/.3),
      shrinkWrap: true, // Add this line
      physics: const NeverScrollableScrollPhysics(),
      children: appProvider.lists.map((data) {
        return GestureDetector(
          onTap: () {
            if (data.title == "Setup and Configure") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Dashboard()),
              );
            }
            if (data.title == "Visitor Acess Management Service") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Vistoracess()),
              );
            }
            if (data.title == "Facility Booking") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Facilitybooking()),
              );
            }
            if (data.title == "Permit To Work") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Permittowork()),
              );
            }

            if (data.title == "Visitor Details Report") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VisitorDetailsReport()),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.black12,
                  width: 1
              ),
              color: kDarkblueColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Image.asset(
                    data.img,
                    width: 40,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5,right: 10),
                    child: Text(
                      data.title,
                      softWrap: true,
                      maxLines: 4,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}


