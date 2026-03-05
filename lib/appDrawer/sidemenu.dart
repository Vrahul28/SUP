import 'package:acp/company/companyscreen.dart';
import 'package:acp/staff/staffscreen.dart';
import 'package:acp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../Provider/Login/Login_Provider.dart';
import '../appDashboard/dashboard2/dashboard2.dart';
import '../appDashboard/main_dashboard/main_dashboard.dart';
import '../blacklist/blacklist.dart';
import 'drawerclass.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  late SharedPreferences pref;
  bool isAdmin = true;

  @override
  void initState() {
    super.initState();
    // _initializePreferences();
  }

  // Initialize SharedPreferences asynchronously
  // Future<void> _initializePreferences() async {
  //   pref = await SharedPreferences.getInstance();
  //   String? userrole= pref.getString('userRole');
  //   if(userrole == "5"){
  //     setState(() {
  //       isAdmin = true;
  //     });
  //   }else {
  //     setState(() {
  //       isAdmin = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final login= context.read<LoginProvider>();
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
                        builder: (BuildContext context) => const CompanyScreen(),
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
                          builder: (BuildContext context) => const StaffScreen(),
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
                        builder: (BuildContext context) => MainDashboard(),
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
                          builder: (BuildContext context) => StaffScreen(),
                        ),
                      );
                    }
                ),
                const SizedBox(height: 20,),
                DrawerItem(
                  name: 'Home',
                  icon: Icons.logout,
                  onPressed: () {
                    login.usernameController.clear();
                    login.passwordController.clear();
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
  return Image.asset(
      'assets/images/logo_upload.png',
    width: 250,
    height: 120,
  );
}
