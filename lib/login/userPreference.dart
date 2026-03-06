import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  Future<String> getUser() async {
    final SharedPreferences sd = await SharedPreferences.getInstance();
    String phone = sd.getString("email") ?? '';
    return phone;
  }

  Future<String> getUserId() async {
    final SharedPreferences sd = await SharedPreferences.getInstance();
    String phone = sd.getString("userId") ?? '';
    return phone;
  }

  Future<bool> saveUser(
      String email,
      String password,
      ) async {
    final SharedPreferences sd = await SharedPreferences.getInstance();
    sd.setString('email', email);
    sd.setString('password', password);
    return true;
  }

  Future<bool> logout() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
    return true;
  }
}