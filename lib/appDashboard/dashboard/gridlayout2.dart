
import 'package:acp/Provider/Staff/Staff_Provider.dart';
import 'package:acp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Provider/Dashboard/Total_Count_Provider.dart';


TextEditingController totalgrid= TextEditingController();

class Gridlayout2 extends StatefulWidget {
  const Gridlayout2({super.key});

  @override
  State<Gridlayout2> createState() => _Gridlayout2State();
}

class _Gridlayout2State extends State<Gridlayout2> {

  @override
  Widget build(BuildContext context) {
    final companyProvider = Provider.of<TotalCountProvider>(context);
    final staffProvider= Provider.of<StaffProvider>(context);
    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 50),
        crossAxisCount: 2,
      crossAxisSpacing: 10,
        childAspectRatio: 1 / 0.9,
        shrinkWrap: true, // Add this line
        physics: const NeverScrollableScrollPhysics(), // Add this line
        children: [
            Card(
              color: Colors.white,
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
                    Text(companyProvider.count.toString(),
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text("Company",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                    Text(staffProvider.count.toString(),
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text("Staff",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
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


class GridItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const GridItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50.0,
            color: Colors.white,
          ),
          SizedBox(height: 10.0),
          Text(
            text,
            style:const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
