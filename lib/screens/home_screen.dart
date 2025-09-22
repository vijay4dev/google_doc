import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/repositry/auth_repositry.dart';
import 'package:google_doc/utils/colors.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override

    void signout_now( WidgetRef ref ){
      ref.read(authProvider).signout();
      ref.read(userProvider.notifier).update((state) => null);
    }

  Widget build(BuildContext context , WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhitecolor,
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Icons.add)),
          IconButton(onPressed: (){
            signout_now(ref);
          }, icon: Icon(Icons.logout , color:kredcolor,))
        ],
      ),
      body: Center(
        child: Text( ref.watch(userProvider)!.name ),
      ),
    );
  }
}