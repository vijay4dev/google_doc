import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/models/doc_model.dart';
import 'package:google_doc/models/error_model.dart';
import 'package:google_doc/utils/constants.dart';
import 'package:http/http.dart';

final docrepoprovider = Provider((ref) => DocRepo(client: Client()));

class DocRepo {
  final Client _client;
  DocRepo({required Client client}) : _client = client;

  Future<ErrorModel> createdoc(String token) async {
    ErrorModel errorModel = ErrorModel(
      error: "Something unexpected ocur",
      data: null,
    );

    try {
      var res = await _client.post(
        Uri.parse('$host/doc/create'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
        body: jsonEncode({'createdAt': DateTime.now().millisecondsSinceEpoch}),
      );

      switch (res.statusCode) {
        case 200:
          errorModel = ErrorModel(
            error: null,
            data: DocModel.fromJson(res.body),
          );

          break;
        default:
          errorModel = ErrorModel(error: res.body, data: null);
          break;
      }
    } catch (e) {
      errorModel = ErrorModel(error: e.toString(), data: null);
    }

    return errorModel;
  }

  Future<ErrorModel> getmydoc(String token) async {
    ErrorModel errorModel = ErrorModel(
      error: "Something unexpected ocur",
      data: null,
    );

    try {
      var res = await _client.post(
        Uri.parse('$host/docs/me'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      switch (res.statusCode) {
        case 200:
          List<DocModel> documents = [];
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            documents.add(
              DocModel.fromJson(jsonEncode(jsonDecode(res.body)[i])),
            );
          }
          errorModel = ErrorModel(error: null, data: documents);

          break;
        default:
          errorModel = ErrorModel(error: res.body, data: null);
          break;
      }
    } catch (e) {
      errorModel = ErrorModel(error: e.toString(), data: null);
    }

    return errorModel;
  }

  Future<ErrorModel> opendoc(String token, String docid) async {
    ErrorModel errorModel = ErrorModel(
      error: "Something unexpected ocur",
      data: null,
    );

    try {
      var res = await _client.post(
        Uri.parse("$host/doc/$docid"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      switch (res.statusCode) {
        case 200:
          errorModel = ErrorModel(
            error: null,
            data: DocModel.fromJson(res.body),
          );
          break;
        default:
          errorModel = ErrorModel(error: res.body, data: null);
          break;
      }
    } catch (e) {
      errorModel = ErrorModel(error: e.toString(), data: null);
    }

    return errorModel;
  }
}
