import 'dart:async';
import 'package:acp/staff/database/dbhelper.dart';
import 'package:flutter/material.dart';
import 'appDashboard/dashboard/dashboard.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  DBhelper dBhelper= DBhelper.db;
  @override
  void initState() {
    // getCompany1(company11,staff11);
    // gettotalStaff();
    dBhelper.initDB();
    dBhelper.getAllCompany(company11,staff11,unit11);

      Timer(Duration(seconds: 7), () async {

        // final isAuthenticatd = await authenticate();
        // if(isAuthenticatd) {
        //   // After 1 second, navigate to the next screen
        //   Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(
        //       builder: (BuildContext context) => Dashboard(),
        //     ),
        //   );
        // } else {
        //   // final snackbar = Snackbar(content: Text('Auth Failed'));
        //   // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // }

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => Login(),
            ),
          );


      });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 600,
              child: Center(
                  child:Image.asset(
                      "assets/images/logo (1).png",
                    width: 300,
                  )
              ),
            ),

            // Center(
            //   child: Container(
            //     padding: EdgeInsets.only(bottom: 16,left: 5),
            //     child: Text(
            //       "Welcome to Bizlink",
            //       style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),

          ],
        ),

      ),
    );
  }
}
