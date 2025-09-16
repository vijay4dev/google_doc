import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/repositry/auth_repositry.dart';
import 'package:google_doc/utils/colors.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {

  void signinwithgoogle(WidgetRef ref){
    ref.read(authprovider).signInWithGoogle();
  }
  
    return  Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10)
            ),
            backgroundColor: kwhitecolor,
            textStyle: TextStyle(
              color: kblack,
              fontSize: 20
            ),
            minimumSize: const Size(150, 80),
          ),
          label: Text("Login With google"),
          icon: Image.asset("assets/Images/g-logo-2.png" , height: 20,),
          onPressed: () => signinwithgoogle(ref)
        ),
      ),
    );
  }
}