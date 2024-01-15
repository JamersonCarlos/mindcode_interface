import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:io' as io;

import 'package:google_fonts/google_fonts.dart';
import 'package:mindcode_interface/pages/initial_page.dart';

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
            width: MediaQuery.of(context).size.width * 0.15,
            decoration: const BoxDecoration(
              color: Color(0xFF0A0A16),
              border: Border(
                right: BorderSide(
                  width: 1,
                  color: Colors.black,
                ),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  blurRadius: 60,
                  color: Color(0xFFE2ECF9),
                  offset: Offset(0, 0.60),
                )
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 25, bottom: 25, left: 0, right: 0),
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: Color(0xFFC3B4FF),
                      ),
                    ),
                  ),
                  child: Text('MindCode',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFD1C6FF),
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFC3B4FF),
                      ),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InitialPage(),
                          ),
                          (route) => false);
                    },
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Color(0xff473f74),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.search,
                          ),
                        ),
                        Text(
                          'Search File',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFD1C6FF),
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
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
                              widget.listDirectory[index].path
                                  .replaceAll('\\', '/')
                                  .split('/')
                                  .last,
                              style: GoogleFonts.poppins(
                                color: const Color(
                                  0xFFD1C6FF,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
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
