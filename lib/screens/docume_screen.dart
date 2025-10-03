import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/utils/colors.dart';

class DocumeScreen extends ConsumerStatefulWidget {
  final String id;
  const DocumeScreen({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumeScreenState();
}

class _DocumeScreenState extends ConsumerState<DocumeScreen> {
  final InputBorder field_border = InputBorder.none;

  final TextEditingController doc_name = TextEditingController(
    text: "Untitlled Document",
  );

  QuillController _controller = QuillController.basic();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    doc_name.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhitecolor,
        elevation: 0,
        leadingWidth: 0,
        leading: SizedBox(),
        actions: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.lock, color: Colors.white),
            label: const Text("Share", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
            Image.asset("assets/Images/docs-logo.png", height: 30),
            SizedBox(width: 10),
            SizedBox(
              width: 200,
              child: TextField(
                controller: doc_name,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: field_border,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Toolbar ko scrollable banaya
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: QuillSimpleToolbar(
              controller: _controller,
              config: const QuillSimpleToolbarConfig(),
            ),
          ),

          // Editor ko expand karwaya
          Expanded(
            child: QuillEditor.basic(
              controller: _controller,
              config: const QuillEditorConfig(
                padding: EdgeInsetsGeometry.all(10),
                placeholder: "Having a story in mind ....."
              ),
            ),
          ),
        ],
      ),
    );
  }
}
