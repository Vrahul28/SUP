import 'package:acp/company/companyscreen.dart';
import 'package:acp/staff/staffscreen.dart';
import 'package:acp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../appDashboard/dashboard2/dashboard2.dart';
import '../blacklist/blacklist.dart';
import '../login.dart';
import 'drawerclass.dart';

class Sidemenu extends StatefulWidget {
  const Sidemenu({super.key});

  @override
  State<Sidemenu> createState() => _SidemenuState();
}

class _SidemenuState extends State<Sidemenu> {

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
    return Drawer(
      child: Material(
        child: isAdmin? Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [kDarkblueColor, kbluelightColor],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
            child: Column(
              children: [
                headerWidget(),
                const Divider(thickness: 1, height: 10, color: Colors.white,),
                const SizedBox(height: 40,),
                DrawerItem(
                  name: 'Company',
                  icon: Icons.people,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const Companyscreen(),
                      ),
                    );

                  },
                ),
                const SizedBox(height: 30,),
                DrawerItem(
                    name: 'Staff',
                    icon: Icons.account_box_rounded,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => const Staffscreen(),
                        ),
                      );
                    }
                ),
                const SizedBox(height: 30,),

                DrawerItem(
                    name: 'Blacklist',
                    icon: Icons.no_accounts,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => const Blacklist(),
                        ),
                      );
                    }
                ),
                const SizedBox(height: 30,),
                DrawerItem(
                  name: 'Home',
                  icon: Icons.logout,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => Dashboard2(),
                      ),
                    );

                  },
                ),
              ]
            ),
          ),
        ) :

        Container(
          decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [kDarkblueColor, kbluelightColor],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
          child: Column(
              children: [
                headerWidget(),
                const Divider(thickness: 1, height: 10, color: Colors.white,),
                const SizedBox(height: 40,),
                DrawerItem(
                    name: 'Staff',
                    icon: Icons.account_box_rounded,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => Staffscreen(),
                        ),
                      );
                    }
                ),
                const SizedBox(height: 20,),
                DrawerItem(
                  name: 'Home',
                  icon: Icons.logout,
                  onPressed: () {
                    usernameController.clear();
                    passwordController.clear();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => Dashboard2(),
                      ),
                    );

                  },
                )
              ]
          ),
        ),

        )
      ),

    );
  }
}

Widget headerWidget() {
  // const url = 'https://images.unsplash.com/photo-1500522144261-ea64433bbe27?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTh8fHdvbWVufGVufDB8MHwwfHw%3D&auto=format&fit=crop&w=500&q=60';
  // return Row(
  //   children: [
  //     const CircleAvatar(
  //       radius: 40,
  //       backgroundImage: NetworkImage(url),
  //     ),
  //     const SizedBox(width: 20,),
  //     Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: const [
  //         Text('Person name', style: TextStyle(fontSize: 14, color: Colors.white)),
  //       ],
  //     )
  //   ],
  // );
  return Image.asset(
      'assets/images/logo_upload.png',
    width: 250,
    height: 120,
  );
}
