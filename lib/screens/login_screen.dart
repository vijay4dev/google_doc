import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/repositry/auth_repositry.dart';
import 'package:google_doc/screens/home_screen.dart';
import 'package:routemaster/routemaster.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  void signInWithGoogle(WidgetRef ref, BuildContext context) async {
    final errorModel = await ref.read(authProvider).signInWithGoogle();

    if (!context.mounted) return; // ensures widget still alive

    final naviagtion = Routemaster.of(context);

    if (errorModel.error == null) {
      // update user state
      ref.read(userProvider.notifier).update((state) => errorModel.data);

      // show success dialog
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.black,
          content: Text("sign in ✅" , style: TextStyle(color: Colors.white),), actions: [
            TextButton(onPressed: null, child: Text('DISMISS')),
          ]
        )
      );
      naviagtion.replace("/");
    } else {
      // show error snackb
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorModel.error!)),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => signInWithGoogle(ref, context),
          icon: const Icon(Icons.login),
          label: const Text(
            'Sign in with Google',
            style: TextStyle(color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size(150, 50),
          ),
        ),
      ),
    );
  }
}
