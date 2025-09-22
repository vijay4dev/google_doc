import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepo {
  void set_token(String Token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("x-auth-token", Token);
  }

  Future<String?> get_token()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString("x-auth-token");
    return token;
  }
}