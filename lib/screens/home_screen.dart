import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/repositry/auth_repositry.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {

    return Scaffold(
      body: Center(
        child: Text( ref.watch(userProvider)!.email ),
      ),
    );
  }
}