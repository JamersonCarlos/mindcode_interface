import 'package:dio/dio.dart';

class ExistsDirectoryService {
  final dio = Dio();
  final String baseUrl = "http://10.0.2.2:8000/";

  Future<Map<String, dynamic>> checkDirectory(String path) async {
    final result =
        await dio.post("${baseUrl}checkdirectory", data: {'path': path});
    return result.data;
  }
}
