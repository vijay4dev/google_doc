import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/models/error_model.dart';
import 'package:google_doc/repositry/auth_repositry.dart';
import 'package:google_doc/screens/home_screen.dart';
import 'package:google_doc/screens/login_screen.dart';
import 'package:google_doc/utils/router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:routemaster/routemaster.dart';

void main() async {

  
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'assets/.env'); // <-- must

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

  ErrorModel? errorModel;

  @override
  void initState() {
    // TODO: implement initState
    getuserdata();
    super.initState();
  }

  void getuserdata()async{
    errorModel = await ref.read(authProvider).getUserData();
    // print("eror model========= ${errorModel!.data}");
    if(errorModel != null && errorModel!.data!= null){
      print("eror model========= ${errorModel!.data}");
        ref.watch(userProvider.notifier).update((state) => errorModel!.data);
    } else{
      print("eror model========= null");
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      routerDelegate: RoutemasterDelegate(routesBuilder: (context){
        final user = ref.watch(userProvider);
        if(user!=null && user.token.isNotEmpty){
          return loggedInroute;
        }
        else{
          return loggedOutroute;
        }
      }),
      routeInformationParser:  RoutemasterParser(),
    );
  }
}