import 'package:acp/Provider/Login/Login_Provider.dart';
import 'package:acp/appDashboard/dashboard2/dashboard2.dart';
import 'package:acp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Create_Password/Create_Password.dart';
import 'OTP_Page.dart';
import 'Provider/Dashboard/Total_Count_Provider.dart';
import 'Provider/Staff/Staff_Provider.dart';
import 'appDashboard/dashboard/dashboard.dart';

final TextEditingController usernameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String username1;
  late String password1;
  bool passwordVisible=false;
  bool showdialogip=true;
  final  scaffoldMessengerLoginKey = GlobalKey<ScaffoldMessengerState>();
  void initState() {
    super.initState();
    passwordVisible = true;
    // checkSavedCredentials();
  }

  @override
  Widget build(BuildContext context) {
    final loginMethod= Provider.of<LoginProvider>(context, listen: false);
    return PopScope(
      canPop: false,
      child: ScaffoldMessenger(
        key: scaffoldMessengerLoginKey,
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
                          TextField(
                            style: GoogleFonts.poppins(
                              color: kDarkblueColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                            ),
                            cursorColor: kDarkblueColor,
                            controller: usernameController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(18.0),
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(
                                  Icons.person,
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
                                hintText: 'Username',
                                hintStyle: GoogleFonts.poppins(
                                  color: kDarkblueColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                )
                            ),
                          ),
                          SizedBox(height: 20.0),
                          TextField(
                            cursorColor: Colors.white,
                            obscureText: passwordVisible,
                            style: GoogleFonts.poppins(
                              color: kDarkblueColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                            ),
                            controller: passwordController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(18.0),
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(
                                Icons.lock,
                                size: 24.0,
                                color: kDarkblueColor,
                              ),
                              border: OutlineInputBorder(),
                              hintText: 'Password',
                              hintStyle: GoogleFonts.poppins(
                                color: kDarkblueColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0,
                              ),
                              suffixIcon: IconButton(
                                color: kDarkblueColor,
                                icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: kGinColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: kDarkblueColor),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CreatePassword()));
                                },
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                      Colors.amber),
                                ),
                                child: Text(
                                  'Create Password',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              border: Border.all(color: Colors.white, width: 2), // Customize the border color and width
                            ),
                            child: MaterialButton(
                              height: 50.0,
                              minWidth: 150.0,
                              color: kDarkblueColor,
                              child: Text("Login",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                ),
                              ),
                              onPressed: ()  async{
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return const Dashboard2();
                                    })
                                );
                                // bool isLogin= await loginMethod.loginAdmin(usernameController.text, passwordController.text, context);
                                // if(isLogin){
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(builder: (context) {
                                //         return const OtpPage();
                                //       })
                                //   );
                                //   await Provider.of<TotalCountProvider>(context, listen: false).getTotalCompanies();
                                //   await Provider.of<StaffProvider>(context,listen: false).getAllStaffList("", "");
                                // }
                              }
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
      ),
    );
  }
}


