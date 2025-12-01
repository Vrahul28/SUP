import 'package:acp/appDashboard/dashboard/gridlayout2.dart';
import 'package:acp/appDrawer/sidemenu.dart';
import 'package:acp/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;
import '../../utils/colors.dart';
import 'Staff_dashboard.dart';
import 'gridlayout.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

String company11 = '';
String staff11 = '';
String unit11 = '';
TextEditingController company1= TextEditingController();
TextEditingController staff1= TextEditingController();

class _DashboardState extends State<Dashboard> {
  late SharedPreferences pref;
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  // Initialize SharedPreferences asynchronously
  Future<void> _initializePreferences() async {
    pref = await SharedPreferences.getInstance();
    String? userrole= pref.getString('userRole');
    print("UserRole dashboard : $userrole");
    if(userrole == "5"){
      setState(() {
        isAdmin = true;
      });
    }else {
      setState(() {
        isAdmin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints){
            if(constraints.maxHeight>600){
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
                          Scaffold.of(context).openDrawer();
                        },
                        icon: Icon(CupertinoIcons.line_horizontal_3_decrease, color: kDarkblueColor,),
                      );
                    },
                  ),
                ),
                drawer: const Sidemenu(),
                body: CustomScrollView(
                  slivers: [
                    isAdmin? SliverList(
                          delegate: SliverChildListDelegate(
                              [
                                SizedBox(
                                  height: (MediaQuery.of(context).size.width*0.04),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: (MediaQuery.of(context).size.width*0.04),
                                      ),
                                      Text("Welcome! Admin",style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          color: kDarkblueColor,
                                          fontSize: (MediaQuery.of(context).size.width*0.06),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),),
                                      SizedBox(
                                        height: (MediaQuery.of(context).size.width*0.04),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: (MediaQuery.of(context).size.width),
                                  height: (MediaQuery.of(context).size.height),
                                  decoration: BoxDecoration(
                                    color: kDarkblueColor,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(40), // Adjust the radius as needed
                                      topRight: Radius.circular(40), // Adjust the radius as needed
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 3.0, top: 0.0),
                                    child: Column(
                                      children: [
                                        SizedBox(height: (MediaQuery.of(context).size.height*0.02),),
                                        Gridlayout2(),
                                        SizedBox(height: (MediaQuery.of(context).size.height*0.02),),
                                        Expanded(
                                          child: Container(
                                            width: (MediaQuery.of(context).size.width),
                                            height: (MediaQuery.of(context).size.height),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(40), // Adjust the radius as needed
                                                topRight: Radius.circular(40), // Adjust the radius as needed
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(height: (MediaQuery.of(context).size.height*0.04),),
                                                Gridlayout()
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )

                              ]
                          )
                      )
                    :
                    SliverList(
                          delegate: SliverChildListDelegate(
                              [
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 3.0, top: 0.0),
                                //   child: Gridlayout2(),
                                // ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 3.0, top: 0.0),
                                //   child: Gridlayout(),
                                // ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                SizedBox(
                                  height: (MediaQuery.of(context).size.width*0.02),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: (MediaQuery.of(context).size.width*0.16),
                                      ),
                                      // SizedBox(
                                      //   width: (MediaQuery.of(context).size.width*0.20),
                                      //   height: (MediaQuery.of(context).size.width*0.20),
                                      //   child: CircleAvatar(
                                      //     child: Image.asset("assets/images/profile.png"),
                                      //   ),
                                      // ),
                                      SizedBox(
                                        width: (MediaQuery.of(context).size.width*0.04),
                                      ),
                                      Text("Welcome! User",style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          color: kDarkblueColor,
                                          fontSize: (MediaQuery.of(context).size.width*0.06),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Tap for",style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: kDarkblueColor,
                                        // fontSize: 14,
                                        // fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  title: Container(
                                                    width: 400,
                                                    height: 380,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text("SUNTEC",style: TextStyle(
                                                              color: kDarkblueColor,
                                                              fontSize: 17,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                            ),
                                                            Text("+",style: TextStyle(
                                                              color: Colors.orangeAccent,
                                                              fontSize: 17,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10,),
                                                        Center(child: Image.asset("assets/images/qrcode.png", width: 300,height: 260,)),
                                                        SizedBox(height:18,),
                                                        Center(
                                                          child: Text("Corporate Member",style: TextStyle(
                                                            color: kDarkblueColor,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          ),
                                                        ),
                                                        SizedBox(height:10,),
                                                        Center(
                                                          child: Text(
                                                            "Finish above QRcode at the turnsile gate",
                                                            style: TextStyle(
                                                              color: kDarkblueColor, // Replace with your desired color
                                                              fontSize: 12,
                                                            ),

                                                          ),
                                                        ),
                                                        Center(
                                                          child: Text(
                                                            "to enter office tower",
                                                            style: TextStyle(
                                                              color: kDarkblueColor, // Replace with your desired color
                                                              fontSize: 12,
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  )
                                              );
                                            },
                                          );

                                        },
                                        icon: const Icon(Icons.qr_code_2_outlined)
                                    )
                                  ],
                                ),
                                SizedBox(height: (MediaQuery.of(context).size.height*0.02)),
                                Container(
                                  width: (MediaQuery.of(context).size.width),
                                  height: (MediaQuery.of(context).size.height),
                                  decoration: BoxDecoration(
                                    color: kDarkblueColor,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(40), // Adjust the radius as needed
                                      topRight: Radius.circular(40), // Adjust the radius as needed
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 3.0, top: 0.0),
                                    child: Column(
                                      children: [
                                        SizedBox(height: (MediaQuery.of(context).size.height*0.02),),
                                        StaffDashboard(),
                                        SizedBox(height: (MediaQuery.of(context).size.height*0.02),),
                                        Expanded(
                                          child: Container(
                                            width: (MediaQuery.of(context).size.width),
                                            height: (MediaQuery.of(context).size.height),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(40), // Adjust the radius as needed
                                                topRight: Radius.circular(40), // Adjust the radius as needed
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(height: (MediaQuery.of(context).size.height*0.04),),
                                                Gridlayout()
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ]
                          )
                      )


                  ],
                ),
              );

            }else{
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: Colors.black12
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                      ),
                    ),
                  ),
                  iconTheme: const IconThemeData(color: Colors.grey, size: 28),
                  leading: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: Icon(CupertinoIcons.line_horizontal_3_decrease, color: Colors.black,),
                      );
                    },
                  ),
                  actions: [
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(
                    //     CupertinoIcons.qrcode,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(
                    //     Icons.notifications,
                    //     color: Colors.grey,
                    //   ),
                    // ),
                    Container(
                      // margin: const EdgeInsets.only(top: 5, right: 16, bottom: 5),
                      // child: const CircleAvatar(
                      //   backgroundImage: NetworkImage(
                      //       "https://images.unsplash.com/photo-1500522144261-ea64433bbe27?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTh8fHdvbWVufGVufDB8MHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
                      // ),
                    )
                  ],
                ),
                drawer: const Sidemenu(),
                body: CustomScrollView(
                  slivers: [
                    if(usernameController.text == "admin@gmail.com")
                      SliverList(
                          delegate: SliverChildListDelegate(
                              [
                                SizedBox(
                                  height: (MediaQuery.of(context).size.width*0.04),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: (MediaQuery.of(context).size.width*0.04),
                                      ),
                                       Text("Welcome! Admin",style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                            color: kDarkblueColor,
                                            fontSize: (MediaQuery.of(context).size.width*0.06),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                       ),
                                    ],
                                  ),
                                ),

                                // Padding(
                                //   padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 3.0, top: 0.0),
                                //   child: Gridlayout2(),
                                // ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 3.0, top: 0.0),
                                //   child: Gridlayout(),
                                // ),
                                SizedBox(height: (MediaQuery.of(context).size.height*0.02)),
                                Container(
                                  width: (MediaQuery.of(context).size.width),
                                  height: (MediaQuery.of(context).size.height),
                                  decoration: BoxDecoration(
                                    color: kDarkblueColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40), // Adjust the radius as needed
                                      topRight: Radius.circular(40), // Adjust the radius as needed
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 3.0, top: 0.0),
                                    child: Column(
                                      children: [
                                       
                                        SizedBox(height: (MediaQuery.of(context).size.height*0.02),),
                                        Gridlayout2(),
                                        SizedBox(height: (MediaQuery.of(context).size.height*0.02),),
                                        Expanded(
                                          child: Container(
                                            width: (MediaQuery.of(context).size.width),
                                            height: (MediaQuery.of(context).size.height),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(40), // Adjust the radius as needed
                                                topRight: Radius.circular(40), // Adjust the radius as needed
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(height: (MediaQuery.of(context).size.height*0.04),),
                                                Gridlayout()
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )

                              ]
                          )
                      )else
                      SliverList(
                          delegate: SliverChildListDelegate(
                              [
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 3.0, top: 0.0),
                                //   child: Gridlayout2(),
                                // ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 3.0, top: 0.0),
                                //   child: Gridlayout(),
                                // ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                SizedBox(
                                  height: (MediaQuery.of(context).size.width*0.02),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: (MediaQuery.of(context).size.width*0.16),
                                      ),
                                      // SizedBox(
                                      //   width: (MediaQuery.of(context).size.width*0.20),
                                      //   height: (MediaQuery.of(context).size.width*0.20),
                                      //   child: CircleAvatar(
                                      //     child: Image.asset("assets/images/profile.png"),
                                      //   ),
                                      // ),
                                      SizedBox(
                                        width: (MediaQuery.of(context).size.width*0.04),
                                      ),
                                      Text("Welcome! User",style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          color: kDarkblueColor,
                                          fontSize: (MediaQuery.of(context).size.width*0.06),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Tap for",style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        color: kDarkblueColor,
                                        // fontSize: 14,
                                        // fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    ),

                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  title: Container(
                                                    width: 400,
                                                    height: 380,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text("SUNTEC",style: TextStyle(
                                                              color: kDarkblueColor,
                                                              fontSize: 17,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                            ),
                                                            Text("+",style: TextStyle(
                                                              color: Colors.orangeAccent,
                                                              fontSize: 17,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                            ),
                                                          ],
                                                        ),

                                                        SizedBox(height: 10,),
                                                        Image.asset("assets/images/qrcode.png", width: 300,height: 260,),
                                                        SizedBox(height:18,),
                                                        Center(
                                                          child: Text("Corporate Member",style: TextStyle(
                                                            color: kDarkblueColor,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          ),
                                                        ),
                                                        SizedBox(height:10,),
                                                        Center(
                                                          child: Text(
                                                            "Finish above QRcode at the turnsile gate",
                                                            style: TextStyle(
                                                              color: kDarkblueColor, // Replace with your desired color
                                                              fontSize: 11,
                                                            ),

                                                          ),
                                                        ),
                                                        Center(
                                                          child: Text(
                                                            "to enter office tower",
                                                            style: TextStyle(
                                                              color: kDarkblueColor, // Replace with your desired color
                                                              fontSize: 12,
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  )
                                              );
                                            },
                                          );

                                        },
                                        icon: Icon(Icons.qr_code_2_outlined)
                                    )
                                  ],
                                ),
                                SizedBox(height: (MediaQuery.of(context).size.height*0.02)),
                                Container(
                                  width: (MediaQuery.of(context).size.width),
                                  height: (MediaQuery.of(context).size.height),
                                  decoration: BoxDecoration(
                                    color: kDarkblueColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40), // Adjust the radius as needed
                                      topRight: Radius.circular(40), // Adjust the radius as needed
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 3.0, top: 0.0),
                                    child: Column(
                                      children: [
                                        SizedBox(height: (MediaQuery.of(context).size.height*0.02),),
                                        Gridlayout2(),
                                        Container(
                                          width: (MediaQuery.of(context).size.width),
                                          height: (MediaQuery.of(context).size.height*0.71),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(40), // Adjust the radius as needed
                                              topRight: Radius.circular(40), // Adjust the radius as needed
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(height: (MediaQuery.of(context).size.height*0.04),),
                                              Gridlayout()
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
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

      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 150);
    path.quadraticBezierTo(width /4, height, width, height);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
