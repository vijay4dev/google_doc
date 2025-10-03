import 'package:flutter/material.dart';
import 'package:google_doc/screens/docume_screen.dart';
import 'package:google_doc/screens/home_screen.dart';
import 'package:google_doc/screens/login_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutroute = RouteMap(routes: {
  "/":(route) => MaterialPage(child: LoginScreen()),
});


final loggedInroute = RouteMap(routes: {
  "/":(route) => MaterialPage(child: HomeScreen()),
  "/document/:id" : (route) => MaterialPage(child: DocumeScreen(id: route.pathParameters['id'] ?? ''))
});