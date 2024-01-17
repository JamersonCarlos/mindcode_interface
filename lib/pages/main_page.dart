import 'package:flutter/material.dart';
import 'dart:io' as io;

import 'package:google_fonts/google_fonts.dart';
import 'package:mindcode_interface/pages/initial_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.path,
    required this.listDirectory,
    required this.listFilter,
  });
  final String path;
  final List<io.FileSystemEntity> listDirectory;
  final List<io.FileSystemEntity> listFilter;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController boxDialog = TextEditingController();
  bool switchButton = false;
  bool isHoverContainer = false;

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

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
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Arquivos Ocultos   ',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFD1C6FF),
                        ),
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: Switch(
                          thumbIcon: thumbIcon,
                          value: switchButton,
                          onChanged: (bool value) {
                            setState(() {
                              switchButton = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: switchButton
                        ? widget.listDirectory.length
                        : widget.listFilter.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: MouseRegion(
                          onEnter: (event) {
                            setState(() {
                              isHoverContainer = true;
                            });
                          },
                          onExit: (event) {
                            setState(() {
                              isHoverContainer = false;
                            });
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                  right: BorderSide(color: Color(0xFFB8A12B))),
                              gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [Color(0xff452ce1), Color(0x59ffffff)],
                              ),
                            ),
                            child: SizedBox(
                              height: 22,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: const EdgeInsets.all(0),
                                ),
                                child: Text(
                                  switchButton
                                      ? widget.listDirectory[index].path
                                          .replaceAll('\\', '/')
                                          .split('/')
                                          .last
                                      : widget.listFilter[index].path
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
