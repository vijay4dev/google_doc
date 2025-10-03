import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/utils/colors.dart';

class DocumeScreen extends ConsumerStatefulWidget {
  final String id;
  const DocumeScreen({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumeScreenState();
}

class _DocumeScreenState extends ConsumerState<DocumeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhitecolor,
        elevation: 0,
        actions: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.lock, color: Colors.white),
            label: const Text("Share", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 5 , horizontal: 10),
              backgroundColor: Colors.blue, // sky blue background
              elevation: 0, // remove elevation
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4), // radius 4
              ),
            ),
          ),
        ],
        title: Row(
          children: [
            Image.asset("assets/Images/docs-logo.png" , height: 30,),
            SizedBox(width: 10,),
            
          ],
        ),
      ),
    );
  }
}
