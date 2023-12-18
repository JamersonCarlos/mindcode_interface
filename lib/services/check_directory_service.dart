import 'dart:io' as io;

class ExistsDirectoryService {
  Future<bool> checkDirectory(String path) {
    return io.Directory(path).exists();
  }

  List<io.FileSystemEntity> listDirectory(String path) {
    List<io.FileSystemEntity> list = io.Directory(path).listSync();
    list.removeWhere((element) => element.uri.toString().contains('.'));
    return list;
  }
}
