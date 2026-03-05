import 'package:acp/Provider/Login/Login_Provider.dart';
import 'package:acp/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../blacklist/blacklist.dart';
import '../../company/companyscreen.dart';
import '../../facilitybookingpage/facilitybooking.dart';
import '../../staff/staffscreen.dart';

class Gridlayout extends StatelessWidget {
   Gridlayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final login= context.read<LoginProvider>();
    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      crossAxisCount: 1,
      crossAxisSpacing: 10,
      mainAxisSpacing:10,
      childAspectRatio: (1/.28),
      shrinkWrap: true, // Add this line
      physics: const NeverScrollableScrollPhysics(),
      children: login.companyStaffDashboard.map((data) {
        return GestureDetector(
          onTap: () {
            if (data.title == "Company") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompanyScreen()),
              );
            }
            if (data.title == "Staff") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StaffScreen()),
              );
            }

            if (data.title == "Blacklist") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Blacklist()),
              );
            }
            if (data.title == "Booking") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FacilityBooking()),
              );
            }


          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
                width: 1
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Image.asset(
                    data.img,
                    width: 45,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  data.title,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: kDarkblueColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.arrow_forward,
                    color: kDarkblueColor,
                  ),
                )

              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

