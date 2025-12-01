import 'package:acp/Provider/Dashboard/Visitor_Acess_Provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../vistoracessmanagement/emailTemplate.dart';
import '../vistoracessmanagement/invitation.dart';

class Grid4 extends StatelessWidget {
  const Grid4({super.key});

  @override

  @override
  Widget build(BuildContext context) {
    final visitorProvider= Provider.of<VistorAcessProvider>(context);
    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      crossAxisCount: 1,
      crossAxisSpacing: 10,
      mainAxisSpacing:10,
      childAspectRatio: (1/.3),
      shrinkWrap: true, // Add this line
      physics: const NeverScrollableScrollPhysics(),
      children: visitorProvider.visitorAccess.map((data) {
        return GestureDetector(
          onTap: () {
            if (data.title == "Email Template") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Emialtemplate()),
              );
            }
            if (data.title == "Report") {

            }
            if (data.title == "Invitation") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Invitation()),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: kDarkblueColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 20,),
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
                    padding: EdgeInsets.only(left: 5,right: 10),
                    child: Text(
                      data.title,
                      softWrap: true,
                      maxLines: 4,
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                // Spacer(),
                // Padding(
                //   padding: const EdgeInsets.only(right: 10),
                //   child: Icon(
                //     Icons.arrow_forward_ios_sharp,
                //     color: kDarkblueColor,
                //   ),
                // )

              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}


