import 'dart:io' as io;

class ExistsDirectoryService {
  Future<bool> checkDirectory(String path) {
    return io.Directory(path).exists();
  }
}
