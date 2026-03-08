import 'package:acp/Provider/Login/Login_Provider.dart';
import 'package:acp/appDashboard/main_dashboard/main_dashboard.dart';
import 'package:acp/utils/colors.dart';
import 'package:acp/utils/imagesString.dart';
import 'package:acp/widget/custom_textfields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Create_Password/Create_Password.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisible=false;
  final  scaffoldMessengerLoginKey = GlobalKey<ScaffoldMessengerState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
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
              body: Form(
                key: _formKey,
                child: SizedBox(
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
                             ImagesString.loginPageImage,
                              height: 100,
                              width: 200,
                            ),
                            CustomUsernameTextFields(
                                controller: loginMethod.usernameController,
                                hint: 'Username',
                              icon: Icons.person,
                              hidden: false,
                            ),
                            SizedBox(height: 20.0),
                            CustomUsernameTextFields(
                              controller: loginMethod.passwordController,
                              hint: 'Password',
                              icon: Icons.lock,
                              hidden: passwordVisible,
                              suffixIcon: IconButton(
                                color: kDarkblueColor,
                                icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
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
                              child: Consumer<LoginProvider>(
                                builder: (context, value, child) {
                                  return MaterialButton(
                                      height: 50.0,
                                      minWidth: 150.0,
                                      color: kDarkblueColor,
                                      child: value.isLoading?
                                      CircularProgressIndicator(
                                        color: Colors.white,
                                      ):
                                      Text("Login",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      onPressed: ()  async{
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          await value.loginAdmin(
                                              value.usernameController.text,
                                              value.passwordController.text,
                                              context
                                          );
                                        }
                                      }
                                  );
                                },
                              ),
                            )
                          ]
                      ),
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


