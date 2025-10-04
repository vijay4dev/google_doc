import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/models/doc_model.dart';
import 'package:google_doc/models/error_model.dart';
import 'package:google_doc/repositry/auth_repositry.dart';
import 'package:google_doc/repositry/doc_repo.dart';
import 'package:google_doc/repositry/socket_repo.dart';
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
    text: "Untitle Document",
  );

  QuillController _controller = QuillController.basic();

  ErrorModel? errorModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    fetchdocumentdata();

  }

  void fetchdocumentdata() async {
    errorModel = await ref.read(docrepoprovider).getDocumentById(ref.watch(userProvider)!.token, widget.id);

    if(errorModel!.data != null){
      doc_name.text = (errorModel!.data as DocModel).title;
      setState(() {
        
      });
    }

  }

  void updatetitle(WidgetRef ref, String title) {
    ref
        .read(docrepoprovider)
        .updatetitle(ref.watch(userProvider)!.token, widget.id, title);
  }

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kwhitecolor,
        elevation: 0,
        leadingWidth: 0,
        leading: SizedBox(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.lock, color: Colors.black),
              label: const Text("Share", style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                backgroundColor: Colors.blue.withOpacity(
                  0.6,
                ), // sky blue background
                elevation: 0, // remove elevation
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4), // radius 4
                ),
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
                onSubmitted: (value) => updatetitle(ref, value),
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
                placeholder: "Having a story in mind .....",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
