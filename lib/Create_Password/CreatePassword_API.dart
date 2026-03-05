import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/colors.dart';
import 'Create_Password.dart';

TextEditingController username= TextEditingController();
TextEditingController password= TextEditingController();
TextEditingController confirmPassword= TextEditingController();

void clearController(){
  username.clear();
  password.clear();
  confirmPassword.clear();
}

Future<bool> createNewPassword(String username, String password) async{

  String url= "http://111.223.92.154:8091/staff_password_change/staff_password_change.php";

  try {
    // Send the POST request with form-data (not JSON)
    var response = await http.post(
      Uri.parse(url),
      body: {
        'email': username,
        'password': password,
      },
    );

    var responseBody = jsonDecode(response.body);
    // Check if the response is successful
    if (response.statusCode == 200 && responseBody['message_type']!='error') {
      debugPrint(response.body.toString());
      final savePassword= await SharedPreferences.getInstance();
      savePassword.setString("email", username);
      savePassword.setString("newPassword", password);

      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 3),
          content: Text('Password updated successfully' , style: GoogleFonts.poppins(
            color: kDarkblueColor,
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
          )),
        ),
      );
      await Future.delayed(const Duration(seconds: 2));
      return true;
    } else if(response.statusCode == 200 && responseBody['message_type']=='error'){
      debugPrint('Failed: ${response.body}');
      scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 3),
          content: Text('Please check your username' , style: GoogleFonts.poppins(
            color: kDarkblueColor,
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
          )),
        ),
      );
      await Future.delayed(const Duration(seconds: 2));
      return false;
    }
    return false;
  } catch (e) {
    print('Error: $e');
    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 3),
        content: Text(
          'An error occurred. Please try again later.',
          style: GoogleFonts.poppins(
            color: kDarkblueColor,
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
          ),
        ),
      ),
    );
    return false;
  }
}