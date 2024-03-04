import 'dart:async';

import 'package:dio/dio.dart';

class ServiceLlamaApi {
  final Uri url = Uri.parse('http://localhost:11434/api/generate');
  StreamController<String> _streamController = StreamController<String>();

  Future<String> methodName({required String question}) async {
    var response;
    try {
      await Dio().post(
        url.toString(),
        data: {"model": "codellama:7b", "prompt": question, "stream": false},
      );
      _streamController.add(response.data["response"]);
      return response.data["response"];
    } catch (e) {
      print(e);
    }
    return "error";
  }
}
