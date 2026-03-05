import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../appDashboard/gridlist.dart';

class VistorAcessProvider extends ChangeNotifier{

  List visitorAccess= [];

  Future<void> isAdmin(String userRole) async{
    if(userRole == "5"){
      visitorAccess= adminVistor;
    }else if(userRole == "10"){
      visitorAccess= onlyinvite;
    }
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