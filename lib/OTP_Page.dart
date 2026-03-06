import 'dart:async';

import 'package:acp/Provider/Login/Login_Provider.dart';
import 'package:acp/Provider/Login/OTP_Provider.dart';
import 'package:acp/Provider/Login/ResendOTP_Provider.dart';
import 'package:acp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'appDashboard/dashboard2/dashboard2.dart';
import 'appDashboard/main_dashboard/main_dashboard.dart';


class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final  scaffoldMessengerOTPKey = GlobalKey<ScaffoldMessengerState>();

  Timer? _timer;
  int _remainingTime = 100; // 600 seconds = 10 minutes
  bool _isResendAvailable = false;

  void _startTimer() {
    _timer?.cancel(); // Cancel the existing timer if any
    setState(() {
      _remainingTime = 600;
      _isResendAvailable = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _isResendAvailable = true;
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OTP= Provider.of<OtpProvider>(context,listen: false);
    final login= context.read<LoginProvider>();
    final resend= Provider.of<ResendotpProvider>(context, listen: false);
    return ScaffoldMessenger(
      key: scaffoldMessengerOTPKey,
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SizedBox(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  width: (MediaQuery.of(context).size.width*0.75),
                  height: (MediaQuery.of(context).size.height*0.60),
                  decoration: BoxDecoration(
                    color: kDarkblueColor,
                    borderRadius: BorderRadius.circular(21),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 21,
                          color: Colors.grey,
                          spreadRadius: 7
                      )
                    ],
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo_upload.png',
                          height: 100,
                          width: 200,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: GoogleFonts.poppins(
                            color: kDarkblueColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0,
                          ),
                          cursorColor: kDarkblueColor,
                          controller: OTP.otp,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(18.0),
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(
                                Icons.password,
                                size: 24.0,
                                color: kDarkblueColor,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: kGinColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: kDarkblueColor),
                              ),
                              hintText: 'Enter OTP',
                              hintStyle: GoogleFonts.poppins(
                                color: kDarkblueColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0,
                              )
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: _isResendAvailable
                                  ? () {
                                OTP.userID= login.userId!;
                                OTP.username1= login.email1!;
                                OTP.status= login.status!;
                                resend.resendOTP(OTP.username1, OTP.userID, OTP.status);
                                _startTimer(); // Restart timer
                              }
                                  : null, // Disable button until timer ends
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all(
                                    _isResendAvailable ? Colors.amber : Colors.grey),
                              ),
                              child: Text(
                                'Resend OTP',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          "OTP is valid for: ${OTP.formatTime(_remainingTime)}",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            border: Border.all(color: Colors.white, width: 2), // Customize the border color and width
                          ),
                          child: MaterialButton(
                            height: 50.0,
                            minWidth: 150.0,
                            color: kDarkblueColor,
                            child: Text("Submit",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0,
                              ),
                            ),
                            onPressed: ()  async{
                              OTP.username1= login.usernameController.text;
                              bool isOTP= await OTP.sendOTP(OTP.otp.text,OTP.username1,context);
                              if(isOTP){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MainDashboard()),
                                );
                              }
                              OTP.otp.clear();
                            },
                          ),
                        ),

                      ]
                  ),
                ),
              ),

            ),
          );
        },

      ),
    );
  }
}
