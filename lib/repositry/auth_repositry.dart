import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_doc/repositry/local_storage_repo.dart';
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
  return AuthRepository(googleSignIn: googleSignIn, client: Client() , localstoragerepo: LocalStorageRepo());
});

// User state
final userProvider = StateProvider<Usermodel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;

  final LocalStorageRepo _localStorageRepo;

  AuthRepository({required GoogleSignIn googleSignIn, required Client client, required LocalStorageRepo localstoragerepo})
      : _googleSignIn = googleSignIn,
        _client = client, 
        _localStorageRepo = localstoragerepo;

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
          _localStorageRepo.set_token(newUser.token);

          error = ErrorModel(error: null, data: newUser);
        } else {
          error = ErrorModel(error: 'Server error: ${res.statusCode} ${res.body}', data: null);
        }
      } else {
        print("rnulllll");
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }

    return error;
  }
  Future<ErrorModel> getUserData() async {
    ErrorModel error = ErrorModel(
      error: 'Some unexpected error occurred.',
      data: null,
    );
    try {
      String? token = await _localStorageRepo.get_token();

      if (token != null) {
        var res = await _client.get(Uri.parse('$host/'), headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        });
        print("res[omnse codeweee] ==> ${res.body}");
        switch (res.statusCode) {
          case 200:
            final body = jsonDecode(res.body);
            print(" user ==> ${body}");
            final newUser = Usermodel.fromMap(body['user']).copyWith(token: body['token']);
            print("new user ${newUser.token}");
            error = ErrorModel(error: null, data: newUser);
            _localStorageRepo.set_token(newUser.token);
            break;
        }
      }
    } catch (e) {
      error = ErrorModel(
        error: e.toString(),
        data: null,
      );
    }
    return error;
  }

  void signout() async {
    _localStorageRepo.set_token('');
  }
}
