import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:google_doc/models/error_model.dart';
import 'package:google_doc/models/usermodel.dart';
import 'package:google_doc/utils/constants.dart';

// AuthRepository provider
final authProvider = Provider<AuthRepository>((ref) {
  final googleSignIn = kIsWeb
      ? GoogleSignIn(
          scopes: ['email', 'profile'],
          clientId: dotenv.env['WEB_CLIENT_ID'] ?? '',
        )
      : GoogleSignIn(scopes: ['email', 'profile']);
  return AuthRepository(googleSignIn: googleSignIn, client: Client());
});

// User state
final userProvider = StateProvider<Usermodel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;

  AuthRepository({required GoogleSignIn googleSignIn, required Client client})
      : _googleSignIn = googleSignIn,
        _client = client;

  // Google sign-in function
  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel error = ErrorModel(error: 'Some unexpected error occurred.', data: null);

    try {

      print("Starting Google SignIn...");
      final user = await _googleSignIn.signIn();
      print("User: $user");

      if (user != null) {
        final userAcc = Usermodel(
          email: user.email,
          name: user.displayName ?? '',
          pfp: user.photoUrl ?? '',
          uid: '',
          token: '',
        );
         
         // ...existing code...
        final payload = userAcc.toJson();
        print('payload.runtimeType => ${payload.runtimeType}');
        print('payload => $payload');

        final bodyToSend = payload is String ? payload : jsonEncode(payload);

        final res = await _client.post(
          Uri.parse('${host}/api/signup'),
          body: bodyToSend, // <- send raw JSON string or encoded map
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        );

        print("resss => status:${res.statusCode} body:${res.body}");
 // ...existing code...
        

        if (res.statusCode == 200) {
          final newUser = userAcc.copyWith(
            uid: jsonDecode(res.body)['user']['_id'],
            token: jsonDecode(res.body)['token'],
          );
          error = ErrorModel(error: null, data: newUser);
        } else {
          error = ErrorModel(error: 'Server error: ${res.statusCode}', data: null);
        }
      } else {
        print("rnulllll");
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }

    return error;
  }
}
