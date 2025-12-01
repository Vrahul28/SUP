import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../login.dart';
import '../../staff/database/dbhelper.dart';
import '../../utils/colors.dart';


class StaffDashboard extends StatefulWidget {
  const StaffDashboard({super.key});

  @override
  State<StaffDashboard> createState() => _StaffDashboardState();
}


class _StaffDashboardState extends State<StaffDashboard> {

  String totalStaffCount3 = '';
  DBhelper db= DBhelper.db;
  bool user= (usernameController.text =="ara@gmail.com");

  Future<void> updateTotalStaffCount() async {

    int totalCount3 = await db.count3();
    setState(() {
      totalStaffCount3 = totalCount3.toString();
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateTotalStaffCount();
  }

  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 50),
      crossAxisCount: 1,
      crossAxisSpacing: 10,
      childAspectRatio: 1 / 0.3,
      shrinkWrap: true, // Add this line
      physics: NeverScrollableScrollPhysics(), // Add this line
      children: [
          Card(
            color: kDarkblueColor,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kDarkblueColor2, kbluelightColor],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(totalStaffCount3,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text("Staff",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                  ),
                ],
              ),
            ),
          ),


        // Add more GridItems as needed
      ],
    );

  }
}