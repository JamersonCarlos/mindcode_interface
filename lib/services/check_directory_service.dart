import 'dart:io' as io;

class ExistsDirectoryService {
  Future<bool> checkDirectory(String path) {
    return io.Directory(path).exists();
  }

  List<io.FileSystemEntity> listDirectory(String path) {
    List<io.FileSystemEntity> list = io.Directory(path).listSync();
    List<io.FileSystemEntity> listDirectory = [];
    List<io.FileSystemEntity> listFile = [];
    for (int i = 0; i < list.length; i++) {
      if (list[i].runtimeType.toString()[1] == "D") {
        listDirectory.add(list[i]);
      } else {
        listFile.add(list[i]);
      }
    }
    listDirectory.sort(
      (a, b) {
        String firstAtribut = a.path.replaceAll('\\', '/').split('/').last;
        String secondAtribut = b.path.replaceAll('\\', '/').split('/').last;
        int comparacao = firstAtribut.compareTo(secondAtribut);
        if (comparacao != 0) {
          return comparacao;
        }
        return firstAtribut.compareTo(secondAtribut);
      },
    );
    listFile.sort(
      (a, b) {
        String firstAtribut = a.path.replaceAll('\\', '/').split('/').last;
        String secondAtribut = b.path.replaceAll('\\', '/').split('/').last;
        int comparacao = firstAtribut.compareTo(secondAtribut);
        if (comparacao != 0) {
          return comparacao;
        }
        return firstAtribut.compareTo(secondAtribut);
      },
    );
    return List.from(listDirectory)..addAll(listFile);
  }
}
