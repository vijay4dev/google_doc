import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/models/doc_model.dart';
import 'package:google_doc/models/error_model.dart';
import 'package:google_doc/repositry/auth_repositry.dart';
import 'package:google_doc/repositry/doc_repo.dart';
import 'package:google_doc/utils/colors.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  void signout_now(WidgetRef ref) {
    ref.read(authProvider).signout();
    ref.read(userProvider.notifier).update((state) => null);
  }

  void createdoc(WidgetRef ref, BuildContext context) async {
    final token = ref.watch(userProvider)!.token;
    final navigation = Routemaster.of(context);
    final snackbar = ScaffoldMessenger.of(context);

    final errorModel = await ref.watch(docrepoprovider).createdoc(token);

    if (errorModel.data != null) {
      navigation.push('/document/${errorModel.data.id}');
    } else {
      snackbar.showSnackBar(SnackBar(content: Text(errorModel.error!)));
    }
  }

  void open_that_doc(BuildContext context, String id) {
    final navigation = Routemaster.of(context);
    navigation.push('/document/${id}');
  }

  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhitecolor,
        actions: [
          IconButton(
            onPressed: () {
              createdoc(ref, context);
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              signout_now(ref);
            },
            icon: Icon(Icons.logout, color: kredcolor),
          ),
        ],
      ),
      body: FutureBuilder<ErrorModel>(
        future: ref
            .watch(docrepoprovider)
            .getmydoc(ref.watch(userProvider)!.token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: snapshot.data!.data.length,
            itemBuilder: (context, index) {
              DocModel document = snapshot.data!.data[index];

              return Column(
                children: [
                  InkWell(
                    onTap: () => open_that_doc(context, document.id),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        document.title,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
