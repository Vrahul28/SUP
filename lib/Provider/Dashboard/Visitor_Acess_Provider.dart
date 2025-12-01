import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../appDashboard/gridlist.dart';

class VistorAcessProvider extends ChangeNotifier{

  List visitorAccess= adminVistor;

  void isAdmin(String userRole){
    // if(userRole == "5"){
    //   VisitorAcess= adminVistor;
    // }else if(userRole == "10"){
    //   VisitorAcess= onlyinvite;
    // }
  }

  // void list(TextEditingController controller) async{
  //   final staff= await SharedPreferences.getInstance();
  //   String? staffEmail= staff.getString("email");
  //
  //   if(controller.text == staffEmail){
  //     VisitorAcess= onlyinvite;
  //     notifyListeners();
  //   }else if(controller.text == "admin@gmail.com"){
  //     VisitorAcess= adminVistor;
  //     notifyListeners();
  //   }else if(controller.text == "ara@gmail.com"){
  //     VisitorAcess= onlyinvite;
  //     notifyListeners();
  //   }else if(controller.text == "lim@gmail.com"){
  //     VisitorAcess= onlyinvite;
  //     notifyListeners();
  //   }
  // }

}