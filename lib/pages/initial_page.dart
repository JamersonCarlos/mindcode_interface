import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;

import 'package:mindcode_interface/pages/main_page.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _initialPageState();
}

class _initialPageState extends State<InitialPage> {
  final TextEditingController submitPath = TextEditingController();
  bool existsDirectory = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/img/background.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Image.asset(
            'assets/img/logo.png',
            alignment: Alignment.topLeft,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    '  Digite o caminho do diretório do projeto: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextField(
                    controller: submitPath,
                    onEditingComplete: () => {checkExistDirectory()},
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                    autofocus: true,
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: (() {
                            checkExistDirectory();
                          }),
                          child: const Icon(
                            Icons.keyboard_arrow_right,
                            size: 40,
                            color: Colors.blueAccent,
                          ),
                        ),
                        errorText:
                            existsDirectory ? null : 'Diretório não existe',
                        errorStyle: const TextStyle(color: Colors.redAccent),
                        hintText: 'C:/users/jcenv',
                        hintStyle: const TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        prefixText: 'Path: ',
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void checkExistDirectory() {
    if (io.Directory(submitPath.text.toString()).existsSync()) {
      existsDirectory = true;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
    } else {
      setState(() {
        existsDirectory = false;
      });
    }
  }
}
