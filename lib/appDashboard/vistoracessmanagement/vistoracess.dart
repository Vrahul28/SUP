import 'package:acp/appDashboard/main_dashboard/main_dashboard.dart';
import 'package:acp/login/login.dart';
import 'package:acp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dashboard2/dashboard2.dart';
import '../dashboard2/grid4.dart';
import '../gridlist.dart';

class Vistoracess extends StatefulWidget {
  const Vistoracess({super.key});

  @override
  State<Vistoracess> createState() => _VistoracessState();
}

class _VistoracessState extends State<Vistoracess> {

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints){
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text("Visitor Acess",
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
                        width: 3,
                        color: Colors.black12
                    ),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)
                    ),
                  ),
                ),
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        },
                      icon: Icon(Icons.arrow_back, color: kDarkblueColor,),
                    );
                  },
                ),
              ),
              body: CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate(
                          [
                            SizedBox(
                              height: (MediaQuery.of(context).size.width*0.04),
                            ),

                            const Grid4()
                          ]
                      )
                  )
                ],
              ),
            );
          }
      ),
    );
  }
}

