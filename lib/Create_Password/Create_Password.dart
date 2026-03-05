import 'package:acp/utils/Textform_field.dart';
import 'package:acp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'CreatePassword_API.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  @override
  void dispose() {
    username.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kDarkblueColor,
              title: Text("Create Password",
                  style: GoogleFonts.poppins(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CustomTextfield(
                    controller: username,
                    hinttext: 'Username',
                    Icons:  Icons.mail_outline,
                    errorMsg: 'User name requried',
                    lines: 1,
                    obsuretext: false,
                  ),
                  const SizedBox(height: 10),
                  CustomTextfield(
                    controller: password,
                    hinttext: 'New Password',
                    Icons:  Icons.password,
                    errorMsg: 'Password requried',
                    lines: 1,
                    obsuretext: false,
                  ),
                  const SizedBox(height: 10),
                  CustomTextfield(
                    controller: confirmPassword,
                    hinttext: 'Confirm Password',
                    Icons:  Icons.password,
                    errorMsg: '',
                    lines: 1,
                    obsuretext: true,
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: (MediaQuery.of(context).size.height*0.07),
                    child: ElevatedButton(
                      onPressed: () async{
                        bool isSuccess= await createNewPassword(username.text, password.text);
                        if(isSuccess){
                          clearController();
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kDarkblueColor,
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: Text("Submit",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
