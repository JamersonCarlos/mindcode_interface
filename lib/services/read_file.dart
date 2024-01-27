import 'dart:io';

class ReadFile {
  Future<List<List<String>>> readFiles(path) async {
    try {
      List<FileSystemEntity> arquivos = Directory(path!).listSync();
      List<List<String>> conteudoArquivos = [];

      // Iterar sobre os arquivos

      for (FileSystemEntity arquivo in arquivos) {
        if (arquivo is File) {
          // Se for um arquivo, você pode ler o conteúdo
          String conteudo = await arquivo.readAsString();
          conteudoArquivos.add([arquivo.path, conteudo]);
        }
      }

      return conteudoArquivos;
    } on Exception {
      print(Exception);
      return [];
    }
  }
}
