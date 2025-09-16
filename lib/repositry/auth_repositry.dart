import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authprovider = Provider((ref) => AuthRepositry(googlesignin: GoogleSignIn()));

class AuthRepositry {
  final GoogleSignIn _googlesignin;
  AuthRepositry({
    required GoogleSignIn googlesignin,
  }) : _googlesignin = googlesignin; 
  

  void signInWithGoogle() async {
    try { 

      final user = await _googlesignin.signIn();

      if(user != null){
        print(user.email);
        print(user.displayName);
      }
      
    } catch (e) {
      print(e.toString());
    }
  }

}
