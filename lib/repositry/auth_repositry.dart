import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_doc/models/error_model.dart';
import 'package:google_doc/models/usermodel.dart';
import 'package:google_doc/utils/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

final authprovider = Provider(
  (ref) => AuthRepositry(googlesignin: GoogleSignIn(), client: Client()),
);
final userProvider = StateProvider<Usermodel?>((ref) => null);

class AuthRepositry {
  final GoogleSignIn _googlesignin;
  final Client _client;
  AuthRepositry({required GoogleSignIn googlesignin, required Client client})
    : _googlesignin = googlesignin,
      _client = client;

  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel error = ErrorModel(
      error: "some thing wrong occured ❌ in login ",
      data: null,
    );
    try {
      final user = await _googlesignin.signIn();

      if (user != null) {
        final googleAuth = await user.authentication;
        final idToken = googleAuth.idToken;

        if (idToken == null) {
          throw 'ID token is null';
        }
        final useracc = Usermodel(
          pfp: user.photoUrl!,
          name: user.displayName!,
          email: user.email,
          token: ' ',
          uid: ' ',
        );

        // _client.post()

        var res = await _client.post(
          Uri.parse('${host}/api/signup'),
          body: useracc.toJson(),
          headers: {'Content-Type': 'application/json', 'charset': "UTF-8"},
        );

        switch (res.statusCode) {
          case 200:
            final newuser = useracc.copyWith(
              uid: jsonDecode(res.body)['user']['_id'],
            );
            error = ErrorModel(error: null, data: null);
            break;
          default:
            throw 'some error occured $res';
        }
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }
}
