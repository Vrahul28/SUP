
import 'package:flutter/cupertino.dart';
import '../../appDashboard/gridlist.dart';


class ApplicationDashboardProvider extends ChangeNotifier{

  List lists= admin_1;

  void isAdmin(String userRole){
    // if(userRole == "5"){
    //   lists= admin_1;
    // }else if(userRole == "10"){
    //   lists= staff_1;
    // }
  }


  // void alllist(TextEditingController controller) async{
  //   lists= admin_1;
  //   final newuser= await SharedPreferences.getInstance();
  //   String? user= newuser.getString("email");
  //   print(user);
  //   if(controller.text == user){
  //     lists= staff_1;
  //     notifyListeners();
  //   }else if(controller.text == "admin@gmail.com"){
  //     lists= admin_1;
  //     notifyListeners();
  //   }else if(controller.text == "ara@gmail.com"){
  //     lists= staff_1;
  //     notifyListeners();
  //   }else if(controller.text == "lim@gmail.com"){
  //     lists= vistors_1;
  //     notifyListeners();
  //   }
  //
  // }

}