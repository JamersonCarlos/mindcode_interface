import 'package:flutter/material.dart';
import 'dart:io' as io;

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.path, required this.listDirectory});
  final String path;
  final List<io.FileSystemEntity> listDirectory;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController boxDialog = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 1,
                  color: Colors.black,
                ),
              ),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: widget.listDirectory.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Container(
                    width: 120,
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 1,
                      color: Colors.black,
                    )),
                    child: Center(
                      child: Text(
                          '${widget.listDirectory[index].path.replaceAll('\\', '/').split('/').last}'),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: const Color(0xffd9d9d9),
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                          child: const Center(
                            child: Text('Problemas de código'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: const Color(0xffd9d9d9),
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                          child: const Center(
                            child: Text('Overview'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: const Color(0xffd9d9d9),
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                          child: const Center(
                            child: Text('Funcionalidades'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: const Color(0xffd9d9d9),
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                          child: const Center(
                            child: Text('Arquitetura'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: const Color(0xffd9d9d9),
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                          child: const Center(
                            child: Text('Requisitos Técnicos'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextField(
                      controller: boxDialog,
                      decoration: const InputDecoration(
                        hintText: 'Message MindCode',
                        suffixIcon: Icon(
                          Icons.next_week,
                          size: 30,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        errorBorder: null,
                        focusedErrorBorder: null,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
