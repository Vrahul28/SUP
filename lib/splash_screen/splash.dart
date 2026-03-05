import 'package:acp/splash_screen/splash_service.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  SplashService s = SplashService();
  @override
  void initState() {
    super.initState();
    s.login(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 600,
              child: Center(
                  child:Image.asset(
                    "assets/images/logo (1).png",
                    width: 300,
                  )
              ),
            ),
          ],
        ),

      ),
    );
  }
}
